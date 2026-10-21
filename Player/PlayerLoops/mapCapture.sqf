disableSerialization;

waitUntil {!isNull findDisplay 46};
private _overlayBackground = (findDisplay 46) displayCtrl 3000;
private _overlayHeader = (findDisplay 46) displayCtrl 3001;

while {true} do {
    private _settings = GameData # 0 # 0 param [1, []];
    private _captureTime = _settings param [0, 120];
    private _captureRange = _settings param [1, 175];
    private _target = [];

    {
        private _categoryIndex = _forEachIndex;
        {
            if (player distance2D (_x # 4) < _captureRange && {(_x # 3) isNotEqualTo PColor}) exitWith {
                _target = [_categoryIndex, _forEachIndex, _x # 4, _x # 0];
            };
        } forEach _x;
        if (count _target > 0) exitWith {};
    } forEach (GameData # 1);

    if (count _target > 0) then {
        private _completed = true;
        _overlayHeader ctrlSetBackgroundColor PlayerOverlayColor;
        _overlayBackground ctrlSetBackgroundColor [0, 0, 0, 0.7];

        for "_i" from 0 to _captureTime do {
            if (player distance2D (_target # 2) > _captureRange) exitWith {_completed = false};
            lbClear _overlayBackground;
            _overlayBackground lbAdd "";
            _overlayBackground lbAdd format ["Capture in: %1", _captureTime - _i];
            sleep 1;
        };

        lbClear _overlayBackground;
        _overlayBackground lbAdd "";
        if (_completed) then {
            _overlayBackground lbAdd format ["Capturing %1", _target # 3];
            [_target # 0, _target # 1] remoteExecCall ["TYR_fnc_ServerCaptureRegion", 2];
        } else {
            _overlayBackground lbAdd "Moved too far";
        };
        sleep 2;
        lbClear _overlayBackground;
        _overlayHeader ctrlSetBackgroundColor [0, 0, 0, 0];
        _overlayBackground ctrlSetBackgroundColor [0, 0, 0, 0];
    } else {
        sleep 2;
    };
};
