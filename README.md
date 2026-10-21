# Tyrants

Tyrants is an Arma 3 multiplayer campaign mission built around WEST/EAST territorial control, persistent resources, factories, vehicle purchasing, loadout purchasing, and movable team bases.

This repository is the **foundation-cleanup build** of the original project. The goal of this pass is stability and maintainability rather than new gameplay.

## Foundation architecture

### Server authority

`initServer.sqf` owns campaign startup. Persistent and gameplay-changing state is mutated on the server only:

- campaign setup and settings
- territory ownership and factory stock
- team resources
- base positions
- purchased/destroyed vehicles
- persistent player profiles/loadouts

Clients request actions through whitelisted `TYR_fnc_Server*` endpoints. Server endpoints validate caller ownership, side, distance, and relevant campaign state before making changes.

`GameData` remains the runtime compatibility structure used by the existing UI:

```text
GameData = [
  campaignData,
  locationData,
  destroyedData,
  vehicleCatalogue,
  purchasedVehicles
]
```

`campaignData` is:

```text
[
  [setupStage, settings],
  [westBasePos, steel, ammo, fuel, manpower],
  [eastBasePos, steel, ammo, fuel, manpower],
  playerProfiles
]
```

### Persistence v2

The server saves serializable campaign data to `profileNamespace` under `TYR_Save_v2`.

Live object references are never written into the save. Locations are rediscovered from the world at startup and their dynamic ownership/stock is reapplied. Purchased vehicles are stored as class/state data and recreated by the server.

A best-effort migration path remains for the original `Tyrants` save key. Old setup stage 2 is intentionally restarted at stage 1 because the old stage depended on in-memory scan data.

### Setup stages

- **Stage 0:** campaign settings
- **Stage 1:** vehicle/DLC scan and catalogue generation
- **Stage 3:** team base placement
- **Stage 4:** campaign running

The setup owner is selected by the server (WEST commander, EAST commander, then first available player as fallback). Setup submissions are accepted only from that owner.

### Multiplayer/networking

`description.ext` uses a `CfgRemoteExec` whitelist and inherits the base game config for compatibility. Raw remote commands are not used by Tyrants gameplay; client notifications/end-mission actions are wrapped in guarded TYR functions.

Map/card controls are client-local and recreated whenever Arma recreates the map display. UI control IDs are no longer stored in `GameData`.

### Arsenal/loadouts

The server records the player's inventory when the Tyrants arsenal opens. When it closes, the server reads the synchronized inventory, calculates the price difference, and either commits it or restores the previous loadout if team ammo is insufficient. The client no longer supplies authoritative before/after values.

## Project layout

```text
Functions/                  Registered TYR functions and server endpoints
GameUpdate/                 Server campaign loop
Player/PlayerInit/          Client map/UI initialization
Player/PlayerLoops/         Client display/capture/save request loops
Setup/GameSetupStage*/      Initial campaign setup UI
Setup/GameSetupPlayer/      Player/base setup flow
tools/validate_project.py   Lightweight static integrity checks
```

The old duplicate `Init/`, `Setup/player/`, duplicate factory/vehicle functions, and superseded setup scripts were removed during the cleanup.

## Static validation

From the mission root:

```bash
python tools/validate_project.py
```

The validator is intentionally lightweight; it is **not an SQF compiler**. It checks:

- balanced delimiters/strings in SQF and core config files
- referenced script paths
- `CfgFunctions` registration/file consistency
- RemoteExec endpoint whitelist coverage
- accidental client/shared `GameData` mutation
- duplicate dialog IDDs
- return of known superseded directories

## Required Arma regression pass

Static validation cannot replace running the mission in Arma 3. Before adding features, test this build in a clean profile/save and then with persistence enabled.

1. Host a fresh WEST/EAST multiplayer mission and complete all setup stages.
2. Repeat on a dedicated server to confirm no server-side UI dependency.
3. Confirm both bases can only be placed on valid land on their assigned side.
4. Join in progress after stage 4 and confirm state/loadout/base/map data arrives correctly.
5. Restart the mission and confirm settings, resources, territory ownership, factory stock, destroyed buildings, active vehicles, destroyed vehicles, and player profiles restore.
6. Capture a town, city, and factory; verify only a local force majority can complete the server-side capture.
7. Let factories produce, collect each resource type, and verify the production multiplier scales new output rather than stored stock.
8. Buy a vehicle at the friendly base; reject purchase away from base; destroy it and verify the active marker disappears and the wreck persists after restart.
9. Open the arsenal, buy equipment, remove equipment, and attempt an unaffordable loadout. Confirm resource changes and rollback are correct.
10. Test accountant friendly fire, splash damage, enemy direct damage, move/drop behavior, and box/respawn movement.
11. Reconnect the same player and confirm saved loadout and position restore.
12. Use reset only as an authorized commander and confirm the v2 and legacy save keys are cleared.

## Next development boundary

Do not add major gameplay until the regression pass above is clean. Once it is, the next sensible pass is to finish the intentionally incomplete systems (AI hiring/emplacements, victory/end-state rules, commander flow) without reopening the old state-ownership problems.
