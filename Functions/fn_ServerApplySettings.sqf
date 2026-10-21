params ["_settings"];
if (!isServer) exitWith {};
if !(remoteExecutedOwner isEqualTo (missionNamespace getVariable ["TYR_setupOwnerId", -2])) exitWith {};
if !(_settings isEqualType [] && {count _settings >= 8}) exitWith {};
if ((GameData # 0 # 0 # 0) isNotEqualTo 0) exitWith {};

private _allowed = [
    [60, 90, 120, 180],
    [50, 100, 175, 250],
    [15000, 20000, 30000, 40000, 50000, 75000],
    [15000, 20000, 30000, 40000, 50000, 75000],
    [15000, 20000, 30000, 40000, 50000, 75000],
    [15, 20, 30, 40, 50, 75],
    [0.5, 1, 1.5, 2, 2.5, 3],
    [0.5, 1, 1.5, 2, 2.5, 3]
];
private _validSettings = true;
for "_i" from 0 to 7 do {
    if !((_settings # _i) in (_allowed # _i)) exitWith {_validSettings = false};
};
if (!_validSettings) exitWith {};

private _captureTime = _settings # 0;
private _captureRange = _settings # 1;
private _steel = _settings # 2;
private _ammo = _settings # 3;
private _fuel = _settings # 4;
private _manpower = _settings # 5;

GameData # 0 # 0 set [0, 1];
GameData # 0 # 0 set [1, +_settings];
GameData # 0 # 1 set [1, _steel];
GameData # 0 # 1 set [2, _ammo];
GameData # 0 # 1 set [3, _fuel];
GameData # 0 # 1 set [4, _manpower];
GameData # 0 # 2 set [1, _steel];
GameData # 0 # 2 set [2, _ammo];
GameData # 0 # 2 set [3, _fuel];
GameData # 0 # 2 set [4, _manpower];

[] call TYR_fnc_ServerBroadcastState;
[] call TYR_fnc_ServerSaveState;
diag_log format ["[TYRANTS] Setup settings accepted. Capture %1s/%2m", _captureTime, _captureRange];
