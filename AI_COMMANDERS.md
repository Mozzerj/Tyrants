# AI Commanders

AI commanders are faction controllers, not a separate cheat system. WEST, EAST and INDEPENDENT can independently be configured Human, AI or Disabled.

## Strategic loop

An AI think slice:

1. Ensures the faction has an affordable baseline force pool.
2. Evaluates currently available research using the same prerequisite/cost transaction used by players.
3. Checks whether the faction already has an active operation.
4. Scores strategic locations from persistent campaign state.
5. Assigns an available force and creates an attack operation.
6. Publishes a small public commander summary for UI.

Operations move force Groups toward their target. Once close enough, the force starts the normal server-owned territory capture process. Captures can therefore be contested by either of the other two factions or by human players.

## Performance rules

Commander objective scoring uses strategic location state rather than scanning every unit against every candidate. Think times are difficulty-dependent and staggered between factions. Operations run on a lower-frequency tick. Only active capture locations perform local presence scans.

## Current scope

The rewrite contains a functioning infantry strategic layer: faction economy, force creation, research spending, target selection, operations, movement, capture and persistence. The data model and internal services are designed for later combined-arms extensions (vehicle-backed forces, artillery support, air operations, threat/intelligence memory and VLS target selection) without changing the save/state architecture.

AI commander personalities are persisted (`balanced`, `aggressive`, `defensive`) so scoring can be expanded without a save redesign.
