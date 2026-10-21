params ["_ctrl","_index"];
private _targets = missionNamespace getVariable ["TYR_vlsTargets",[]];
if (_index < 0 || {_index >= count _targets}) exitWith {};
private _d = findDisplay 1204;
if (isNull _d) exitWith {};
private _map = _d displayCtrl 1000;
_map ctrlMapAnimAdd [0.2,0.08,_targets # _index];
ctrlMapAnimCommit _map;
