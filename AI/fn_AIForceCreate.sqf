params ["_factionId",["_role","infantry"],["_free",false]];
if (!isServer) exitWith {""};

private _f = [_factionId] call TYR_fnc_StateGetFaction;
if (count _f isEqualTo 0 || {!(_f getOrDefault ["active",false])}) exitWith {""};

private _unitClasses = switch (_factionId) do {
    case "west": {["B_G_Soldier_TL_F","B_G_Soldier_AR_F","B_G_Soldier_LAT_F","B_G_Soldier_F","B_G_Soldier_F","B_G_medic_F"]};
    case "east": {["O_G_Soldier_TL_F","O_G_Soldier_AR_F","O_G_Soldier_LAT_F","O_G_Soldier_F","O_G_Soldier_F","O_G_medic_F"]};
    default {["I_G_Soldier_TL_F","I_G_Soldier_AR_F","I_G_Soldier_LAT_F","I_G_Soldier_F","I_G_Soldier_F","I_G_medic_F"]};
};
_unitClasses = _unitClasses select {isClass (configFile >> "CfgVehicles" >> _x)};
if (count _unitClasses isEqualTo 0) exitWith {""};

private _pos = _f getOrDefault ["basePosition",[]];
if (count _pos < 2) exitWith {""};
if ((_pos # 0) <= 0 && {(_pos # 1) <= 0}) exitWith {""};

private _side = [_factionId] call TYR_fnc_FactionSide;
if (_side isEqualTo sideUnknown) exitWith {""};

private _r = _f get "resources";
private _costSteel = 1200;
private _costAmmo = 800;
private _costMan = 6;
if (!_free && {
    (_r getOrDefault ["steel",0]) < _costSteel ||
    {(_r getOrDefault ["ammo",0]) < _costAmmo} ||
    {(_r getOrDefault ["manpower",0]) < _costMan}
}) exitWith {""};

// Create the runtime force before charging the faction. If Arma cannot create the
// requested group or all units, tear down the partial group and leave resources
// untouched. This keeps AI planning failures from becoming economy losses.
private _grp = createGroup [_side,true];
if (isNull _grp) exitWith {""};

private _created = [];
{
    private _u = _grp createUnit [_x,_pos,[],20,"FORM"];
    if (!isNull _u) then {
        _u setVariable ["TYR_factionId",_factionId,true];
        _created pushBack _u;
    };
} forEach _unitClasses;

if ((count _created) != (count _unitClasses)) exitWith {
    {deleteVehicle _x} forEach _created;
    deleteGroup _grp;
    ""
};

if (!_free) then {
    _r set ["steel",(_r get "steel")-_costSteel];
    _r set ["ammo",(_r get "ammo")-_costAmmo];
    _r set ["manpower",(_r get "manpower")-_costMan];
};

private _id = ["force"] call TYR_fnc_StateNextId;
(TYR_Runtime get "forces") set [_id,_grp];
(TYR_State get "forces") set [_id,createHashMapFromArray [
    ["id",_id],
    ["faction",_factionId],
    ["role",_role],
    ["position",_pos],
    ["unitClasses",_unitClasses],
    ["operation",""],
    ["supply",createHashMapFromArray [["ammo",100],["fuel",100]]],
    ["active",true]
]];

[_id] call TYR_fnc_ServerCommandAssignForce;
["ai-force"] call TYR_fnc_StateMarkDirty;
[_factionId] call TYR_fnc_ServerPublishFaction;
_id
