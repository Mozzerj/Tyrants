createDialog "TyrEmplacementMenu";
private _display = findDisplay 1203;
if (isNull _display) exitWith {};
private _list = _display displayCtrl 1;
lbClear _list;
{
    private _key = _x # 0;
    if ([Pside, _x # 2] call TYR_fnc_IsResearchUnlocked) then {
        private _label = _x # 1;
        if !(_x # 5) then {_label = _label + " (prototype / not implemented)"};
        private _row = _list lbAdd _label;
        _list lbSetData [_row, _key];
    };
} forEach ([] call TYR_fnc_GetEmplacementDefinitions);
if (lbSize _list isEqualTo 0) then {
    private _row = _list lbAdd "No researched emplacements";
    _list lbSetData [_row, ""];
};
_list lbSetCurSel 0;
