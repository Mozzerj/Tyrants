if (!hasInterface) exitWith {};
if (!(missionNamespace getVariable ["TYR_debugMode", false])) exitWith {};
if (missionNamespace getVariable ["TYR_debugMenuRefreshRunning", false]) exitWith {};

missionNamespace setVariable ["TYR_debugMenuRefreshRunning", true];

[] spawn {
    disableSerialization;

    while {!isNull findDisplay 1700} do {
        private _display = findDisplay 1700;
        private _friendly = GameData # 0 # (Pside + 1);
        private _enemySide = 1 - Pside;
        private _enemy = GameData # 0 # (_enemySide + 1);

        (_display displayCtrl 100) ctrlSetText format ["DEBUG // %1", if (Pside isEqualTo 0) then {"WEST"} else {"EAST"}];
        (_display displayCtrl 110) ctrlSetText format ["Steel   %1", _friendly # 1];
        (_display displayCtrl 111) ctrlSetText format ["Ammo    %1", _friendly # 2];
        (_display displayCtrl 112) ctrlSetText format ["Fuel    %1", _friendly # 3];
        (_display displayCtrl 113) ctrlSetText format ["Manpower %1", _friendly # 4];

        (_display displayCtrl 120) ctrlSetText format ["Steel   %1", _enemy # 1];
        (_display displayCtrl 121) ctrlSetText format ["Ammo    %1", _enemy # 2];
        (_display displayCtrl 122) ctrlSetText format ["Fuel    %1", _enemy # 3];
        (_display displayCtrl 123) ctrlSetText format ["Manpower %1", _enemy # 4];

        (_display displayCtrl 101) ctrlSetText format ["FRIENDLY // %1", if (Pside isEqualTo 0) then {"WEST"} else {"EAST"}];
        (_display displayCtrl 102) ctrlSetText format ["OPPONENT // %1", if (_enemySide isEqualTo 0) then {"WEST"} else {"EAST"}];

        uiSleep 0.25;
    };

    missionNamespace setVariable ["TYR_debugMenuRefreshRunning", false];
};
