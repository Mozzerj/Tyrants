# AI Commanders

AI commanders are faction controllers, not a separate cheat system. WEST, EAST and INDEPENDENT can independently be configured Human, AI or Disabled. The v4.0.13 strategic AI uses the faction's own state plus its collected intelligence; it does not read hidden hostile truth to decide where or what to attack.

## Actual strategic decision path

Each commander think follows the same twelve-stage path:

1. **Command State** — check the physical command network and whether new strategic intent can be issued.
2. **Emergency Override** — look for recent faction-known enemy contacts threatening the HQ or controlled strategic sites.
3. **Strategic Picture** — build a compact picture of own forces/resources/operations plus observed/stale enemy locations and contacts.
4. **Operation Review** — continue or abort operations that are dead, timed out, overridden by an emergency, or based on contact intel that became too stale.
5. **Posture** — choose emergency defence, defensive, consolidate, probe, offensive, exploit, or hold.
6. **Generate Actions** — create only actions that make sense from the faction's current knowledge and capabilities.
7. **Score Actions** — compare strategic value, travel distance, intel age, posture, personality, command condition and reserve pressure.
8. **Validate** — reject candidates that fail hard prerequisites such as force availability, resources, reserve rules, intel freshness or a functioning command route.
9. **Create Order** — select the highest-ranked candidate that passed validation.
10. **Command Route** — queue force orders through Main Commander -> surviving officer -> force commander and apply physical propagation delay/rerouting.
11. **Force Execution** — after delivery, the force executes locally through Arma group behaviour and the operation state machine.
12. **Review / Outcome** — record the decision and let later commander ticks reassess the operation.

See `AI_STRATEGIC_OVERHAUL.md` for the detailed branches and debug instrumentation.

## Currently generated strategic actions

The framework currently creates and scores actions supported by existing Tyrants systems:

- emergency defend HQ / threatened friendly locations;
- reinforce a second threatened location;
- defend a high-value friendly strategic site while defensive/consolidating;
- attack known hostile or neutral strategic locations;
- exploit when an aggressive commander has sufficient strength;
- recon/probe unknown locations instead of secretly knowing their owner;
- raid recent known command personnel, emplacements or vehicle contacts at their last-known position;
- raise an infantry force using the real faction-resource transaction;
- buy eligible research using the normal research service;
- hold and preserve reserve when no candidate is good enough.

The candidate/validation architecture is intentionally extensible. Artillery, air, SAM/C-RAM, physical factory production, logistics convoys, spies and satellites should enter this same pipeline when those gameplay systems exist instead of being special AI cheats.

## Intelligence rules

The commander may use current truth for **its own** controlled locations, forces, resources and command network. Hostile information comes from the faction knowledge database. Unknown locations generate reconnaissance/probe choices. Recent observed command personnel can become high-value raid candidates. Last-known contacts stop moving when observation is lost and become less attractive as their intel ages.

A restored save deliberately treats live observation timestamps as stale until a contact/location is physically observed again; the saved historical observation remains available, but the AI does not pretend the pre-restart server clock is current.

## Command and reserves

Strategic operations requiring a force enter `command_pending`; movement does not begin until the physical command network delivers the order. Broken routes can reroute and add delay. Command collapse blocks new strategic intent while already-delivered orders continue locally.

Offensive candidates keep the commander's configured reserve ratio uncommitted. Difficulty affects desired force count, strategic operation slots and scheduler response time rather than granting hidden resources or enemy knowledge.

## Operation execution

Operations currently support attack, exploit, defend, reinforce, recon, probe, raid and withdraw states. Delivered force orders generate Arma waypoints with behaviour/speed appropriate to the operation. Attacks on strategic locations feed the normal server-owned capture system. Recon/probe/raid use finite search windows, while defensive deployments hold before completing. Failed/reassessed operations clear their old waypoints so a force is not left silently following an abandoned plan.

## Debugging

Developer Debug Mode exposes the actual explicit AI logic, not fabricated human-like thoughts:

- **RUN THINK + TRACE** executes the same commander path slowly enough to watch.
- **AI STRATEGIC DECISION PATH** is a 12-node flowchart. The live step is amber; traversed transitions turn green; blocked/skipped/branch outcomes have distinct states.
- The candidate panel shows ranked actions and validation PASS/X results.
- The outcome panel shows the selected posture and final decision.
- **SHOW AI ORDER MAP** draws live operation targets, assigned-force-to-target lines, command-pending routes through commander/officers, ETA, reroutes, phase and score. At close zoom it also shows the reason for the selected operation.

The flow view polls only the compact trace payload while active, rather than retransmitting every map entity several times per second.

## Performance rules

The strategic commander operates on low-frequency staggered scheduler slices. Candidate generation uses strategic records and faction knowledge rather than scanning the entire world for hidden enemies. Tactical movement is delegated to Arma groups after intent delivery. Debug trace polling is developer-only and uses a small targeted payload.
