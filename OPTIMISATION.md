# Optimisation Design

The v4 rewrite removes several expensive patterns from the historical mission.

## Removed hot paths

- No full `GameData` broadcast after purchases or target edits.
- No synchronous full campaign save after ordinary mutations.
- No periodic mirroring of every vehicle into the save model.
- No client-owned global capture loop.
- No population `nearestObjects` scans for every town every second.
- No permanent map-control card per location.
- No independent strategic loops all waking on the same frame.

## Targeted replication

The client public model contains only faction/location information needed for interfaces and the strategic map. Server changes publish the affected faction or location. VLS state is sent to the requesting client as a dedicated payload.

## Map rendering

The strategic map uses a Draw handler and draws current public strategic data while the map is visible. There are no persistent controls to reposition for every location.

## Scheduler

One server scheduler spreads economy, AI planning, AI operations and capture processing across time. AI commanders are offset from one another to avoid synchronized spikes.

## Persistence

Disk I/O is dirty-state/debounce driven. Live object state is sampled only when a checkpoint is actually built. Two alternating validated journal records are kept.
