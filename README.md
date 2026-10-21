# Tyrants

Tyrants is an Arma 3 multiplayer campaign mission built around WEST/EAST territorial control, persistent resources, factories, vehicle and loadout purchasing, research progression, strategic emplacements, and movable team bases.

This build merges the **18 October 2024 development snapshot** into the cleaned multiplayer foundation. The newer gameplay ideas were recovered without restoring the older client-authoritative state and persistence model.

## Architecture

### Server authority

`initServer.sqf` owns campaign startup. Gameplay-changing state is mutated on the server only, including setup, resources, captures, factory stock, research, bases, vehicle purchases, emplacement purchases, VLS targets, missile authorization, persistence, and player loadouts.

Clients request actions through whitelisted `TYR_fnc_Server*` endpoints. The server validates the caller, side, distance, research prerequisites, resources, and relevant campaign state before making a change.

`GameData` remains the runtime compatibility structure used by the existing UI:

```text
GameData = [
  campaignData,
  locationData,
  destroyedData,
  vehicleCatalogue,
  purchasedVehicles,
  strategicEmplacements
]
```

`campaignData` is:

```text
[
  [setupStage, settings],
  [westBasePos, steel, ammo, fuel, manpower, research, vlsTargets],
  [eastBasePos, steel, ammo, fuel, manpower, research, vlsTargets],
  playerProfiles
]
```

`strategicEmplacements` contains WEST/EAST runtime emplacement records. Live objects are stripped during serialization.

### Persistence v3

The server saves serializable campaign data to `profileNamespace` under `TYR_Save_v3`.

The v3 save adds research progression, stored VLS targets, and strategic emplacements. It contains no live object references. Locations, vehicles, and emplacements are recreated by the server and dynamic state is reapplied.

The loader includes best-effort migration for the foundation `TYR_Save_v2` format and the original legacy `Tyrants` key. Old setup stage 2 is restarted at stage 1 because that stage depended on temporary scan data.

### Research and procurement

The recovered research tree has three branches:

- Intelligence: Basic Intelligence, Communications Intercept, Listening Devices, Vehicle Trackers, Satellite Surveillance.
- Infrastructure: Basic Infrastructure, Strategic Emplacements, Counter-Battery Radar, Roadblocks, Factory Production, Offensive Emplacements.
- Procurement: Armoured Vehicles, Heavy Armour, Rotary Wing, Artillery, Fixed Wing, Autonomous Capabilities.

Research purchases are server validated. Procurement research gates the corresponding vehicle-shop categories on both client and server. Factory Production currently gives friendly factories a 25% production bonus.

The intelligence branch, counter-battery radar, and roadblock research are retained in the progression tree for future implementation; they are not presented as completed gameplay systems.

### Strategic emplacements and VLS

The 18/10 emplacement concept has been moved to server ownership. Offensive Emplacements unlock a VLS purchase. The server validates its placement, research, steel cost, ownership, persisted state, missile inventory, and launch authorization.

VLS target lists are stored per side. Missile launches run server-side and retain the experimental terrain-following cruise-missile behavior and global missile marker from the newer build. This system needs an Arma multiplayer regression test before balancing or expanding it.

Counter-Battery Radar and Roadblock entries are shown as prototypes because their 18/10 creation cases were empty.

### Setup

The newer setup flow for selecting individual vehicles has been recovered. The setup owner selects content/factions, then explicitly chooses which vehicles enter that campaign's catalogue rather than automatically importing every eligible vehicle.

Starting steel values also use the later 18/10 balance values: 5k, 10k, 15k, 20k, 30k, or 45k.

### Multiplayer/networking

`description.ext` uses a `CfgRemoteExec` whitelist. Map/card controls stay local to each client and are recreated with the map display. Campaign state is broadcast from the server; clients do not write authoritative `GameData`.

The server records arsenal state before a purchase and validates the resulting synchronized loadout, preventing the client from supplying authoritative before/after inventory values.

## Project layout

```text
Functions/                  Registered TYR functions and server endpoints
GameUpdate/                 Server campaign loop
Player/PlayerInit/          Client map/UI initialization
Player/PlayerLoops/         Client display/capture/save request loops
Research/                   Active research UI
Emplacements/               Active emplacement/VLS client UI
Setup/GameSetupStage*/      Initial campaign setup UI
Setup/GameSetupPlayer/      Player/base setup flow
docs/prototypes/            Archived 18/10 experiments kept for reference
tools/validate_project.py   Lightweight static integrity checks
```

