# Tyrants v4.0.15 production and hybrid logistics

## Design goal

Factories manufacture finite war materiel. Completed ammunition or vehicles do not appear magically at the unit that needs them. Stock exists at a physical strategic location and must be released or moved from there.

The logistics simulation is deliberately hybrid. A convoy is fully physical only when a human, hostile force, or active operation could realistically interact with it. Quiet rear-area movement is represented by a lightweight server record and becomes physical again as interaction becomes possible.

## Factory production

Each indexed factory has a specialisation:

- `vehicle` — faction vehicle classes unlocked by procurement research.
- `munitions` — general ammunition batches plus artillery HE/smoke where research permits.
- `air_defence` — SAM missiles and C-RAM ammunition.
- `strategic` — VLS missiles when the relevant research is unlocked.

A factory has:

- an owning faction;
- a local inventory;
- a maximum three-item production queue;
- start/finish times for each queued item;
- physical factory-building parts used to decide whether production is operational.

Production is primarily limited by **time and capacity**. Destroying/disabling the factory pauses its queue rather than silently completing it. Capturing a factory clears the old owner's unfinished queue but leaves completed local stock available to the new owner.

## Vehicles

Vehicle production finishes into the local inventory of a vehicle factory as `vehicle:<classname>` stock. The Vehicle Procurement screen no longer pays an instant fuel cost. It can release a vehicle only when at least one completed copy exists at a controlled vehicle factory. Releasing it consumes one completed stock item and creates the real vehicle near that factory.

## Ammunition stock

Ammunition is stored as quantities in a location/depot inventory rather than as hundreds of physical shell objects. This is intentional for performance. Example:

```text
MUNITIONS FACTORY
  general_ammo: 1000
  artillery_he: 80
  artillery_smoke: 24
```

The stock is still physically meaningful because it belongs to a real factory/depot and can only reach another location through a logistics job.

## HQ depot

Each faction has an HQ depot inventory. Completed non-vehicle factory stock is moved from factories to that depot by logistics jobs. Low-supply AI forces request general-ammunition and/or fuel resupply from the HQ depot. Fuel is not manufactured by a factory: a bounded amount of the faction's existing fuel resource is packed into `fuel_supply` at HQ when required, then must still travel in a logistics manifest to the force.

The old faction `ammo` resource still exists temporarily for older loadout/force-generation services. It is **not** factory output in v4.0.15. The long-term target remains replacing those remaining abstract-ammo uses with manufactured stock where gameplay benefits from it.

## Logistics job

A logistics job records:

- faction;
- origin type/id/position;
- destination type/id/position;
- cargo manifest;
- reason;
- current route progress;
- physical/virtual state;
- cargo/escort survival state.

Cargo is reserved from the source inventory when the job is created. It therefore cannot be duplicated by another job while in transit.

## Virtual convoy

When irrelevant to gameplay, a convoy is represented only by its server record. Progress is advanced using a low-cost virtual travel speed and current/destination position. No truck crew, vehicle pathfinding or escort AI is loaded.

A convoy becomes physical when its current simulated position is near:

- a human player;
- a hostile fighting unit capable of intercepting it;
- an active strategic-operation objective.

These checks use server truth only to decide **simulation relevance**. They do not reveal hidden enemy information to the AI commander or faction intelligence system.

## Physical convoy

Materialisation creates:

- one faction-appropriate cargo truck;
- one faction-appropriate armed escort where available;
- a real AI group and waypoint to the destination;
- the cargo manifest as vehicle debug/state metadata.

Destroying the cargo truck destroys the reserved cargo. Destroying only the escort leaves the cargo truck able to continue.

If the convoy has been physical for at least 30 seconds and there is no longer any meaningful nearby interaction, it is virtualised again. Its current position and remaining trip are saved before the physical vehicles/crew are deleted.

## Arrival

- Factory → HQ: cargo is added to faction depot inventory.
- HQ → force: `general_ammo` restores strategic ammunition supply; `fuel_supply` restores strategic fuel supply.
- Other factory delivery hooks can add stock back to a factory inventory.

This foundation intentionally does not yet simulate individual magazines/shell objects or hand-carry animations. The strategic stock, transport vehicle, journey and cargo loss are what matter.

## Debugging

The omniscient truth map shows:

- factory specialisation;
- current production job and ETA;
- local factory inventory at closer zoom;
- logistics job position and destination;
- PHYSICAL vs VIRTUAL state;
- manifest and logistics reason.

The Debug Console Economy page provides production tick, AI production-plan, logistics-plan and logistics-tick controls plus the selected faction's HQ depot contents.

## Runtime status

This implementation is statically validated but the hybrid materialisation/pathfinding behaviour must be tested in Arma. In particular, validate materialisation location, AI road/path choices, cargo-loss events and virtualisation after leaving a relevant area before marking the method PROVEN.
