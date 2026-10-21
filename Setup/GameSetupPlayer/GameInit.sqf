private _zonePos = getPosATL initZone;
private _cameraPos = [(_zonePos # 0) - 16, (_zonePos # 1) + 15, (_zonePos # 2) + 5];
private _camera = "CAMERA" camCreate _cameraPos;
_camera cameraEffect ["Internal", "Back"];
_camera camSetTarget _zonePos;
_camera camCommit 0;

waitUntil {
    sleep 0.25;
    (GameData # 0 # 0 # 0) >= 3
};

_camera cameraEffect ["terminate", "back"];
camDestroy _camera;

private _commander = if (Pside isEqualTo 0) then {
    missionNamespace getVariable ["commanderWest", objNull]
} else {
    missionNamespace getVariable ["commanderEast", objNull]
};
private _canPlaceBase = player isEqualTo _commander || {!isPlayer _commander};

if (_canPlaceBase && {(GameData # 0 # (Pside + 1) # 0) isEqualTo 0}) then {
    [] call compile preprocessFileLineNumbers "Setup\GameSetupStage3\mapSetup.sqf";
    [] execVM "Setup\GameSetupPlayer\BaseSetup.sqf";
} else {
    [1, "BLACK", 3, 1] spawn BIS_fnc_fadeEffect;
};

waitUntil {
    sleep 0.25;
    (GameData # 0 # 1 # 0) isNotEqualTo 0 && {(GameData # 0 # 2 # 0) isNotEqualTo 0}
};

player setPosATL (GameData # 0 # (Pside + 1) # 0);
[1, "BLACK", 3, 1] spawn BIS_fnc_fadeEffect;
