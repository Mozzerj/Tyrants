params ["_controlId"];
private _display = findDisplay 1205;
if (isNull _display) exitWith {};

private _controlMap = createHashMapFromArray [
    [1000, "intel.basic"], [1100, "intel.comms"], [1110, "intel.listening"], [1200, "intel.trackers"], [1300, "intel.satellite"],
    [2000, "infra.basic"], [2100, "infra.strategic"], [2110, "infra.cbr"], [2120, "infra.roadblock"], [2200, "infra.factory"], [2300, "infra.offensive"],
    [3000, "proc.armored"], [3001, "proc.heavy"], [3002, "proc.rotary"], [3003, "proc.artillery"], [3004, "proc.fixed"], [3005, "proc.autonomous"]
];

if (_controlId isEqualTo 5) then {
    if ((missionNamespace getVariable ["TYR_researchSelectedKey", ""]) isEqualTo "") exitWith {hint "Select a research item first."};
    [TYR_researchSelectedKey] remoteExecCall ["TYR_fnc_ServerPurchaseResearch", 2];
    [] spawn {
        sleep 0.75;
        if (!isNull findDisplay 1205) then {[-1] execVM "Research\ResearchUpdate.sqf"};
    };
} else {
    if (_controlId >= 0) then {
        TYR_researchSelectedKey = _controlMap getOrDefault [_controlId, ""];
    };
};

private _definitions = [] call TYR_fnc_GetResearchDefinitions;
private _byKey = createHashMap;
{_byKey set [_x # 0, _x]} forEach _definitions;

(_display displayCtrl 2) ctrlSetText format ["Steel: %1", GameData # 0 # (Pside + 1) # 1];

private _idPairs = [
    [1000, "intel.basic"], [1100, "intel.comms"], [1110, "intel.listening"], [1200, "intel.trackers"], [1300, "intel.satellite"],
    [2000, "infra.basic"], [2100, "infra.strategic"], [2110, "infra.cbr"], [2120, "infra.roadblock"], [2200, "infra.factory"], [2300, "infra.offensive"],
    [3000, "proc.armored"], [3001, "proc.heavy"], [3002, "proc.rotary"], [3003, "proc.artillery"], [3004, "proc.fixed"], [3005, "proc.autonomous"]
];
private _unlockedColour = if (Pside isEqualTo 0) then {[0, 0.3, 0.6, 1]} else {[0.5, 0, 0, 1]};
private _availableColour = [0.851, 0.5647, 0.0863, 1];
private _lockedColour = [0.2, 0.2, 0.2, 1];
{
    private _ctrl = _display displayCtrl (_x # 0);
    private _key = _x # 1;
    private _def = _byKey get _key;
    private _isUnlocked = [Pside, _key] call TYR_fnc_IsResearchUnlocked;
    private _requirementsMet = ((_def # 5) findIf {!([Pside, _x] call TYR_fnc_IsResearchUnlocked)}) < 0;
    private _colour = if (_isUnlocked) then {_unlockedColour} else {if (_requirementsMet) then {_availableColour} else {_lockedColour}};
    _ctrl ctrlSetBackgroundColor _colour;
    _ctrl ctrlSetActiveColor _colour;
} forEach _idPairs;

private _info = _display displayCtrl 1;
lbClear _info;
private _selectedKey = missionNamespace getVariable ["TYR_researchSelectedKey", ""];
if (_selectedKey isNotEqualTo "") then {
    private _def = _byKey get _selectedKey;
    _info lbAdd (_def # 1);
    _info lbAdd "";
    { _info lbAdd _x } forEach (_def # 6);
    _info lbAdd "";
    _info lbAdd format ["Cost: %1 steel", _def # 4];
    private _prereqs = _def # 5;
    if !(_prereqs isEqualTo []) then {
        _info lbAdd "";
        _info lbAdd "Requires:";
        {
            private _req = _byKey get _x;
            _info lbAdd format ["  %1%2", if ([Pside, _x] call TYR_fnc_IsResearchUnlocked) then {"[x] "} else {"[ ] "}, _req # 1];
        } forEach _prereqs;
    };
    if ([Pside, _selectedKey] call TYR_fnc_IsResearchUnlocked) then {
        _info lbAdd "";
        _info lbAdd "RESEARCHED";
    };
} else {
    _info lbAdd "Select a research project.";
};
