disableSerialization;
private _d = findDisplay 1700;
if (isNull _d || {isNil "TYR_ClientState"}) exitWith {};
private _list = _d displayCtrl 2301;
lbClear _list;
private _knowledge = TYR_ClientState getOrDefault ["knowledge",[]];
private _log = if (_knowledge isEqualType [] && {count _knowledge >= 4}) then {+(_knowledge # 3)} else {[]};
private _shown = 0;
if (count _log > 0) then {
    for "_i" from ((count _log) - 1) to 0 step -1 do {
        if (_shown >= 150) exitWith {};
        private _entry = _log # _i;
        if (_entry isEqualType [] && {count _entry >= 7}) then {
            _entry params ["_stamp","_id","_targetFaction","_label","_pos","_source","_event"];
            private _timeText = "--:--:--";
            if (_stamp isEqualType [] && {count _stamp >= 6}) then {
                _timeText = format ["%1:%2:%3",[_stamp # 3,2] call BIS_fnc_padNumber,[_stamp # 4,2] call BIS_fnc_padNumber,[floor (_stamp # 5),2] call BIS_fnc_padNumber];
            };
            _list lbAdd format ["%1 // %2 // %3 // %4 // %5",_timeText,_event,toUpper _targetFaction,toUpper _label,toUpper _source];
            _shown = _shown + 1;
        };
    };
} else {
    _list lbAdd "No collected intelligence yet.";
};
(_d displayCtrl 2300) ctrlSetText format ["FACTION INTELLIGENCE LOG // %1 ENTRIES // SHOWING %2",count _log,_shown];
