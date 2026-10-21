# Tyrants Developer Debug Mode

Developer Debug Mode is a mission parameter intended for local development and controlled multiplayer testing. It is disabled by default.

## Enable it

In the mission lobby parameters set **Developer Debug Mode** to **Enabled**. Solo Test Mode is separate; enable both when you want the automated test harness as well as the debug tools.

## Opening the menu

During gameplay press **Y** to open the refreshed Tyrants command menu and choose **Developer Debug**. A direct **Open Tyrants Debug Menu** action is also available while debug mode is enabled.

## Current tools

- View live WEST/EAST resources.
- Add steel, ammo, fuel, or manpower to either faction.
- Boost or max all faction resources.
- Unlock or reset all research for either faction.
- Fill factory stockpiles.
- Force one factory production tick.
- Refill live friendly VLS/emplacements.
- Force a campaign save.
- Heal the local player.
- Teleport to friendly or enemy base.
- Launch the automated test suite (still requires Solo Test Mode and one human player).

All campaign-changing debug commands are validated and executed by the server. The remote debug endpoint exits immediately unless Developer Debug Mode was enabled in mission parameters.
