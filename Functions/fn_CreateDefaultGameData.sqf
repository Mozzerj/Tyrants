/*
    Runtime GameData layout (kept compatible with the original mission UI):
    0: campaign data
       0: [setupStage, settings]
       1: west [basePos, steel, ammo, fuel, manpower]
       2: east [basePos, steel, ammo, fuel, manpower]
       3: player loadout records
    1: location data [towns, cities, factories]
    2: destroyed data [buildings, vehicles]
    3: vehicle catalogue [selectedDLCs, categories]
    4: purchased vehicles [west, east]
*/
[
    [
        [0, []],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        []
    ],
    [[], [], []],
    [[], []],
    [[], []],
    [[], []]
]
