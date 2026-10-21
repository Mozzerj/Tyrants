# Tyrants Automated Test Harness

This build includes a one-click in-game regression harness for solo development.

## Running it

1. Host `Tyrants.Altis` in multiplayer.
2. Set **Solo Test Mode** to **Enabled** in mission parameters.
3. Join WEST or EAST and complete setup until normal gameplay begins.
4. Run **Run Tyrants Automated Tests** from the action menu or the Developer Debug panel.
5. When it finishes, choose **Copy Last Tyrants Test Report** and paste the result back into ChatGPT if any checks fail.

The full report is also written to the Arma RPT with the prefix `[TYRANTS TEST]`.

Developer Debug Mode is not required for the automated suite. The suite temporarily exercises the internal server-only debug mutation helper inside its isolated server sandbox, and separately verifies that the public debug endpoint refuses mutations when Debug Mode is disabled.

## What it tests automatically

### Live-session checks

The runner validates the real hosted session without changing it:

- Solo Test Mode and one-player test conditions;
- successful transition to gameplay stage 4;
- discovered town/city/factory data and world-bounds positions;
- both faction base positions, land placement, separation and runtime objects;
- generated vehicle catalogue structure, class availability and duplicate classes;
- current player loadout pricing;
- current player persistence record and duplicate UID detection;
- presence of a v3 persistent campaign save.

### Isolated campaign/state checks

The server then swaps to an isolated `GameData` sandbox and runs the real production functions. Save and broadcast calls are intercepted until the real campaign is restored.

Coverage includes:

- default v3 `GameData` structure;
- research count, key uniqueness, field/schema validity and positive costs;
- research prerequisite references and acyclic dependency graph;
- missing-prerequisite rejection without charging steel;
- insufficient-funds rejection without unlocking or charging;
- exact-balance research purchases (regression for the old `>` versus `>=` bug);
- successful purchase with exact steel deduction;
- duplicate research purchase protection;
- dependent research unlocks;
- procurement category gating, including autonomous vehicles;
- emplacement definition uniqueness/schema/research links/class availability;
- cruise-missile and target config dependencies;
- server-local creation/removal of the VLS class;
- VLS research gating;
- 18-target storage cap;
- valid VLS target removal;
- invalid VLS removal rejection;
- reusing a target slot after removal;
- debug resource addition and subtraction;
- prevention of negative resources;
- per-command resource safety clamp;
- editing the opposing faction without altering the requester's faction;
- invalid debug resource-index rejection;
- debug boost-all and max-all resource presets;
- debug unlock-all research plus procurement gates;
- debug reset-all research plus procurement gates;
- unknown debug actions remaining non-mutating;
- fill-factories debug action;
- real `FactoryUpdate` production using a temporary server-local factory object;
- the Infrastructure Factory Production +25% multiplier;
- debug save-now reaching the persistence layer;
- the public debug endpoint being inert with Debug Mode disabled;
- the public debug endpoint mutating only through the validated server path when enabled;
- `TYR_fnc_ServerDebugAction` being server-only in `CfgRemoteExec`;
- the internal `TYR_fnc_ServerApplyDebugAction` helper not being remotely exposed;
- v3 serialization shape;
- absence of live object references in serialized saves;
- persistence of strategic target data;
- serialized resource snapshots remaining detached from later live mutations;
- interception of test-time save/broadcast side effects.

The live campaign is restored after the suite. A server fail-safe also restores the original `GameData` if a runtime error interrupts the test while its sandbox is active.

## What still needs a human/engine test

Automation deliberately avoids interactions that are visual, physics-heavy, destructive, or genuinely concurrent. Keep these as short manual checks when the relevant system changes:

- visual correctness and usability of setup/player/debug/research/vehicle/emplacement dialogs;
- repeatedly opening/closing the map and checking marker lifecycle;
- an actual vehicle purchase, spawn and drive;
- arsenal interaction and insufficient-funds loadout rollback;
- placement and interaction with a real strategic emplacement;
- actual cruise-missile flight, terrain following and impact behavior;
- save/restart restoration in a fresh mission process;
- true two-or-more-player concurrency, JIP and opposing-player behavior.

Those remain manual because automating them entirely from mission SQF would either be brittle or change the live world in ways that make failures harder to diagnose.
