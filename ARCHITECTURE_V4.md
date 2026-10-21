# Tyrants v4 Architecture

## State ownership

`TYR_State` is the server-authoritative persistent model. It contains campaign settings, factions, mutable location state, players, persistent vehicles, emplacements, AI forces, operations and destroyed-world records.

`TYR_Runtime` contains live Arma implementation details: Object and Group handles, base objects, factory building groups, active capture sessions, arsenal transaction state, persistence timing/counters and other caches. Runtime data is rebuilt after load and is never serialized.

Clients maintain `TYR_ClientState`, a public read-only view of faction and location data. A normal resource change sends one faction update; a capture sends one location update. Full snapshots are used for initial join and explicit debug resynchronisation only.

## Factions

Faction identity is string based (`west`, `east`, `independent`) rather than positional indexes. Side conversion is isolated in `Core/fn_FactionSide.sqf` and `Core/fn_SideFaction.sqf`. Gameplay systems query faction records by ID and therefore do not use `1 - side`, `Pside`, or FRIENDLY/ENEMY two-side assumptions.

The lobby exposes eight playable units for each of WEST, EAST and INDEPENDENT. Controller type is independent from playable slots: a faction can be configured as Human, AI or Disabled.

## Services and endpoints

Public multiplayer endpoints are intentionally thin. They resolve `remoteExecutedOwner`, validate the requesting player/faction, then invoke server-side game logic. Internal services do not depend on remote context. Examples include `ResearchPurchase`, `VehiclePurchase`, and `AIForceCreate`.

This is important for AI and testing: human and AI controllers can use the same economic rules without spoofing a network call.

## Scheduler

`Core/fn_ServerScheduler.sqf` owns recurring strategic work. Territory sessions are advanced every second, operations every five seconds, economy at the configured campaign interval, and AI commander think slices are staggered so only one commander performs strategic planning in a scheduler second.

## Territory

Capture time is authoritative on the server. A client may request a capture only while close to a non-owned strategic location. The server then tracks faction presence for that active location. Any opposing faction contests progress. AI forces create the same capture-session records when they reach an operation objective.

## World model

World definitions are reconstructed from Altis at startup. Strategic locations receive stable IDs derived from type and rounded world position. The save only stores mutable overlays such as owner and factory stock. Factory building Object references remain in `TYR_Runtime`.

## Player model

Players are persisted by UID with faction, position, direction and native `getUnitLoadout` data. Restore uses `setUnitLoadout`. The initial client transition waits for public server state and a server restore response before fading from black, avoiding the old setup-stage race.

## Extending v4

New systems should follow these rules:

1. No persistent Arma Object/Group/Code/UI handles in `TYR_State`.
2. No direct durable namespace writes outside `Persistence/`.
3. No whole-state broadcast after normal mutations.
4. No client-authoritative timers, prices or ownership changes.
5. Use faction IDs, not binary side indexes.
6. Prefer internal server services plus small network wrappers.
7. Mark persistence dirty; do not synchronously save after routine actions.
