params ["_factionId","_class",["_free",false]];
if (!isServer) exitWith {[false,"Server only",""]};
private _f = [_factionId] call TYR_fnc_StateGetFaction;
if (count _f isEqualTo 0 || {!(_f getOrDefault ["active",false])}) exitWith {[false,"Faction unavailable",""]};
if !(_class in (_f getOrDefault ["vehiclePool",[]])) exitWith {[false,"Vehicle is not in this faction pool",""]};
if !(isClass (configFile >> "CfgVehicles" >> _class)) exitWith {[false,"Vehicle class is unavailable",""]};

private _cat = [_class] call TYR_fnc_VehicleCategory;
private _gate = switch (_cat) do {
    case "armored": {"proc.armored"};
    case "heavy": {"proc.heavy"};
    case "rotary": {"proc.rotary"};
    case "artillery": {"proc.artillery"};
    case "fixed": {"proc.fixed"};
    default {""};
};
if (_gate isNotEqualTo "" && {!([_factionId,_gate] call TYR_fnc_StateResearchUnlocked)}) exitWith {[false,"Required procurement research is locked",""]};

private _spawnPos = +(_f getOrDefault ["basePosition",[]]);
private _sourceFactory = "";
private _productKey = format ["vehicle:%1",_class];
if (!_free) then {
    private _bestDist = 1e12;
    {
        private _loc = (TYR_State getOrDefault ["locations",createHashMap]) get _x;
        if ((_loc getOrDefault ["kind",""]) isEqualTo "factory" && {(_loc getOrDefault ["factoryType",""]) isEqualTo "vehicle"} && {(_loc getOrDefault ["owner","neutral"]) isEqualTo _factionId}) then {
            private _inv = _loc getOrDefault ["inventory",createHashMap];
            if ((_inv getOrDefault [_productKey,0]) > 0) then {
                private _p = +(_loc getOrDefault ["position",[]]);
                private _d = if (count _spawnPos >= 2) then {_p distance2D _spawnPos} else {0};
                if (_d < _bestDist) then {_bestDist = _d; _sourceFactory = _x; _spawnPos = _p};
            };
        };
    } forEach keys (TYR_State getOrDefault ["locations",createHashMap]);
    if (_sourceFactory isEqualTo "") exitWith {};
};
if (!_free && {_sourceFactory isEqualTo ""}) exitWith {[false,"No completed vehicle of this type exists at a controlled vehicle factory. Queue production first.",""]};
if (count _spawnPos < 2) exitWith {[false,"No valid vehicle production/spawn location",""]};

if (!_free) then {
    private _loc = [_sourceFactory] call TYR_fnc_StateGetLocation;
    private _inv = _loc getOrDefault ["inventory",createHashMap];
    _inv set [_productKey,(_inv getOrDefault [_productKey,1]) - 1];
    _loc set ["inventory",_inv];
    [_sourceFactory,_factionId] call TYR_fnc_ServerPublishLocation;
};

private _id = ["vehicle"] call TYR_fnc_StateNextId;
private _pos = _spawnPos vectorAdd [12 + random 15,12 + random 15,0];
private _obj = createVehicle [_class,_pos,[],0,"NONE"];
if (isNull _obj) exitWith {
    if (!_free && {_sourceFactory isNotEqualTo ""}) then {
        private _loc = [_sourceFactory] call TYR_fnc_StateGetLocation;
        private _inv = _loc getOrDefault ["inventory",createHashMap];
        _inv set [_productKey,(_inv getOrDefault [_productKey,0]) + 1];
        _loc set ["inventory",_inv];
    };
    [false,"Vehicle could not be created",""]
};
_obj setVariable ["TYR_persistentId",_id,true];
_obj setVariable ["TYR_factionId",_factionId,true];
_obj addEventHandler ["Killed",{params ["_veh"];[_veh] call TYR_fnc_ServerVehicleKilled}];
(TYR_Runtime get "vehicles") set [_id,_obj];
(TYR_State get "vehicles") set [_id,createHashMapFromArray [
    ["id",_id],["faction",_factionId],["class",_class],["position",_pos],["direction",getDir _obj],
    ["damage",0],["fuel",1],["ammo",1],["cargo",[[],[],[],[]]]
]];
["vehicle-release"] call TYR_fnc_StateMarkDirty;
[_factionId] call TYR_fnc_ServerPublishFaction;
[true,format ["Released produced %1 from %2",getText (configFile >> "CfgVehicles" >> _class >> "displayName"),if (_sourceFactory isEqualTo "") then {"debug supply"} else {_sourceFactory}],_id]
