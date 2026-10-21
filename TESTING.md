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

