if (!isServer) exitWith {};
private _center = [worldSize * 0.5,worldSize * 0.5,0];
private _radius = worldSize * 0.8;
private _existing = TYR_Runtime getOrDefault ["loadedLocations",createHashMap];
private _locations = createHashMap;

private _add = {
    params ["_kind","_name","_pos",["_stock",0],["_resource",""],["_value",1]];
    private _id = format ["%1_%2_%3",_kind,round (_pos # 0),round (_pos # 1)];
    private _saved = _existing getOrDefault [_id,createHashMap];
    private _owner = _saved getOrDefault ["owner","neutral"];
    private _savedStock = _saved getOrDefault ["stock",_stock];
    _locations set [_id,createHashMapFromArray [
        ["id",_id],["kind",_kind],["name",_name],["position",_pos],["owner",_owner],
        ["stock",_savedStock],["resource",_resource],["value",_value]
    ]];
};

{
    private _pos = locationPosition _x;
    ["town",text _x,_pos,0,"",2] call _add;
} forEach (nearestLocations [_center,["NameVillage","NameCity"],_radius]);

{
    private _pos = locationPosition _x;
    ["city",text _x,_pos,0,"",4] call _add;
} forEach (nearestLocations [_center,["NameCityCapital"],_radius]);

private _factoryClasses = ["Land_dp_mainFactory_F","Land_Factory_Main_F","Land_DPP_01_smallFactory_F"];
private _buildings = nearestObjects [_center,_factoryClasses,_radius];
private _factoryParts = createHashMap;
private _factoryTypes = ["vehicle","munitions","air_defence","strategic"];
private _factoryIndex = 0;
while {count _buildings > 0} do {
    private _seed = _buildings deleteAt 0;
    private _seedPos = getPosATL _seed;
    private _group = [_seed];
    for "_i" from ((count _buildings)-1) to 0 step -1 do {
        private _b = _buildings # _i;
        if (_seedPos distance2D _b < 250) then {
            _group pushBack _b;
            _buildings deleteAt _i;
        };
    };
    private _sum = [0,0,0];
    {_sum = _sum vectorAdd getPosATL _x} forEach _group;
    private _pos = _sum vectorMultiply (1 / ((count _group) max 1));
    private _factoryType = _factoryTypes # (_factoryIndex mod count _factoryTypes);
    private _factoryLabel = switch (_factoryType) do {case "vehicle":{"VEHICLE"};case "munitions":{"MUNITIONS"};case "air_defence":{"AIR DEFENCE"};default {"STRATEGIC"}};
    private _id = format ["factory_%1_%2",round (_pos # 0),round (_pos # 1)];
    private _saved = _existing getOrDefault [_id,createHashMap];
    private _inventory = _saved getOrDefault ["inventory",createHashMap];
    private _queue = +(_saved getOrDefault ["productionQueue",[]]);
    _locations set [_id,createHashMapFromArray [
        ["id",_id],["kind","factory"],["name",format ["%1 FACTORY",_factoryLabel]],["position",_pos],
        ["owner",_saved getOrDefault ["owner","neutral"]],["stock",0],["resource",""],["value",3],
        ["factoryType",_saved getOrDefault ["factoryType",_factoryType]],["inventory",_inventory],["productionQueue",_queue],
        ["productionOperational",true],["productionLastTick",serverTime],["lastProduction",_saved getOrDefault ["lastProduction",-1]],["lastProductionText",_saved getOrDefault ["lastProductionText",""]]
    ]];
    _factoryParts set [_id,_group];
    _factoryIndex = _factoryIndex + 1;
};

TYR_State set ["locations",_locations];
TYR_Runtime set ["factoryParts",_factoryParts];
TYR_Runtime set ["loadedLocations",createHashMap];
diag_log format ["[TYRANTS V4] World index built: %1 strategic locations.",count keys _locations];
