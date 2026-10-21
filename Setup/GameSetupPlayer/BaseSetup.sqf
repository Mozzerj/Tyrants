if (Pside < 0) exitWith {};
if ((GameData # 0 # (Pside + 1) # 0) isNotEqualTo 0) exitWith {};

waitUntil {!isNil "TYR_dividerSlope" && {!isNil "TYR_dividerIntercept"}};
openMap [true, true];

TYR_baseSelectionDone = false;
TYR_baseSelectionPos = [0, 0, 0];

onMapSingleClick {
    private _lineY = TYR_dividerSlope * (_pos # 0) + TYR_dividerIntercept;
    private _pointY = _pos # 1;
    private _validSide = (Pside isEqualTo 0 && {_pointY < _lineY}) || (Pside isEqualTo 1 && {_pointY > _lineY});

    if (_validSide && {!surfaceIsWater [_pos # 0, _pos # 1]}) then {
        TYR_baseSelectionPos = _pos;
        TYR_baseSelectionDone = true;
        onMapSingleClick "";
    } else {
        hint "Choose a land position on your side of the dividing line.";
    };
};

waitUntil {
    sleep 0.1;
    TYR_baseSelectionDone
};

[Pside, TYR_baseSelectionPos] remoteExecCall ["TYR_fnc_ServerSetBasePosition", 2];

waitUntil {
    sleep 0.25;
    (GameData # 0 # (Pside + 1) # 0) isNotEqualTo 0
};

deleteMarkerLocal "TYR_dividerNorth";
deleteMarkerLocal "TYR_dividerSouth";
[0, "BLACK", 3, 1] spawn BIS_fnc_fadeEffect;
sleep 1;
openMap [false, false];
