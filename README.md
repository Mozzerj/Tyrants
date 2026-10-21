# Tyrants v4.0.9 DEV

Current development baseline for the three-faction Tyrants rewrite. It includes deployment sectors, human/AI commanders, the v4 save architecture, targeted replication, and the tactical UI.

## Architecture

Tyrants v4 is a clean architectural rewrite of the Altis strategic-war mission. It does not load historical Tyrants v1/v2/v3 saves and does not use the old positional `GameData` structure.

## Core design

- Three first-class factions: WEST/NATO, EAST/CSAT, and INDEPENDENT/AAF.
- Eight multiplayer lobby slots per faction (24 total) in a new editable text `mission.sqm`.
- Each faction can be Human controlled, AI controlled, or Disabled from mission parameters.
- The authoritative campaign state (`TYR_State`) exists on the server only.
- Live Arma objects live in the separate runtime registry (`TYR_Runtime`) and are never written into campaign saves.
- Clients receive small public faction/location snapshots and targeted updates instead of the whole campaign state.
- Human requests are validated by server endpoints; reusable internal services perform the actual transaction.
- AI commanders operate through the same research, force, economy and territory rules rather than receiving free campaign state changes.
- Persistence is a new named-section journal format stored in `missionProfileNamespace`.
- Strategic work is staggered by a central scheduler instead of many independent polling loops.

## Current strategic loop

The server discovers towns, cities and factory clusters, generates separated deployment sectors, accepts human HQ choices, auto-selects HQs for AI factions, then starts the economy and territory/AI scheduler once deployment is complete. AI commanders create forces, buy eligible research, select strategic objectives, form operations, move forces and start server-owned capture sessions.

Players spawn into their faction's HQ after receiving server state. Press **Y** for the Tyrants command interface. Player capture progress, purchases, arsenal costs, factory collection, VLS, emplacements and force deployment are server validated.

## Saves

The new save format is deliberately incompatible with old Tyrants saves. See `SAVE_SYSTEM_V4.md`.

## Validation

Run:

```text
python3 tools/validate_project.py
```

This checks function registration, RemoteExec wiring, dialog references, missing includes, legacy `GameData` regressions, persistence boundaries, three-faction lobby slots, and basic delimiter/string integrity.

## Runtime testing

No Arma 3 executable is available in the development environment used for this rewrite. Static validation is extensive, but the build still needs an in-engine multiplayer pass for SQF/runtime behavior, UI rendering, AI pathfinding and the experimental VLS missile.


## Deployment sectors
New campaigns now pause in a protected strategic-deployment phase. Two active factions receive two broad map halves; three receive three broad regions. Human commanders choose an HQ within their own region, AI commanders choose under the same rules, and hostile HQ coordinates are not replicated. See `DEPLOYMENT_SYSTEM.md`.


## Resetting a campaign

The lobby parameter **RESET SAVED CAMPAIGN ON START** clears both Tyrants v4 journal checkpoints before the server loads state. Leave it on **Keep Current Save** normally. Select **RESET - Start Fresh** for one launch when you deliberately want a completely new campaign, then return it to **Keep Current Save** on later starts.

Player restore positions are now land-validated. Out-of-bounds/water positions (including `[0,0,0]`) are never used as a normal restore point; the server repairs them to a safe position around the player's confirmed faction HQ.