The old duplicate `Init/`, `Setup/player/`, duplicate factory/vehicle functions, and superseded setup scripts remain removed. Experimental 18/10 research/VLS source is archived under `docs/prototypes/` rather than loaded by the mission.

## Static validation

From the mission root:

```bash
python tools/validate_project.py
```

The validator is intentionally lightweight; it is **not an SQF compiler or Arma runtime test**. It checks balanced delimiters/strings, referenced script paths, `CfgFunctions` registration, RemoteExec coverage, accidental client/shared `GameData` mutation, duplicate dialog IDDs, and the return of known superseded directories.

## Solo testing

You can now start a hosted multiplayer session by yourself. In the mission parameters, set **Solo Test Mode** to **Enabled**. Complete setup normally and place the base for the side you joined. Once your base is accepted, the server automatically chooses valid land on the opposite side of the campaign divider for the missing faction and continues into stage 4.

Solo mode changes only the missing-opponent base-placement requirement. Purchases, research, captures, persistence, VLS validation, and the normal server-authoritative rules still run through their multiplayer code paths, making it useful for regression testing without maintaining a separate single-player implementation. The parameter defaults to Disabled, so normal multiplayer still requires both factions to place their own bases.

For side-specific testing, host once in a WEST slot and once in an EAST slot. A single player cannot simultaneously exercise interactions that inherently require a second human on the other faction.

## Required Arma regression pass

Before major new development, run this build with a clean profile/save and then with persistence enabled:

1. Complete fresh setup in hosted multiplayer and on a dedicated server, including selecting a restricted vehicle catalogue.
2. Confirm both bases can only be placed on valid land on their assigned side.
3. Join in progress after stage 4 and verify state, loadout, bases, map data, research, emplacement markers, and VLS actions synchronize.
4. Restart and verify settings, resources, territory, factory stock, research, VLS targets, vehicles, emplacements, destroyed objects, and player profiles restore.
5. Capture a town, city, and factory; verify only a local force majority can complete the server-side capture.
6. Test factory production before and after Factory Production research and collect each resource type.
7. Test research prerequisites, repeat purchases, insufficient steel, and all procurement vehicle gates.
8. Buy allowed/locked vehicle categories and confirm the server independently enforces the research requirement.
9. Unlock Offensive Emplacements, buy a VLS near a friendly region, add/remove targets, launch missiles, exhaust its ammunition, and restart with it persisted.
10. Verify prototype Counter-Battery Radar/Roadblock entries cannot consume resources as if implemented.
11. Test arsenal purchases, unaffordable rollback, vehicle destruction/restoration, accountant behavior, and reconnecting player loadouts.
12. Use reset only as an authorized commander and confirm v3, v2, and legacy save keys are cleared.

## Next development boundary

After the regression pass, refactor subsystem-by-subsystem rather than attempting a whole-project rewrite. The strongest candidates are a named campaign-state API instead of raw nested array indexes, data-driven research/procurement definitions, a shared purchase framework for vehicles/emplacements, and UI code that never depends on the physical storage layout of campaign state.

## Automated solo test harness

When **Solo Test Mode** is enabled and the campaign has reached gameplay stage 4, the player action menu contains:

- **Run Tyrants Automated Tests** — runs a non-destructive server-side smoke/integration suite against an isolated `GameData` sandbox, then restores the live campaign.
- **Copy Last Tyrants Test Report** — copies the most recent full PASS/FAIL report to the clipboard.

The automated suite checks live campaign initialization plus isolated production behaviour, including location/base state, vehicle catalogue integrity, loadout pricing, v3 persistence presence, research definitions and prerequisites, research charging/rejection behaviour, procurement gating, VLS target research and 18-target cap, serializer shape/object safety, emplacement/missile config availability, and server-local VLS instantiation.

The suite intentionally does **not** launch a real cruise missile or permanently spawn/purchase assets. Missile flight, UI interaction and actual multiplayer concurrency still require an engine/manual test. Full results are also written to the Arma RPT with the prefix `[TYRANTS TEST]`.
