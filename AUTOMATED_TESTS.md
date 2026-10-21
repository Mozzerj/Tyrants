# Tyrants Automated Test Harness

This build includes a one-click in-game test harness for solo development.

## Running it

1. Host `Tyrants.Altis` in multiplayer.
2. Set **Solo Test Mode** to **Enabled** in mission parameters.
3. Join WEST or EAST and complete setup until normal gameplay begins.
4. Open the normal Arma action menu and choose **Run Tyrants Automated Tests**.
5. When it finishes, choose **Copy Last Tyrants Test Report** and paste the result back into ChatGPT if any checks fail.

The full report is also written to the Arma RPT with the prefix `[TYRANTS TEST]`.

## What it tests automatically

The test runner checks the live mission for:

- solo mode and one-player test conditions;
- successful transition to gameplay stage 4;
- discovered town/city/factory data;
- both faction base positions and base runtime objects;
- generated vehicle catalogue record/class validity and duplicates;
- current player loadout pricing;
- presence of a v3 persistent campaign save.

It then temporarily swaps the server to an isolated `GameData` sandbox and uses the real production functions to test:

- default v3 state structure;
- research definition count, key uniqueness and prerequisite references;
- research prerequisite rejection without charging steel;
- successful research purchase with exact resource deduction;
- duplicate purchase protection;
- dependent research and procurement-category gating;
- VLS target research gating;
- the 18-target VLS storage limit;
- emplacement definition/class availability;
- cruise-missile and target config dependencies;
- server-local creation of the VLS class;
- v3 serialization shape;
- absence of live object references in serialized saves;
- persistence of strategic target data;
- interception of test-time save/broadcast side effects.

The live campaign is restored after the suite. There is also a server fail-safe that restores the original `GameData` if a runtime error interrupts the test while its sandbox is active.

## What still needs a human/engine test

Automation deliberately does not attempt to click through UI controls or fire a real cruise missile. The following still need a short manual check when those systems change:

- visual correctness of setup/research/vehicle/emplacement dialogs;
- map interaction and map markers;
- an actual vehicle purchase/spawn and driving it;
- arsenal interaction;
- actual cruise-missile flight/impact behaviour;
- true two-or-more-player concurrency, JIP and opposing-player behaviour.

Those tests are kept manual because automating them from mission SQF would either be brittle or alter the live campaign/world in ways that make failures harder to diagnose.
