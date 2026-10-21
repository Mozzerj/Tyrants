# Foundation cleanup changelog

## Architecture

- Made the server authoritative for campaign state mutations.
- Rebuilt startup so dedicated servers never wait on or create UI.
- Restored the main game loop and vehicle/destruction restoration path.
- Added guarded/validated server endpoints for settings, vehicle catalogue, bases, captures, factories, vehicle purchases, loadouts, and reset.
- Added `CfgRemoteExec` whitelist mode while inheriting the base-game config.
- Replaced raw remote `hint` / `endMission` usage with guarded client functions.

## Persistence

- Added versioned `TYR_Save_v2` serialization.
- Removed live object references from persistent data.
- Rebuilds locations from the current world and reapplies saved dynamic state.
- Recreates active vehicle state and persistent wrecks after restart.
- Added best-effort migration from the legacy `Tyrants` key.
- Safely restarts legacy setup stage 2 at stage 1.

## Setup

- Consolidated the active staged setup flow and removed superseded copies.
- Fixed setup resume logic.
- Fixed factory discovery off-by-one behavior.
- Simplified vehicle scan data.
- Reworked vehicle catalogue generation to use local temporary vehicles and config-based ammo metrics instead of spawning live projectile classes.
- Added server validation of selected campaign settings.
- Added shared divider calculation and server validation of base territory/land placement.

## Economy / vehicles

- Fixed factory multiplier lookup.
- Fixed factory multiplier behavior so it scales new production, not the entire accumulated stock every update.
- Added validated server-side factory collection.
- Added validated server-side vehicle purchasing and resource deduction.
- Centralized vehicle restoration/update/destruction records.

## Player state / arsenal

- Added a reusable unit-profile builder.
- Player registration and periodic persistence are read from the player object by the server rather than trusting submitted loadout arrays.
- Arsenal purchase baseline is captured by the server.
- Arsenal close uses BI's `arsenalClosed` scripted event rather than the pause-menu user-action handler.
- Unaffordable loadouts are restored by the server.
- Improved magazine restoration to preserve container/ammo counts.

## UI / map

- Assigned unique dialog IDDs.
- Fixed duplicate control IDs found in active menus.
- Moved vehicle-buy initialization to the dialog's `onLoad`.
- Removed map-control IDs from networked campaign state.
- Rebuilds local map controls each time Arma recreates display 12.
- Namespaced active mission globals with the `TYR_` prefix where practical.

## Removed superseded code

- old `Init/` scripts
- old `Setup/player/` scripts
- duplicate setup/location/vehicle scripts
- duplicate factory-resource functions
- old dialog function copies
- old vehicle/factory update copies
- obsolete empty scratch files

## Validation

- Added `tools/validate_project.py` for static integrity checks.
- Added an in-game regression checklist to `README.md`.

This cleanup has been statically validated, but it has not been executed inside the Arma 3 engine in this environment. Runtime regression testing is the required next step before feature work.

## 18 October 2024 recovery merge

- Ported research/progression, procurement gates, VLS/emplacements, later setup vehicle selection, later balance values, and the later mission snapshot into the server-authoritative foundation.
- Added persistence schema v3 for research, VLS targets, and emplacements, with v2/legacy migration.
- Added server validation for research purchases, emplacement purchases, VLS target changes, and VLS launches.
- Archived unfinished/experimental 18/10 research and missile prototypes under `docs/prototypes/` rather than reactivating obsolete code paths.
- Kept unfinished Counter-Battery Radar and Roadblocks explicitly marked as prototypes.

## Solo test mode

- Added a lobby `Solo Test Mode` parameter, disabled by default.
- With exactly one human player, the player places their own faction base normally and the server auto-places the missing opposing base on valid land on the other side of the campaign divider.
- Solo mode reuses normal server-authoritative campaign systems; it does not bypass research, purchases, persistence, capture validation, or strategic emplacement rules.
