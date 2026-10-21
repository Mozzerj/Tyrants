params ["_sideIndex"];
if (!isServer) exitWith {};
if !(_sideIndex in [0, 1]) exitWith {};

private _side = [west, east] # _sideIndex;
private _enemySide = [east, west] # _sideIndex;
private _baseDataIndex = _sideIndex + 1;
private _basePos = GameData # 0 # _baseDataIndex # 0;
if (_basePos isEqualTo 0) exitWith {};

private _groupVar = ["WestAccGrp", "EastAccGrp"] # _sideIndex;
private _accountantVar = ["WestAccountant", "EastAccountant"] # _sideIndex;
private _boxVar = ["WestBox", "EastBox"] # _sideIndex;
private _markerName = ["respawn_west", "respawn_east"] # _sideIndex;
private _markerVar = ["markerBLUFOR", "markerOPFOR"] # _sideIndex;
private _victoryText = [
    "The West accountant has been killed. East has broken West's control.",
    "The East accountant has been killed. West has broken East's control."
] # _sideIndex;

private _oldAccountant = missionNamespace getVariable [_accountantVar, objNull];
if (!isNull _oldAccountant) then {deleteVehicle _oldAccountant};
private _oldBox = missionNamespace getVariable [_boxVar, objNull];
if (!isNull _oldBox) then {deleteVehicle _oldBox};

private _group = createGroup [_side, true];
private _accountant = _group createUnit ["C_man_polo_4_F", _basePos, [], 0, "NONE"];
private _box = createVehicle ["virtualReammoBox_camonet_F", _basePos vectorAdd [1, 0, 0], [], 0, "NONE"];

_accountant disableAI "MOVE";
_accountant setVariable ["TYR_sideIndex", _sideIndex, true];
_accountant addEventHandler ["HandleDamage", {
    params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit"];
    private _sideIndex = _unit getVariable ["TYR_sideIndex", -1];
    private _enemy = [east, west] param [_sideIndex, sideUnknown];
    if (!isNull _instigator && {isPlayer _instigator} && {side _instigator isEqualTo _enemy} && {_directHit}) then {
        _damage
    } else {
        damage _unit
    };
}];
_accountant setVariable ["TYR_victoryText", _victoryText, true];
_accountant addEventHandler ["Killed", {
    params ["_unit"];
    private _text = _unit getVariable ["TYR_victoryText", "An accountant has been killed."];
    [_text] remoteExecCall ["TYR_fnc_ClientHint", [0, -2] select isDedicated];
}];

missionNamespace setVariable [_groupVar, _group, true];
missionNamespace setVariable [_accountantVar, _accountant, true];
missionNamespace setVariable [_boxVar, _box, true];
publicVariable _accountantVar;
publicVariable _boxVar;

if (markerType _markerName isEqualTo "") then {
    createMarker [_markerName, _basePos];
} else {
    _markerName setMarkerPos _basePos;
};
missionNamespace setVariable [_markerVar, _markerName, true];
publicVariable _markerVar;
