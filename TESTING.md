# Tyrants v4 Testing

## Static validation

Run from the mission root:

```text
python3 tools/validate_project.py
```

The validator checks packaging, includes, CfgFunctions, RemoteExec, dialog classes/IDs, legacy architecture regressions, persistence boundaries and three-faction lobby slots.

## In-game automated test

Enable **Developer Debug Mode**, open the developer console, expand **TESTING**, and run **RUN FULL AUTOTEST**. The report is copied to the clipboard and also written to RPT.

Current automated checks cover the absence of old `GameData`, three-faction state, faction resources/commander records, snapshot validation, runtime-object exclusion from saves, strategic location discovery, commander objective scoring, and the v4.0.10 intelligence state rules: contact creation, faction-only redaction, frozen last-known positions, identification upgrades, reacquisition position updates, and intelligence logging.

## First runtime smoke test

Recommended initial configuration:

- WEST: Human
- EAST: AI
- INDEPENDENT: AI
- AI difficulty: Regular
- Developer Debug Mode: Enabled

Verify that all three HQs appear, the WEST client fades in at its HQ, the Y menu opens, AI forces are created/move, territory ownership changes, faction resources update without large UI hitches, and a save/restart restores territory/assets/AI force state.

Also test joining EAST and INDEPENDENT lobby slots because the v4 mission file now exposes all three sides.

## Manual engine-only areas

The development environment cannot launch Arma 3, so these still require manual engine testing: exact dialog rendering, Arma AI pathfinding, locality/JIP behavior, cruise-missile flight, DLC/config availability and save persistence across a real dedicated-server process restart.


## Campaign reset / spawn safety

- Set **RESET SAVED CAMPAIGN ON START** to **RESET - Start Fresh** and launch once. Confirm deployment starts from a new campaign rather than the previous checkpoint.
- Return the parameter to **Keep Current Save** before the next restart and confirm the new campaign loads normally.
- A corrupt/legacy player position such as `[0,0,0]` must not place the player in the sea; restore must fall back to valid land near that faction's confirmed HQ.

## v4.0.10 intelligence runtime tasks

Some intelligence behaviours cannot be proven by static/server-only tests because they depend on the actual Arma client camera, map control and UAV interface. With **Developer Debug Mode** enabled, open the developer console, expand **TESTING**, and choose **MANUAL TEST TASKS**.

The task list can be marked PASS/FAIL from the console. It covers visual contact acquisition, lost-contact freezing, reacquisition, broad versus exact identification, UAV observation, location ownership confirmation, omniscient-truth versus faction-intelligence comparison, AI physical reconnaissance, and save/reload persistence.

Use **OMNISCIENT MAP** only as server truth for comparison. Use **FACTION INTEL MAP** to verify what the player's faction actually knows. **INTELLIGENCE LOG** shows collected observation events and their source.



## v4.0.11 rapid testing tools

With **Developer Debug Mode** enabled, open the Developer Operations Console:

- **VIEWS / MOVEMENT -> OPEN SPLENDID CAMERA** starts Arma's free developer camera. Use its normal controls to fly anywhere; Space teleports the player under the cursor. Exiting the camera returns to normal play. Debug-camera viewing is excluded from faction intelligence collection.
- **MAP CLICK TELEPORT** toggles arbitrary teleporting directly from either the omniscient map or faction-intelligence map. When enabled, left-click the embedded map to move the player/locally-controlled vehicle to that position.
- **TESTING -> COMMAND CONSOLE** opens a multiline SQF runner. **RUN LOCAL** executes on the client. **RUN SERVER** routes the same text through the debug-mode-gated authoritative server endpoint and returns the result.
- The mission host/logged-in admin can also use Arma's standard Debug Console because this DEV build sets `enableDebugConsole = 1`.

These tools are intentionally developer-only and must not be copied into a production/public build without revisiting access control.


## v4.0.12 physical command-network test

Enable **Developer Debug Mode**, open **COMMAND NETWORK**, and select the faction under **FACTION TARGET**.

- Use **TP TO MAIN COMMANDER** to verify that the commander is a physical NPC at/near the faction HQ.
- Use **KILL ONE OFFICER**, then run **RUN COMMANDER THINK**. The omniscient map should show a degraded command network and new orders should spend longer in `COMMAND_PENDING`.
- Use **KILL MAIN COMMANDER**. The faction should enter succession rather than being eliminated immediately; after about 30 seconds a surviving officer should become commander.
- Use **KILL ALL COMMAND**. Existing forces with already-delivered orders should continue those orders, while the commander AI should stop issuing new strategic orders.
- With sufficient manpower and a functioning HQ, an emergency commander can appear after the collapse recovery timer. Repeatedly destroying replacements faster than they recover should eventually create sustained collapse.
- Compare **OMNISCIENT MAP** against the normal faction map: own command personnel are known, but enemy command personnel must not be revealed merely because the server knows who they are.
- Save/reload while an officer is dead or an order is pending and verify the command state returns without resurrecting killed personnel.

**FAST-FORWARD COMMAND TIMER** advances whichever command timer is currently relevant for the selected faction. During succession it promotes the surviving successor immediately; while missing officers it advances the replacement attempt; during full collapse it advances emergency recovery when a valid HQ/manpower route exists, otherwise it moves the collapse close to the elimination deadline. This exists only to avoid waiting minutes during developer tests.

## v4.0.13 strategic AI overhaul test

Enable **Developer Debug Mode** and use an AI-controlled faction as the target in the Developer Operations Console.

1. Open **AI COMMAND -> SHOW AI DECISION FLOW**.
2. Press **RUN THINK + TRACE**. The real commander think should traverse 12 nodes slowly. The live node should be amber, completed connectors/nodes should turn green, and blocked/branch/skipped stages should have different colours.
3. Confirm the candidate panel shows ranked actions with PASS/X validation states and the outcome panel shows posture + final decision.
4. Press **SHOW AI ORDER MAP**. For a force operation, confirm a line is drawn from the assigned force to the target. While `COMMAND_PENDING`, a bright command route should run through the physical command nodes and show order ETA/reroutes.
5. Kill one command officer and issue another traced think. Pending orders should take longer/reroute and the order map should update.
6. Use the faction-intelligence map to leave a strategic location unknown, then run a think. The AI should prefer RECON/PROBE for that unknown site rather than attacking it based on hidden ownership.
7. Observe an enemy Main Commander legitimately with the intelligence system, then run a think for the observing AI faction. A recent identified COMMAND contact should be eligible as a high-value RAID candidate if force/reserve/command validation permits it.
8. Kill all command personnel. A traced think should stop strategic planning at COMMAND COLLAPSE; already delivered force movement should continue, but no new strategic force order should be created.
9. Create a known hostile contact near the AI HQ/owned strategic site. The next think should select `emergency_defence` posture and prefer defence/reinforcement actions.
10. Let a contact-based raid become stale for more than four minutes. Operation review should abort it rather than tracking the live target magically.

The full autotest also checks that the strategic AI can build a picture, posture and ranked candidates. Runtime testing remains required for Arma waypoint/combat behaviour and the visual debug-flow/map rendering.
