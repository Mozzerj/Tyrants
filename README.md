# Tyrants v4.0.15 DEV

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

The server discovers towns, cities and factory clusters, generates separated deployment sectors, accepts human HQ choices, auto-selects HQs for AI factions, then starts the economy and territory/AI scheduler once deployment is complete. AI commanders now run a staged strategic decision path: command state -> known emergency threats -> faction intelligence picture -> operation reassessment -> posture -> candidate generation/scoring/validation -> physical command routing -> force execution -> later reassessment. Unknown hostile state is not read as AI knowledge.

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

## v4.0.10 intelligence tracking

Faction intelligence now stores real last-known enemy contacts rather than receiving live enemy truth. Human visual observations are server-validated, UAVs can create observations, AI force leaders can generate contacts from real line of sight, and lost contacts stop moving until they are seen again. The normal map shows contact age and identification level. The developer console contains an omniscient truth map, faction-intelligence map, intelligence log, automated checks, and a manual runtime test task list for engine behaviours that cannot be proven outside Arma.



## v4.0.11 developer testing tools

- Developer Operations Console can launch Arma's Splendid Camera directly.
- While Splendid Camera is active, ordinary faction visual-intelligence reporting is suppressed so free-camera reconnaissance does not contaminate the intelligence test.
- Splendid Camera's normal Space action can teleport the player under the camera cursor for rapid runtime testing.
- Omniscient/faction debug maps have a toggleable left-click teleport mode for arbitrary map movement.
- Developer Operations Console includes a multiline command runner with LOCAL and SERVER execution.
- Standard Arma Debug Console is enabled for the mission host/logged-in admin in this DEV build.


## v4.0.12 physical command network

Each active faction now fields a physical Main Commander, three physical command officers, and physical force commanders represented by AI force leaders. Strategic AI orders are no longer applied instantly: they are queued through the command network, delayed by network health, and rerouted when command personnel are lost. Existing delivered orders continue when the network collapses.

Commander death starts a succession period; surviving senior officers can assume command. Lost officers are replaced slowly when manpower and a functioning HQ route remain. If all strategic command personnel are lost, the faction enters Command Collapse. Recovery is possible through an emergency commander while the HQ/replacement route and manpower remain; sustained collapse ultimately eliminates the faction. Enemy command personnel are not revealed for free.


## v4.0.13 strategic AI overhaul

The AI commander now runs a 12-stage decision pipeline instead of choosing a single location and attacking it. It builds its enemy picture from the same faction knowledge database used by players, maintains reserves, reacts to command disruption and known emergencies, creates recon/probe actions for unknown territory, can raid legitimately observed command personnel/emplacements/vehicles, and validates resources/intel/command routes before issuing an operation.

Developer Debug Mode includes an actual live 12-node decision flowchart. **RUN THINK + TRACE** slows the real AI think just enough to watch the current stage and branch result. The omniscient debug map draws the operation target, assigned force, reason/score/phase, and the physical commander -> officer -> force commander delivery route with ETA/reroutes. See `AI_STRATEGIC_OVERHAUL.md`.


## v4.0.14 debug console rewrite

The developer console now uses fixed tool pages and direct workspace tabs instead of a dynamically reflowed accordion. Expensive views refresh independently: the truth map requests full omniscient data only while visible, AI Flow receives compact trace updates, and the tests/log/command views are event-driven. The omniscient map also uses zoom-based entity level-of-detail to reduce per-frame drawing work.


## v4.0.15 production and hybrid logistics

Factories now manufacture finite vehicle/ammunition stock into local inventories with time-based queues. Vehicle Procurement releases completed factory stock instead of paying an instant fuel price. Non-vehicle output is moved through hybrid logistics jobs: quiet rear-area journeys are lightweight virtual records, while convoys materialise as real trucks/escorts whenever players, hostile forces or active operations can interact with them. Destroying a cargo truck destroys its manifest. See `PRODUCTION_LOGISTICS.md`.

Unused playable lobby-slot AI is disabled through `disabledAI = 1` with an additional running-phase server cleanup safeguard.
