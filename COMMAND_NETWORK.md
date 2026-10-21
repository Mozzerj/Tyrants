# Tyrants v4.0.12 physical command network

The campaign victory layer now uses a physical command hierarchy rather than the old accountant-death shortcut.

## Hierarchy

Each active faction starts with:

- 1 physical Main Commander NPC
- 3 physical named command officers
- AI force leaders acting as physical force commanders

The player character is not automatically the strategic commander.

## Strategic orders

AI-created operations start in `command_pending`. A command order record carries the faction, force, operation, target, route and delivery time. Only `ServerCommandDeliverOrders` can move the operation into the active `move` phase.

Approximate propagation delays by network condition:

- Operational: 3 seconds
- Degraded: 8 seconds
- Isolated commander: 14 seconds
- Succession disruption: 18 seconds
- Collapsed/eliminated: no new strategic orders

If a commander/officer on the pending route dies before delivery, the order reroutes through the surviving network and receives a new propagation delay.

## Loss, succession and replacement

- Main Commander killed: surviving officers maintain a disrupted network; after 30 seconds the highest-ranking surviving officer becomes commander.
- Missing officers: replacement attempt every 180 seconds, costing 2 manpower each.
- No commander and no officers: the faction enters Command Collapse.
- A physical HQ/replacement route plus 5 manpower can produce an emergency commander after 120 seconds.
- If command remains collapsed for 240 seconds, the faction is eliminated.

These timings are initial gameplay values and can be balanced later.

## Disconnected forces

Already-delivered operations keep running after command loss. Forces therefore continue their last orders/local tactical AI rather than disappearing or becoming inert. New strategic operations cannot be delivered while the network is collapsed.

## Intelligence

Own command personnel are known to their own faction. Hostile command personnel are ordinary physical enemy units from the intelligence system's point of view; the server does not replicate their command identity/position to enemies for free. The omniscient debug map is developer-only and may display the full network.

## Persistence

The save system stores primitive command records only: IDs, roles, names, alive state, positions, network IDs/timers and pending order data. Arma Object/Group references remain runtime-only.

## Current limitations

- Human strategic-order UI does not yet create the same command-order queue because the human strategic commander interface is not implemented yet.
- The replacement route currently keys off the existing HQ object; a separate destructible command-post system is still planned.
- Radio range, jamming and physical relay distance are not yet part of connectivity.
- Enemy intelligence can observe the personnel as units, but identifying a particular hostile contact as a named commander/officer needs later HUMINT/SIGINT/intelligence work.
