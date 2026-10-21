params ["_personId"];
if (!isServer) exitWith {objNull};
private _personnel = TYR_State getOrDefault ["commandPersonnel",createHashMap];
private _rec = _personnel getOrDefault [_personId,createHashMap];
if (count _rec isEqualTo 0 || {!(_rec getOrDefault ["alive",false])}) exitWith {objNull};
private _runtime = TYR_Runtime getOrDefault ["commandPersonnel",createHashMap];
private _existing = _runtime getOrDefault [_personId,objNull];
if (!isNull _existing && {alive _existing}) exitWith {_existing};

private _fid = _rec getOrDefault ["faction",""];
private _f = [_fid] call TYR_fnc_StateGetFaction;
if (count _f isEqualTo 0) exitWith {objNull};
private _base = _f getOrDefault ["basePosition",[]];
private _preferred = +(_rec getOrDefault ["position",[]]);
if !([_preferred] call TYR_fnc_IsValidLandPosition) then {_preferred = _base};
private _spawn = [_preferred,_base] call TYR_fnc_FindSafeSpawnPosition;
if (count _spawn < 2) exitWith {objNull};

private _classMap = createHashMapFromArray [
    ["west","B_officer_F"],
    ["east","O_officer_F"],
    ["independent","I_officer_F"]
];
private _fallbackMap = createHashMapFromArray [
    ["west","B_G_Soldier_unarmed_F"],
    ["east","O_G_Soldier_unarmed_F"],
    ["independent","I_G_Soldier_unarmed_F"]
];
private _class = _classMap getOrDefault [_fid,""];
if !(_class isNotEqualTo "" && {isClass (configFile >> "CfgVehicles" >> _class)}) then {_class = _fallbackMap getOrDefault [_fid,""]};
if !(_class isNotEqualTo "" && {isClass (configFile >> "CfgVehicles" >> _class)}) exitWith {objNull};

private _side = [_fid] call TYR_fnc_FactionSide;
private _grp = createGroup [_side,true];
if (isNull _grp) exitWith {objNull};
private _unit = _grp createUnit [_class,_spawn,[],0,"NONE"];
if (isNull _unit) exitWith {deleteGroup _grp; objNull};
_unit setVariable ["TYR_factionId",_fid,true];
_unit setVariable ["TYR_commandPersonId",_personId,true];
_unit setVariable ["TYR_commandRole",_rec getOrDefault ["role","officer"],true];
_unit setVariable ["TYR_commandName",_rec getOrDefault ["name",_personId],true];
_unit allowFleeing 0;
_unit setBehaviour "SAFE";
doStop _unit;
_unit addEventHandler ["Killed",{
    params ["_unit"];
    private _id = _unit getVariable ["TYR_commandPersonId",""];
    if (_id isNotEqualTo "") then {[_id,_unit] call TYR_fnc_ServerCommandPersonKilled};
}];
_runtime set [_personId,_unit];
_rec set ["position",getPosATL _unit];
_rec set ["class",_class];
_unit
