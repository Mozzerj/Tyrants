titleCut ["", "BLACK IN", 4];

waitUntil {
    sleep 0.1;
    !isNil "GameData"
};

player setUnitTrait ["Medic", true];
player setUnitTrait ["UAVHacker", true];
player setUnitTrait ["explosiveSpecialist", true];
player setUnitTrait ["engineer", true];

TYR_playerProfileUI = [profileName, "Private", 1];

switch (playerSide) do {
    case west: {
        Pside = 0;
        PColor = "ColorWEST";
        PlayerOverlayColor = [0.00, 0.30, 0.60, 1.00];
    };
    case east: {
        Pside = 1;
        PColor = "ColorEAST";
        PlayerOverlayColor = [0.50, 0.00, 0.00, 1.00];
    };
    default {
        Pside = -1;
        PColor = "ColorGUER";
        PlayerOverlayColor = [0.00, 0.50, 0.00, 1.00];
    };
};

if (Pside < 0) exitWith {
    diag_log "[TYRANTS] Player is not on WEST/EAST; Tyrants player systems were not started.";
};

if ((GameData # 0 # 0 # 0) < 4) then {
    [] execVM "Setup\GameSetupPlayer\GameInit.sqf";
};

waitUntil {
    sleep 0.25;
    (GameData # 0 # 0 # 0) isEqualTo 4
};

[] execVM "Player\PlayerInit\PlayerMapCreation.sqf";
[] remoteExecCall ["TYR_fnc_ServerRegisterPlayer", 2];

waitUntil {
    sleep 0.25;
    private _uid = getPlayerUID player;
    (GameData # 0 # 3) findIf {(_x # 0) isEqualTo _uid} >= 0
};

TYR_playerProfileIndex = (GameData # 0 # 3) findIf {(_x # 0) isEqualTo getPlayerUID player};
private _savedProfile = [] call TYR_fnc_givePlayerLoadout;
player setPosATL (_savedProfile # 1);

waitUntil {
    sleep 0.25;
    !isNil "WestBox" && {!isNil "EastBox"} && {!isNil "WestAccountant"} && {!isNil "EastAccountant"}
};

private _box = if (Pside isEqualTo 0) then {WestBox} else {EastBox};

if (isNil "TYR_arsenalClosedEH") then {
    TYR_arsenalClosedEH = [missionNamespace, "arsenalClosed", {
        if (missionNamespace getVariable ["TYR_arsenalPurchaseActive", false]) then {
            missionNamespace setVariable ["TYR_arsenalPurchaseActive", false];
            [] call TYR_fnc_ExitArsenal;
        };
    }] call BIS_fnc_addScriptedEventHandler;
};

_box addAction [
    "Open Arsenal",
    {
        missionNamespace setVariable ["TYR_arsenalPurchaseActive", true];
        [] remoteExecCall ["TYR_fnc_ServerBeginArsenal", 2];
        ["Open", [true]] call BIS_fnc_arsenal;
    },
    nil, 1.5, true, true, "", "true", 10
];

TYR_addAccountantMoveAction = {
    private _accountantLocal = if (Pside isEqualTo 0) then {WestAccountant} else {EastAccountant};
    private _moveId = _accountantLocal addAction [
        "Move Accountant",
        {
            params ["_target", "_caller", "_actionId"];
            _target removeAction _actionId;
            [Pside] remoteExecCall ["TYR_fnc_ServerAttachAccountant", 2];

            _caller addAction [
                "Drop Accountant",
                {
                    params ["_player", "_caller", "_actionId", "_accountant"];
                    private _newPos = _player modelToWorld [0, 3, 0];
                    _player removeAction _actionId;
                    [Pside, _newPos] remoteExecCall ["TYR_fnc_ServerMoveBase", 2];
                    call TYR_addAccountantMoveAction;
                },
                _target, 1.5, true, true, "", "true", 10
            ];
        },
        nil, 1.5, true, true, "", "true", 10
    ];
};
call TYR_addAccountantMoveAction;

if (count GameData > 5) then {
    {
        private _emplacementSideIndex = _forEachIndex;
        {
            if (count _x >= 3 && {!isNull (_x # 2)}) then {
                [_x # 2, _x # 0, _emplacementSideIndex] call TYR_fnc_ClientAttachEmplacementActions;
            };
        } forEach _x;
    } forEach (GameData # 5);
};

waitUntil {!isNull findDisplay 46};
findDisplay 46 displayAddEventHandler ["KeyDown", {
    params ["_display", "_key"];
    if (_key isEqualTo 21 && {isNull findDisplay 1200} && {isNull findDisplay 1700}) then {
        createDialog "TyrPlayerMenu";
        private _menu = findDisplay 1200;
        if (!isNull _menu) then {
            _menu displayCtrl 1 ctrlSetText (TYR_playerProfileUI # 0);
            _menu displayCtrl 2 ctrlSetText str (TYR_playerProfileUI # 1);
            _menu displayCtrl 3 progressSetPosition (TYR_playerProfileUI # 2);

            private _team = GameData # 0 # (Pside + 1);
            _menu displayCtrl 20 ctrlSetText format ["STEEL  %1", _team # 1];
            _menu displayCtrl 21 ctrlSetText format ["AMMO  %1", _team # 2];
            _menu displayCtrl 22 ctrlSetText format ["FUEL  %1", _team # 3];
            _menu displayCtrl 23 ctrlSetText format ["MEN  %1", _team # 4];

            private _inRange = (GameData # 1 # 2) findIf {
                player distance2D (_x # 4) < 75 && {PColor isEqualTo (_x # 3)}
            } >= 0;
            (_menu displayCtrl 4) ctrlShow _inRange;
            (_menu displayCtrl 5) ctrlShow (player distance2D (_team # 0) < 25);
            (_menu displayCtrl 9) ctrlShow (missionNamespace getVariable ["TYR_debugMode", false]);
        };
    };
    false
}];

if (missionNamespace getVariable ["TYR_debugMode", false]) then {
    player addAction [
        "Open Tyrants Debug Menu",
        {
            createDialog "TyrDebugMenu";
            [] call TYR_fnc_DebugMenuRefresh;
        },
        nil, 1.7, false, true, "", "(GameData # 0 # 0 # 0) isEqualTo 4", 5
    ];
};

if (missionNamespace getVariable ["TYR_soloTestMode", false]) then {
    private _previousReport = profileNamespace getVariable ["TYR_LastTestReport", ""];
    if (_previousReport isNotEqualTo "") then {TYR_lastTestReportText = _previousReport};

    player addAction [
        "Run Tyrants Automated Tests",
        {
            [] remoteExecCall ["TYR_fnc_ServerRunAutomatedTests", 2];
            hint "Running Tyrants automated tests...";
        },
        nil, 1.6, false, true, "",
        "(GameData # 0 # 0 # 0) isEqualTo 4 && {!(missionNamespace getVariable ['TYR_testInProgress', false])}", 5
    ];

    player addAction [
        "Copy Last Tyrants Test Report",
        {
            if (isNil "TYR_lastTestReportText") then {
                hint "No automated test report exists yet.";
            } else {
                copyToClipboard TYR_lastTestReportText;
                hint "Tyrants test report copied to clipboard.";
            };
        },
        nil, 1.5, false, true, "", "!isNil 'TYR_lastTestReportText'", 5
    ];
};
