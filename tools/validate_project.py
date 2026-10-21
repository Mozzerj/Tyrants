#!/usr/bin/env python3
"""Lightweight Tyrants mission integrity checks.

This is not an SQF compiler. It catches the failures that were common in the old
project: broken script paths, unregistered TYR functions, unwhitelisted remote
endpoints, unbalanced delimiters, and accidental client-side GameData writes.
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SQF_FILES = sorted(ROOT.rglob("*.sqf"))
TEXT_FILES = SQF_FILES + [ROOT / "description.ext", ROOT / "Dialogs.hpp", ROOT / "Functions" / "cfgFunctions.hpp"]

errors: list[str] = []
warnings: list[str] = []


def rel(path: Path) -> str:
    return path.relative_to(ROOT).as_posix()


def strip_comments(text: str) -> str:
    # Preserve quoted strings while discarding // and /* */ comments.
    out: list[str] = []
    i = 0
    in_string = False
    while i < len(text):
        ch = text[i]
        if in_string:
            out.append(ch)
            if ch == '"':
                if i + 1 < len(text) and text[i + 1] == '"':
                    out.append(text[i + 1])
                    i += 2
                    continue
                in_string = False
            i += 1
            continue
        if ch == '"':
            in_string = True
            out.append(ch)
            i += 1
            continue
        if text.startswith("//", i):
            end = text.find("\n", i)
            if end < 0:
                break
            out.append("\n")
            i = end + 1
            continue
        if text.startswith("/*", i):
            end = text.find("*/", i + 2)
            if end < 0:
                errors.append("unterminated block comment")
                break
            out.append("\n" * text[i:end + 2].count("\n"))
            i = end + 2
            continue
        out.append(ch)
        i += 1
    return "".join(out)


def check_balance(path: Path) -> None:
    text = strip_comments(path.read_text(errors="replace"))
    stack: list[tuple[str, int]] = []
    pairs = {')': '(', ']': '[', '}': '{'}
    line = 1
    in_string = False
    i = 0
    while i < len(text):
        ch = text[i]
        if ch == "\n":
            line += 1
        if in_string:
            if ch == '"':
                if i + 1 < len(text) and text[i + 1] == '"':
                    i += 2
                    continue
                in_string = False
            i += 1
            continue
        if ch == '"':
            in_string = True
        elif ch in "([{":
            stack.append((ch, line))
        elif ch in ")]}":
            if not stack or stack[-1][0] != pairs[ch]:
                errors.append(f"{rel(path)}:{line}: unmatched {ch}")
                return
            stack.pop()
        i += 1
    if in_string:
        errors.append(f"{rel(path)}: unterminated string")
    if stack:
        opener, opener_line = stack[-1]
        errors.append(f"{rel(path)}:{opener_line}: unclosed {opener}")


for path in TEXT_FILES:
    if path.exists():
        check_balance(path)

# Script path references.
path_pattern = re.compile(r'''(?:execVM|preprocessFileLineNumbers|preprocessFile)\s+["']([^"']+)["']''', re.I)
for path in SQF_FILES + [ROOT / "Dialogs.hpp"]:
    text = path.read_text(errors="replace")
    for match in path_pattern.finditer(text):
        target = ROOT / match.group(1).replace("\\", "/")
        if not target.exists():
            errors.append(f"{rel(path)}: missing script reference {match.group(1)}")

# Registered CfgFunctions vs references.
cfg_text = (ROOT / "Functions" / "cfgFunctions.hpp").read_text(errors="replace")
registered = {
    f"TYR_fnc_{name}"
    for name in re.findall(r"\bclass\s+([A-Za-z0-9_]+)\s*\{\s*\};", cfg_text)
}
used: set[str] = set()
for path in TEXT_FILES:
    text = path.read_text(errors="replace")
    used.update(re.findall(r"\bTYR_fnc_[A-Za-z0-9_]+\b", text))
for name in sorted(used - registered):
    errors.append(f"unregistered function reference: {name}")

# Every registered project function should have a corresponding file.
for name in sorted(registered):
    short = name.removeprefix("TYR_fnc_")
    expected = ROOT / "Functions" / f"fn_{short}.sqf"
    if not expected.exists():
        # Windows/Arma paths are case-insensitive; accept a case-insensitive match.
        matches = [p for p in (ROOT / "Functions").glob("fn_*.sqf") if p.name.lower() == expected.name.lower()]
        if not matches:
            errors.append(f"registered function has no file: {name}")

# Remote functions must be explicitly allowed when Functions mode=1.
desc = (ROOT / "description.ext").read_text(errors="replace")
remote_calls: set[str] = set()
for path in SQF_FILES:
    text = path.read_text(errors="replace")
    remote_calls.update(re.findall(r'''remoteExec(?:Call)?\s*\[\s*["'](TYR_fnc_[A-Za-z0-9_]+)["']''', text))
whitelist = set(re.findall(r"class\s+(TYR_fnc_[A-Za-z0-9_]+)\s*\{", desc))
for name in sorted(remote_calls - whitelist):
    errors.append(f"remote endpoint not whitelisted in description.ext: {name}")

# Client scripts must not mutate the authoritative GameData structure.
mutation_re = re.compile(r"GameData[^\n;]*(?:\bset\s*\[|\bpushBack(?:Unique)?\b|\bdeleteAt\b)", re.I)
for path in SQF_FILES:
    r = rel(path)
    if r == "initServer.sqf" or r.startswith("GameUpdate/") or r.startswith("Functions/fn_Server") or r == "Functions/fn_FactoryUpdate.sqf" or r == "Functions/fn_VehicleUpdate.sqf":
        continue
    text = strip_comments(path.read_text(errors="replace"))
    if mutation_re.search(text):
        errors.append(f"client/shared script appears to mutate GameData: {r}")

# Old superseded paths should stay gone.
for obsolete in ["Init", "Setup/player", "Functions/DialogFunctions"]:
    if (ROOT / obsolete).exists():
        warnings.append(f"obsolete path still exists: {obsolete}")

# Dialog IDDs should be unique.
dialog_text = (ROOT / "Dialogs.hpp").read_text(errors="replace")
idds = re.findall(r"\bidd\s*=\s*(-?\d+)\s*;", dialog_text)
positive = [x for x in idds if int(x) >= 0]
for value in sorted(set(positive)):
    if positive.count(value) > 1:
        errors.append(f"duplicate dialog idd: {value}")

print(f"Checked {len(SQF_FILES)} SQF files and core config files.")
print(f"Registered TYR functions: {len(registered)}; referenced: {len(used)}; remote endpoints: {len(remote_calls)}.")
if warnings:
    for item in warnings:
        print(f"WARNING: {item}")
if errors:
    for item in errors:
        print(f"ERROR: {item}")
    print(f"FAILED with {len(errors)} error(s).")
    sys.exit(1)
print("PASS: static foundation checks found no integrity errors.")
