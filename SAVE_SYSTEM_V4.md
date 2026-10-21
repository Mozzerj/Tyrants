# Tyrants v4 Save System

Tyrants v4 uses a completely new save format. Old Tyrants save keys are intentionally ignored.

## Storage

Two journal records are stored in the mission-specific namespace:

- `TYRANTS_V4_A`
- `TYRANTS_V4_B`

Successful checkpoints alternate slots and increment a generation number. Loading validates both records and chooses the newest valid generation. The record includes the world, timestamp data, a named-section snapshot and an integrity hash.

`missionProfileNamespace` is used so campaign data is mission-specific instead of enlarging the user's general Arma profile. Disk writes are performed only by the persistence subsystem.

## Snapshot schema

The snapshot contains named sections:

- `campaign`
- `factions`
- `locations`
- `players`
- `vehicles`
- `emplacements`
- `forces`
- `operations`
- `destroyedBuildings`

The persisted representation is deliberately limited to strings, numbers, booleans and arrays. It does not contain HashMaps, Objects, Groups, Code, Controls, Displays or script handles.

## Definition vs state

World and config information that can be reconstructed is not duplicated in the save. Location names/positions/types are rediscovered from Altis and then overlaid with owner/stock state. Vehicle class definitions, pictures and weapon configuration are read from Arma config. Live vehicle/emplacement/group handles exist only in `TYR_Runtime`.

## Live object capture

Persistent vehicles, emplacements and AI forces have stable string IDs. On checkpoint creation the snapshot builder samples the live runtime object/group for current position, damage, fuel/ammo, cargo or surviving unit classes. There is no periodic vehicle-mirroring loop.

## Dirty-state policy

Gameplay systems call `StateMarkDirty`. Ordinary changes are debounced so many purchases/captures can result in one disk write. Urgent checkpoints are used for major milestones such as player registration/disconnect, faction elimination and initial campaign creation. The persistence manager also caps how long dirty state can remain unsaved.

The developer console's **SAVE NOW** is the explicit immediate-write path.

## Validation

A snapshot is validated before a journal slot is replaced. Validation checks the envelope, world, hash, primitive-only serialization, required sections, exactly three faction identities, unique persistent IDs, resource values, owner/faction references, positions, operation/force references and basic record shapes. If validation fails, the previous checkpoints are retained.


Save revision 2 persists the generated deployment-sector layout and per-faction HQ confirmation state. Revision-1 v4 checkpoints are intentionally rejected rather than migrated.
