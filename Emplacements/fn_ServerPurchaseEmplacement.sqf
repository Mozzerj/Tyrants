params ["_key","_position"];
if (!isServer) exitWith {};
private _owner = remoteExecutedOwner;
private _player = [_owner] call TYR_fnc_FindPlayerByOwner;
if (isNull _player) exitWith {};
private _fid = [side _player] call TYR_fnc_SideFaction;
private _defs = call TYR_fnc_GetEmplacementDefinitions;
private _i = _defs findIf {(_x # 0) isEqualTo _key};
if (_i < 0) exitWith {};
private _def = _defs # _i;
if !(_def # 5) exitWith {[_player,"TYR_fnc_ClientHint",["That emplacement is not enabled."]] call TYR_fnc_ServerSendToPlayer};
if !([_fid,_def # 2] call TYR_fnc_StateResearchUnlocked) exitWith {[_player,"TYR_fnc_ClientHint",["Required infrastructure research is locked."]] call TYR_fnc_ServerSendToPlayer};
if !(_position isEqualType [] && {count _position >= 2} && {!surfaceIsWater _position}) exitWith {};

private _locations = TYR_State get "locations";
private _nearFriendly = false;
{
    private _l = _locations get _x;
    if ((_l getOrDefault ["owner","neutral"]) isEqualTo _fid && {(_l get "position") distance2D _position <= 500}) exitWith {_nearFriendly=true};
} forEach keys _locations;
if (!_nearFriendly) exitWith {[_player,"TYR_fnc_ClientHint",["Placement must be within 500m of friendly territory."]] call TYR_fnc_ServerSendToPlayer};
if (count (nearestObjects [_position,["AllVehicles","Building"],8]) > 0) exitWith {[_player,"TYR_fnc_ClientHint",["Placement area is obstructed."]] call TYR_fnc_ServerSendToPlayer};

private _f = [_fid] call TYR_fnc_StateGetFaction;
private _r = _f get "resources";
private _cost = _def # 3;
if ((_r getOrDefault ["steel",0]) < _cost) exitWith {[_player,"TYR_fnc_ClientHint",[format ["Need %1 steel.",_cost]]] call TYR_fnc_ServerSendToPlayer};
if !(isClass (configFile >> "CfgVehicles" >> (_def # 4))) exitWith {[_player,"TYR_fnc_ClientHint",["Emplacement class is unavailable."]] call TYR_fnc_ServerSendToPlayer};

_r set ["steel",(_r get "steel")-_cost];
private _id = ["emplacement"] call TYR_fnc_StateNextId;
private _obj = createVehicle [_def # 4,_position,[],0,"NONE"];
_obj setVariable ["TYR_persistentId",_id,true];
_obj setVariable ["TYR_factionId",_fid,true];
_obj setVariable ["TYR_emplacementKey",_key,true];
if (_key isEqualTo "vls") then {_obj setVehicleAmmo 1};
_obj addEventHandler ["Killed",{
    params ["_obj"];
    private _id = _obj getVariable ["TYR_persistentId",""];
    if (_id isNotEqualTo "") then {
        (TYR_State get "emplacements") deleteAt _id;
        (TYR_Runtime get "emplacements") deleteAt _id;
        ["emplacement-killed"] call TYR_fnc_StateMarkDirty;
    };
}];
(TYR_Runtime get "emplacements") set [_id,_obj];
if (_key isEqualTo "vls") then {[_obj,"vls",_fid] remoteExec ["TYR_fnc_ClientAttachEmplacementActions",0,_obj]};
(TYR_State get "emplacements") set [_id,createHashMapFromArray [
    ["id",_id],["faction",_fid],["key",_key],["class",_def # 4],["position",_position],
    ["direction",getDir _obj],["damage",0],["ammo",1]
]];
["emplacement"] call TYR_fnc_StateMarkDirty;
[_fid] call TYR_fnc_ServerPublishFaction;
[_player,"TYR_fnc_ClientHint",["Emplacement deployed."]] call TYR_fnc_ServerSendToPlayer;
