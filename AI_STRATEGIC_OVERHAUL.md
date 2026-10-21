# Tyrants v4.0.13 strategic AI overhaul

## Purpose

The AI is intended to behave like a strategic player that has incomplete information, finite forces/resources, a physical command network, and a need to preserve reserves. It is not permitted to query hidden hostile state simply because the server owns that state.

## Decision path

Every strategic think follows this sequence:

### 1. Command State

- Is the faction active and not eliminated?
- Is another think already running for this faction? If so, skip the overlapping think.
- What is the physical command-network status?
- If collapsed/eliminated, do not create a new strategic operation. Existing delivered force orders continue locally.

### 2. Emergency Override

Using faction-known contacts only:

- Is a recent contact within the critical HQ radius?
- Is a recent contact close to a currently controlled strategic location?
- If yes, emergency-defence choices receive overwhelming priority and non-defensive active operations can be aborted.

### 3. Strategic Picture

Build a small per-think picture containing:

- current friendly forces and free forces;
- force positions and current operations;
- friendly resources/research;
- current command-network condition;
- true current ownership of the faction's own sites;
- observed/stale ownership for non-friendly sites;
- unknown locations;
- last-known enemy contacts, observation age, source and identification state;
- known emergency threats.

A stale belief that a now-lost location is still friendly is treated as a **belief**, not silently corrected from hidden server truth.

### 4. Operation Review

For every active operation:

- assigned force destroyed/missing -> abort;
- operation older than 15 minutes -> abort;
- known emergency threat while operation is non-defensive -> abort;
- contact-based target older than 240 seconds -> abort;
- otherwise continue.

Aborting clears the force's operation and obsolete waypoints. Pending command orders for that operation are removed.

### 5. Posture

Priority order:

1. known critical threat -> `emergency_defence`;
2. disrupted command -> `defensive`;
3. insufficient force strength/ammo/fuel -> `consolidate`;
4. incomplete map knowledge -> `probe`;
5. known hostile objective + mobile reserve -> `offensive` or `exploit`;
6. defensive personality -> `defensive`;
7. otherwise -> `hold`.

### 6. Generate Actions

Current action generators:

- defend HQ;
- defend threatened friendly location;
- reinforce a second threatened location;
- defend a high-value friendly site while defensive/consolidating;
- attack/exploit known hostile location;
- expand into known neutral location;
- recon/probe unknown location;
- raid recent observed command personnel/emplacement/vehicle contact at its last-known position;
- raise force;
- research;
- hold.

An unknown location never becomes an attack target merely because its true server owner is hostile.

### 7. Score Actions

The current score uses:

- candidate base/strategic value;
- distance to nearest free force;
- intelligence age;
- strategic posture;
- commander personality;
- command-network condition;
- special priority for emergency defence and observed command personnel.

The score is not a confidence percentage. It is only a comparative utility value between legal candidate actions.

### 8. Validate

Candidates are tested from highest score downward:

- minimum score;
- valid target position;
- free force exists when required;
- real resource cost is affordable for research/force generation;
- command route can issue the order;
- offensive reserve ratio remains protected;
- contact target is not too stale.

The first candidate that passes becomes the decision. If nothing passes, the AI holds rather than inventing an action.

### 9. Create Order

Immediate strategic actions such as research or force generation call the same authoritative services used by the rest of the game. Force operations create a persistent operation record with target, target type, last-known coordinate, score, reason, posture and assigned force.

### 10. Command Route

Force operations start as `command_pending`. `ServerCommandQueueOrder` calculates the real physical command route and propagation delay. Losing an officer can cause a pending order to reroute and restart its delay.

### 11. Force Execution

After delivery the operation changes to movement/execution. The force uses normal Arma group movement/combat behaviour rather than strategic omniscience. Current operation state types include:

- attack / exploit;
- defend / reinforce;
- recon / probe;
- raid;
- withdraw.

### 12. Review / Outcome

The explicit decision, posture, candidates, rejection reasons and stage outcomes are written only to server runtime debug telemetry. Later think ticks rebuild the strategic picture from current faction knowledge and can continue, abort or replace the plan.

## Debug flowchart

The Developer Operations Console contains an actual 12-stage flow view. `RUN THINK + TRACE` runs the same decision function with a short delay between stage commits so the current node can be seen in-game. This does not run a separate fake explanation algorithm.

Node states:

- green: completed;
- blue: branch/choice point;
- red: blocked/failure;
- amber: current stage;
- dark grey: skipped/future.

Connectors into the live stage are amber; completed connectors turn green. Ranked candidates and validation outcomes are shown beside the flow.

## Debug command map

The omniscient debug map draws:

- every active strategic AI operation;
- target and operation type;
- operation phase and score;
- reason when zoomed in;
- line from assigned force to intended target;
- physical command-order route from commander through officers to force commander while pending;
- order ID, operation ID, delivery ETA and reroute count.

This map is intentionally omniscient developer telemetry and is never used as faction knowledge.

## Future action hooks

The pipeline is deliberately ready for later systems, but v4.0.13 does **not** fake capabilities that Tyrants does not yet simulate fully. Future candidate generators can add:

- physical factory product/retool choices;
- artillery fire missions and counter-battery responses;
- SAM/C-RAM engagement/munition decisions;
- air/CAS/SEAD missions;
- VLS strategic strike choices based on legitimate coordinates;
- physical logistics/resupply routes;
- spies, satellite tasking and SIGINT.

Those actions should plug into Generate -> Score -> Validate -> Command Route rather than bypassing the strategic model.
