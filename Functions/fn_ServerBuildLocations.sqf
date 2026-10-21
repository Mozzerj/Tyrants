if (!isServer) exitWith {};

private _townLocations = nearestLocations [[0, 0, 0], ["NameCity", "NameVillage"], 999999];
private _cityLocations = nearestLocations [[0, 0, 0], ["NameCityCapital"], 999999];
private _factoryBuildings = nearestObjects [[0, 0, 0], ["Land_dp_mainFactory_F", "Land_Factory_Main_F", "Land_DPP_01_smallFactory_F"], 999999];

private _towns = [];
{
    _towns pushBack [format ["Town_%1", _forEachIndex], "ColorGUER", "ColorGUER", "ColorGUER", locationPosition _x, 0, 0];
} forEach _townLocations;

private _cities = [];
{
    _cities pushBack [format ["City_%1", _forEachIndex], "ColorGUER", "ColorGUER", "ColorGUER", locationPosition _x, 0, 0];
} forEach _cityLocations;

private _factoryGroups = [];
while {count _factoryBuildings > 0} do {
    private _seed = _factoryBuildings deleteAt 0;
    private _group = [_seed];
    private _remaining = [];

    {
        if ((getPosATL _seed) distance (getPosATL _x) < 250) then {
            _group pushBack _x;
        } else {
            _remaining pushBack _x;
        };
    } forEach _factoryBuildings;

    _factoryBuildings = _remaining;
    _factoryGroups pushBack _group;
};

private _factoryTypes = ["Fuel", "Steel", "Ammo"];
private _factories = [];
{
    private _group = _x;
    private _sum = [0, 0, 0];
    {
        _sum = _sum vectorAdd (getPosATL _x);
    } forEach _group;

    private _count = (count _group) max 1;
    private _averagePos = _sum vectorMultiply (1 / _count);
    private _fuelTanks = nearestObjects [_averagePos, ["Land_dp_bigTank_F", "Land_dp_smallTank_F", "Land_StorageTank_01_large_F", "Land_StorageTank_01_small_F"], 200];
    private _parts = +_group;
    {_parts pushBackUnique _x} forEach _fuelTanks;

    _factories pushBack [
        format ["factory_%1", _forEachIndex],
        "ColorGUER",
        "ColorGUER",
        "ColorGUER",
        _averagePos,
        _parts,
        0,
        _factoryTypes # (_forEachIndex mod count _factoryTypes),
        0
    ];
} forEach _factoryGroups;

private _locationData = [_towns, _cities, _factories];

// Re-apply dynamic ownership/stock from a v2 save to the freshly discovered world objects.
if (!isNil "TYR_savedLocationState" && {TYR_savedLocationState isEqualType []}) then {
    {
        private _savedCategory = TYR_savedLocationState param [_forEachIndex, []];
        private _runtimeCategory = _x;

        {
            private _runtimeRegion = _x;
            private _savedIndex = _savedCategory findIf {(_x # 0) isEqualTo (_runtimeRegion # 0)};
            if (_savedIndex >= 0) then {
                private _saved = _savedCategory # _savedIndex;
                _runtimeRegion set [1, _saved # 1];
                _runtimeRegion set [2, _saved # 2];
                _runtimeRegion set [3, _saved # 3];
                if ((count _runtimeRegion) > 6 && {count _saved > 4}) then {
                    _runtimeRegion set [6, _saved # 4];
                };
            };
        } forEach _runtimeCategory;
    } forEach _locationData;
};

GameData set [1, _locationData];
[] call TYR_fnc_ServerBroadcastState;
diag_log format ["[TYRANTS] Locations built: %1 towns, %2 cities, %3 factories", count _towns, count _cities, count _factories];
