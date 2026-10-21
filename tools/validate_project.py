#!/usr/bin/env python3
"""Static integrity checks for the Tyrants v4 rewrite.

This is intentionally not an SQF compiler. It checks architecture invariants,
packaging paths, CfgFunctions registration, RemoteExec exposure, dialog wiring,
persistence isolation, legacy-state regressions, three-faction mission slots and
basic delimiter/string integrity.
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SRC_EXTS = {".sqf", ".hpp", ".ext", ".h", ".sqm"}
SOURCE_FILES = sorted(p for p in ROOT.rglob("*") if p.is_file() and p.suffix.lower() in SRC_EXTS)
SQF_FILES = sorted(ROOT.rglob("*.sqf"))
HPP_FILES = sorted(ROOT.rglob("*.hpp"))
errors: list[str] = []
warnings: list[str] = []


def rel(path: Path) -> str:
    return path.relative_to(ROOT).as_posix()


def read(path: Path) -> str:
    return path.read_text(encoding="utf-8", errors="replace")


def strip_comments(text: str) -> str:
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
                out.append(text[i:])
                break
            out.append("\n" * text[i:end + 2].count("\n"))
            i = end + 2
            continue
        out.append(ch)
        i += 1
    return "".join(out)


def check_balance(path: Path) -> None:
    text = strip_comments(read(path))
    stack: list[tuple[str, int]] = []
    pair = {")": "(", "]": "[", "}": "{"}
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
        elif ch in ")]}" :
            if not stack or stack[-1][0] != pair[ch]:
                errors.append(f"{rel(path)}:{line}: unmatched {ch}")
                return
            stack.pop()
        i += 1
    if in_string:
        errors.append(f"{rel(path)}: unterminated string")
    if stack:
        errors.append(f"{rel(path)}:{stack[-1][1]}: unclosed {stack[-1][0]}")


for p in SOURCE_FILES:
    check_balance(p)

# All quoted includes must exist relative to either the current file or mission root.
inc_re = re.compile(r'#include\s+["\']([^"\']+)["\']', re.I)
for p in SOURCE_FILES:
    for inc in inc_re.findall(read(p)):
        candidate_local = p.parent / inc.replace("\\", "/")
        candidate_root = ROOT / inc.replace("\\", "/")
        if not candidate_local.exists() and not candidate_root.exists():
            errors.append(f"{rel(p)}: missing #include target {inc}")

# The rewrite must not go back to script-path dispatch.
for p in SOURCE_FILES:
    text = strip_comments(read(p))
    if re.search(r"\bexecVM\b", text, re.I):
        errors.append(f"raw execVM path reintroduced: {rel(p)}")

# Parse CfgFunctions with its file blocks and require exact backing files.
cfg = read(ROOT / "cfgFunctions.hpp")
registered: dict[str, Path] = {}
current_dir: str | None = None
for line in cfg.splitlines():
    m = re.search(r'\bfile\s*=\s*"([^"]+)"\s*;', line)
    if m:
        current_dir = m.group(1)
    m = re.search(r'\bclass\s+([A-Za-z0-9_]+)\s*\{\s*\};', line)
    if m and current_dir:
        fn = f"TYR_fnc_{m.group(1)}"
        registered[fn] = ROOT / current_dir / f"fn_{m.group(1)}.sqf"
for fn, path in registered.items():
    if not path.exists():
        errors.append(f"registered function has no file: {fn} -> {rel(path)}")

used: set[str] = set()
for p in SOURCE_FILES:
    used.update(re.findall(r"\bTYR_fnc_[A-Za-z0-9_]+\b", read(p)))
for fn in sorted(used - set(registered)):
    errors.append(f"unregistered function reference: {fn}")

# RemoteExec: every TYR function used remotely must be explicit, and server/client
# directions must match the v4 naming convention.
desc = read(ROOT / "description.ext")
# Map dialogs must import the engine RscMapControl definition rather than
# forward-declare an empty mission-local class, otherwise embedded maps can
# render as a blank/black control.
if not re.search(r"^\s*import\s+RscMapControl\s*;", desc, re.M):
    errors.append("description.ext must import the engine RscMapControl base class")
if re.search(r"^\s*class\s+RscMapControl\s*;", desc, re.M):
    errors.append("description.ext must not forward-declare an empty RscMapControl")
remote_entries = {
    name: int(target)
    for name, target in re.findall(r'class\s+(TYR_fnc_[A-Za-z0-9_]+)\s*\{\s*allowedTargets\s*=\s*([012])\s*;', desc)
}
remote_used: set[str] = set()
for p in SOURCE_FILES:
    remote_used.update(re.findall(r'remoteExec(?:Call)?\s*\[\s*["\'](TYR_fnc_[A-Za-z0-9_]+)["\']', read(p)))
for fn in sorted(remote_used - set(remote_entries)):
    errors.append(f"remote endpoint not whitelisted: {fn}")
for fn, target in remote_entries.items():
    if fn not in registered:
        errors.append(f"RemoteExec whitelist references unregistered function: {fn}")
    if "_fnc_Server" in fn and target != 2:
        errors.append(f"server endpoint must use allowedTargets=2: {fn}")
    if "_fnc_Client" in fn and target != 1:
        errors.append(f"client endpoint must use allowedTargets=1: {fn}")

# Dialog creation targets must exist in the included dialog set.
dialog_text = "\n".join(read(p) for p in HPP_FILES)
dialog_classes = set(re.findall(r"\bclass\s+([A-Za-z0-9_]+)\b", dialog_text))
for p in SOURCE_FILES:
    for cls in re.findall(r'createDialog\s+["\']([^"\']+)["\']', read(p), re.I):
        if cls not in dialog_classes:
            errors.append(f"{rel(p)}: createDialog references undefined class {cls}")
idds: dict[str, list[str]] = {}
for p in HPP_FILES:
    for idd in re.findall(r"\bidd\s*=\s*(\d+)\s*;", read(p)):
        idds.setdefault(idd, []).append(rel(p))
for idd, owners in idds.items():
    if len(owners) > 1:
        errors.append(f"duplicate dialog idd {idd}: {owners}")

# V4 architecture invariants.
active_text = "\n".join(strip_comments(read(p)) for p in SQF_FILES)
for token in ["GameData", "Pside", "ServerBroadcastState", "TYR_Save_v3", "TYR_Save_v2", "TYR_fnc_SerializeGameState"]:
    # The autotest deliberately asserts that GameData is absent.
    hits = []
    for p in SQF_FILES:
        text = strip_comments(read(p))
        if token in text:
            if token == "GameData" and rel(p) == "Tests/fn_ServerRunAutomatedTests.sqf":
                continue
            hits.append(rel(p))
    if hits:
        errors.append(f"legacy token {token!r} found in active source: {hits}")

# Only Persistence may touch the durable mission namespace / force disk I/O.
for p in SQF_FILES:
    text = strip_comments(read(p))
    r = rel(p)
    if ("missionProfileNamespace" in text or "saveMissionProfileNamespace" in text) and not r.startswith("Persistence/"):
        errors.append(f"durable namespace access outside Persistence/: {r}")
if "TYRANTS_V4_A" not in read(ROOT / "Persistence/fn_PersistenceLoad.sqf") or "TYRANTS_V4_B" not in read(ROOT / "Persistence/fn_PersistenceLoad.sqf"):
    errors.append("journal loader is missing one or both v4 checkpoint slots")
for old in ["TYR_Save_v3", "TYR_Save_v2", 'getVariable ["Tyrants"']:
    if old in active_text:
        errors.append(f"legacy save compatibility reintroduced: {old}")

# Normal gameplay systems mark dirty; only Persistence and explicit debug Save Now
# are allowed to invoke the full snapshot writer directly.
for p in SQF_FILES:
    text = strip_comments(read(p))
    if "TYR_fnc_PersistenceSave" in text and rel(p) not in {
        "Persistence/fn_PersistenceManager.sqf", "Debug/fn_ServerDebugAction.sqf", "Core/fn_ServerBootstrap.sqf"
    }:
        errors.append(f"direct persistence write outside manager/debug/shutdown: {rel(p)}")

# Three factions are a hard v4 invariant in state and lobby mission slots.
state_create = read(ROOT / "State/fn_StateCreateCampaign.sqf")
mission = read(ROOT / "mission.sqm")
for fid in ["west", "east", "independent"]:
    if f'"{fid}"' not in state_create:
        errors.append(f"StateCreateCampaign missing faction: {fid}")
for side in ["West", "East", "Independent"]:
    if f'side="{side}"' not in mission:
        errors.append(f"mission.sqm missing playable faction side: {side}")
if mission.count("isPlayable=1") < 24:
    errors.append("mission.sqm should expose 8 playable slots for each of three factions (24 total)")

# Save snapshot is named and runtime-object free by construction.
builder = read(ROOT / "Persistence/fn_PersistenceBuildSnapshot.sqf")
for section in ["campaign","factions","locations","players","vehicles","emplacements","forces","operations","destroyedBuildings"]:
    if f'["{section}",' not in builder:
        errors.append(f"save snapshot builder missing named section: {section}")
if re.search(r'\b(publicVariable|publicVariableServer|publicVariableClient)\b', active_text):
    warnings.append("publicVariable found; targeted TYR remote replication should normally be preferred")

# No polling mirror of all live vehicle state should exist. Vehicle condition is
# sampled only while constructing a save snapshot.
for p in SQF_FILES:
    if rel(p).startswith("Persistence/"):
        continue
    text = strip_comments(read(p))
    if re.search(r'\b(getWeaponCargo|getMagazineCargo|getItemCargo|getBackpackCargo)\b', text):
        warnings.append(f"live cargo sampling outside persistence: {rel(p)}")

# mission.sqm rewrite should be editable text, not the inherited rapified binary.
try:
    mission.encode("ascii")
except UnicodeEncodeError:
    errors.append("mission.sqm is not plain editable text")
if "binarizationWanted=0" not in mission:
    warnings.append("mission.sqm does not explicitly request text-friendly binarization behavior")

# Explicitly reject the old setup dialog remnants that caused missing-script paths.
for old_path in ["Dialogs/SetupMenu.hpp", "Dialogs/SetupMenuFactions.hpp", "Dialogs/SetupMenuVehicles.hpp", "Setup", "Functions"]:
    if (ROOT / old_path).exists():
        errors.append(f"legacy rewrite path still present: {old_path}")


# Deployment/intelligence invariants: setup must be sector-based, viewer-specific, and listen-server safe.
for needed in [
    "World/fn_ServerGenerateDeployment.sqf",
    "World/fn_ServerConfirmBase.sqf",
    "World/fn_ServerFinalizeDeployment.sqf",
    "UI/fn_DeploymentMapDraw.sqf",
    "Dialogs/TyrDeploymentMenu.hpp",
]:
    if not (ROOT / needed).exists():
        errors.append(f"deployment system missing: {needed}")
if (ROOT / "World/fn_ServerAssignBases.sqf").exists():
    errors.append("legacy automatic ServerAssignBases still exists")
request_state = read(ROOT / "Network/fn_ServerRequestState.sqf")
if re.search(r"_owner\s*<=\s*2", request_state):
    errors.append("ServerRequestState still rejects listen-server owner 2")
public_faction = read(ROOT / "State/fn_StatePublicFaction.sqf")
if "_viewerFaction" not in public_faction or "_viewerFaction isEqualTo _factionId" not in public_faction:
    errors.append("faction replication is not viewer-specific; enemy HQ positions could leak")
if 'setMarkerAlpha 0' not in read(ROOT / "World/fn_ServerCreateBases.sqf"):
    errors.append("respawn HQ markers are not hidden and may leak enemy base positions")
public_location = read(ROOT / "State/fn_StatePublicLocation.sqf")
if "_viewerFaction" not in public_location or '"unknown"' not in public_location or "TYR_fnc_StateKnowledgeGet" not in public_location:
    errors.append("location replication is not faction-knowledge aware")
publish_location = read(ROOT / "Network/fn_ServerPublishLocation.sqf")
if "TYR_fnc_StatePublicLocation" not in publish_location or "_viewer" not in publish_location:
    errors.append("ServerPublishLocation is not viewer-specific")
if '[_x,_viewer] call TYR_fnc_StatePublicLocation' not in request_state:
    errors.append("ServerRequestState still sends authoritative location truth instead of viewer knowledge")
public_faction_text = read(ROOT / "State/fn_StatePublicFaction.sqf")
if '[-1,-1,-1,-1]' not in public_faction_text:
    errors.append("enemy faction resources are not redacted")
ai_objective = read(ROOT / "AI/fn_AISelectObjective.sqf")
if "TYR_fnc_StateKnowledgeGet" not in ai_objective:
    errors.append("AI objective selection is not connected to faction knowledge")

# Map Draw event handlers pass an event array. The called functions use `params ["_map"]`,
# so the control must be wrapped back into an array rather than called as raw `_this`.
deploy_init = read(ROOT / "UI/fn_DeploymentMenuInit.sqf")
client_map_init = read(ROOT / "UI/fn_ClientMapInit.sqf")
if '{(_this # 0) call TYR_fnc_DeploymentMapDraw}' in deploy_init:
    errors.append("deployment Draw EH passes a Control where DeploymentMapDraw expects an argument array")
if '{(_this # 0) call TYR_fnc_ClientMapDraw}' in client_map_init:
    errors.append("strategic-map Draw EH passes a Control where ClientMapDraw expects an argument array")
if '{_this call TYR_fnc_DeploymentMapDraw}' not in deploy_init:
    errors.append("deployment Draw EH is not wired to DeploymentMapDraw with the event-argument array")
if '{_this call TYR_fnc_ClientMapDraw}' not in client_map_init:
    errors.append("strategic-map Draw EH is not wired to ClientMapDraw with the event-argument array")


# Campaign reset and player-spawn safety invariants.
if 'class TYR_ResetCampaign' not in desc or 'RESET - Start Fresh' not in desc:
    errors.append("description.ext is missing the destructive campaign-reset lobby parameter")
bootstrap = read(ROOT / "Core/fn_ServerBootstrap.sqf")
if 'TYR_ResetCampaign' not in bootstrap or 'TYR_fnc_PersistenceReset' not in bootstrap:
    errors.append("ServerBootstrap does not honor the campaign-reset lobby parameter before loading")
for needed in ["World/fn_IsValidLandPosition.sqf", "World/fn_FindSafeSpawnPosition.sqf"]:
    if not (ROOT / needed).exists():
        errors.append(f"spawn safety helper missing: {needed}")
register_player = read(ROOT / "Players/fn_ServerRegisterPlayer.sqf")
if 'TYR_fnc_FindSafeSpawnPosition' not in register_player or 'TYR_fnc_IsValidLandPosition' not in register_player:
    errors.append("ServerRegisterPlayer does not sanitize saved positions against the confirmed HQ")
save_player = read(ROOT / "Players/fn_ServerSavePlayer.sqf")
if 'TYR_fnc_IsValidLandPosition' not in save_player:
    errors.append("ServerSavePlayer can persist an unvalidated water/out-of-bounds position")

print(f"Checked {len(SQF_FILES)} SQF files and {len(SOURCE_FILES)} source/config files.")
print(f"Registered TYR functions: {len(registered)}")
print(f"Referenced TYR functions: {len(used)}")
print(f"Remote TYR endpoints: {len(remote_entries)}")
if warnings:
    for w in warnings:
        print(f"WARN: {w}")

# Deployment uses the proven local-marker colour wash because Arma embedded map
# controls render it more reliably than filled drawTriangle geometry. The normal
# strategic map still shares the same sector boundary/label renderer.
deployment_draw = read(ROOT / "UI/fn_DeploymentMapDraw.sqf")
sector_draw = read(ROOT / "UI/fn_DrawDeploymentSectors.sqf")
overlay = read(ROOT / "UI/fn_DeploymentOverlayBuild.sqf")
placement_click = read(ROOT / "UI/fn_DeploymentMapClick.sqf")
placement_check = read(ROOT / "World/fn_DeploymentCheckPosition.sqf")
if 'TYR_fnc_DrawDeploymentSectors' not in deployment_draw:
    errors.append("deployment map is not using the shared deployment-sector renderer")
if 'drawLine' not in sector_draw or 'DEPLOYMENT REGION' not in sector_draw:
    errors.append("deployment-sector renderer is missing boundaries or labels")
if 'createMarkerLocal' not in overlay or 'ColorGrey' not in overlay or '_borderDistance' not in overlay:
    errors.append("deployment colour overlay is missing the reliable symmetric local-marker buffer rendering")
if 'TYR_fnc_DeploymentOverlayBuild' not in read(ROOT / "UI/fn_DeploymentMenuInit.sqf"):
    errors.append("deployment menu is missing its colour overlay lifecycle hook")
if 'TYR_fnc_DeploymentOverlayCleanup' not in read(ROOT / "Dialogs/TyrDeploymentMenu.hpp"):
    errors.append("deployment dialog does not clean up deployment overlay state")
if 'TYR_fnc_DeploymentFindCollisions' not in placement_click or 'TYR_DeploymentCollisions' not in deployment_draw:
    errors.append("deployment map is missing exact-footprint collision preview")
if 'search nearby' in placement_click.lower() or 'for "_a" from' in placement_click:
    errors.append("deployment placement is still auto-adjusting player clicks")
if 'TYR_fnc_DeploymentFindCollisions' not in placement_check:
    errors.append("server deployment validation is not checking the HQ footprint collisions")

if errors:
    for e in errors:
        print(f"ERROR: {e}")
    print(f"FAIL: {len(errors)} integrity error(s).")
    sys.exit(1)
print("PASS: Tyrants v4 static architecture checks found no integrity errors.")
