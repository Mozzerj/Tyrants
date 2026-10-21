private _factoryIndex = (GameData # 1 # 2) findIf {
    player distance2D (_x # 4) < 75 && {PColor isEqualTo (_x # 3)}
};
if (_factoryIndex < 0) exitWith {hint "No friendly factory in range."};

private _factory = GameData # 1 # 2 # _factoryIndex;
private _factoryId = _factory # 0;
private _overlayBackground = (findDisplay 46) displayCtrl 3000;
private _overlayHeader = (findDisplay 46) displayCtrl 3001;

_overlayHeader ctrlSetBackgroundColor PlayerOverlayColor;
_overlayBackground ctrlSetBackgroundColor [0, 0, 0, 0.7];

private _completed = true;
for "_i" from 0 to 30 do {
    if (player distance2D (_factory # 4) > 75) exitWith {_completed = false};
    lbClear _overlayBackground;
    _overlayBackground lbAdd "";
    _overlayBackground lbAdd format ["Collected in: %1", 30 - _i];
    sleep 1;
};

lbClear _overlayBackground;
if (_completed) then {
    _overlayBackground lbAdd "";
    _overlayBackground lbAdd "Resources collected";
    [_factoryId] remoteExecCall ["TYR_fnc_ServerCollectFactory", 2];
} else {
    _overlayBackground lbAdd "";
    _overlayBackground lbAdd "Moved too far";
};

sleep 2;
lbClear _overlayBackground;
_overlayHeader ctrlSetBackgroundColor [0, 0, 0, 0];
_overlayBackground ctrlSetBackgroundColor [0, 0, 0, 0];
