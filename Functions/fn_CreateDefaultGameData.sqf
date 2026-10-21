/*
    Runtime GameData layout:
    0: campaign data
       0: [setupStage, settings]
       1: west [basePos, steel, ammo, fuel, manpower, research, VLS targets]
       2: east [basePos, steel, ammo, fuel, manpower, research, VLS targets]
       3: player loadout records
    1: location data [towns, cities, factories]
    2: destroyed data [buildings, vehicles]
    3: vehicle catalogue [selectedDLCs, categories]
    4: purchased vehicles [west, east]
    5: strategic emplacements [west, east]
*/
private _research = [[0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]];
[
    [
        [0, []],
        [0, 0, 0, 0, 0, +_research, []],
        [0, 0, 0, 0, 0, +_research, []],
        []
    ],
    [[], [], []],
    [[], []],
    [[], []],
    [[], []],
    [[], []]
]
