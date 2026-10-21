params ["_selected"];
private _display = findDisplay 1203;
if (isNull _display || {_selected < 0}) exitWith {hint "Select an emplacement first."};
private _key = (_display displayCtrl 1) lbData _selected;
if (_key isEqualTo "") exitWith {};
private _defMatches = ([] call TYR_fnc_GetEmplacementDefinitions) select {(_x # 0) isEqualTo _key};
if (_defMatches isEqualTo []) exitWith {};
private _def = _defMatches # 0;
if !(_def # 5) exitWith {hint "That emplacement was an unfinished prototype in the 18/10/2024 build."};

closeDialog 0;
TYR_emplacementPositionChosen = false;
TYR_emplacementPosition = [0,0,0];
openMap [true, false];
hint "Choose an emplacement position within 500m of friendly captured territory.";
onMapSingleClick {
    TYR_emplacementPosition = _pos;
    TYR_emplacementPositionChosen = true;
    onMapSingleClick "";
};
waitUntil {sleep 0.1; TYR_emplacementPositionChosen};
openMap [false, false];
[_key, TYR_emplacementPosition] remoteExecCall ["TYR_fnc_ServerBuyEmplacement", 2];
