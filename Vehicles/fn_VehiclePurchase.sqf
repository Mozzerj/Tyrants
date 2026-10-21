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

private _base = _f getOrDefault ["basePosition",[]];
if (count _base < 2) exitWith {[false,"Faction HQ is not available",""]};
private _cost = [_class] call TYR_fnc_VehicleCost;
private _r = _f get "resources";
if (!_free && {(_r getOrDefault ["fuel",0]) < _cost}) exitWith {[false,format ["Need %1 fuel resources",_cost],""]};
if (!_free) then {_r set ["fuel",(_r get "fuel") - _cost]};

private _id = ["vehicle"] call TYR_fnc_StateNextId;
private _pos = _base vectorAdd [12 + random 15,12 + random 15,0];
private _obj = createVehicle [_class,_pos,[],0,"NONE"];
if (isNull _obj) exitWith {
    if (!_free) then {_r set ["fuel",(_r get "fuel") + _cost]};
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
["vehicle-purchase"] call TYR_fnc_StateMarkDirty;
[_factionId] call TYR_fnc_ServerPublishFaction;
[true,format ["Purchased %1",getText (configFile >> "CfgVehicles" >> _class >> "displayName")],_id]
