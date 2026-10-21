disableSerialization;

waitUntil {
    sleep 0.25;
    (GameData # 0 # (Pside + 1) # 0) isNotEqualTo 0
};
waitUntil {!isNull findDisplay 46};

private _mainDisplay = findDisplay 46;
private _mapLB = missionConfigFile >> "myMissionConfig" >> "RscMapListbox";

// Persistent screen overlay used by capture/resource feedback.
if (isNull (_mainDisplay displayCtrl 3000)) then {
    private _overlayBackground = _mainDisplay ctrlCreate [_mapLB, 3000];
    private _overlayHeader = _mainDisplay ctrlCreate ["RscText", 3001];
    _overlayBackground ctrlSetPosition [safeZoneX + safeZoneW * 0.45, safeZoneY + safeZoneH * 0.01, 0.2, 0.12];
    _overlayHeader ctrlSetPosition [safeZoneX + safeZoneW * 0.45, safeZoneY + safeZoneH * 0.01, 0.2, 0.025];
    _overlayBackground ctrlSetBackgroundColor [0, 0, 0, 0];
    _overlayHeader ctrlSetBackgroundColor [0, 0, 0, 0];
    _overlayBackground ctrlCommit 0;
    _overlayHeader ctrlCommit 0;
};

TYR_mapMarks = [];
TYR_baseMarks = [];

TYR_updateMapCard = {
    params ["_header", "_background", "_pos", "_height", "_width"];
    if (isNull _header || {isNull _background}) exitWith {};

    private _mapDisplay = findDisplay 12;
    if (isNull _mapDisplay) exitWith {};
    private _ctrl = _mapDisplay displayCtrl 51;
    if (isNull _ctrl) exitWith {};

    private _screenPos = _ctrl ctrlMapWorldToScreen (_pos vectorAdd [0, -20, 0]);
    _background ctrlSetPosition [_screenPos # 0, _screenPos # 1, _width, _height];
    _header ctrlSetPosition [_screenPos # 0, _screenPos # 1, _width, 0.025];
    _header ctrlSetScale (1 - ctrlMapScale _ctrl);
    _background ctrlSetScale (1 - ctrlMapScale _ctrl);
    _background ctrlCommit 0;
    _header ctrlCommit 0;
};

TYR_refreshMapCardPositions = {
    if (isNull findDisplay 12) exitWith {};
    {
        [_x # 1, _x # 2, _x # 3, 0.12, 0.15] call TYR_updateMapCard;
    } forEach TYR_mapMarks;

    if (count TYR_baseMarks >= 2) then {
        [TYR_baseMarks # 0, TYR_baseMarks # 1, GameData # 0 # (Pside + 1) # 0, 0.155, 0.16] call TYR_updateMapCard;
    };
};

TYR_createMapControls = {
    disableSerialization;
    private _map = findDisplay 12;
    if (isNull _map) exitWith {};

    // Display 12 is not guaranteed to be destroyed when the player closes the map.
    // Creating the controls on every Map-open event therefore duplicates every card.
    // Mark the actual display instance once it owns our controls and reuse them until
    // Arma really destroys/replaces that display. A newly-created display has no flag.
    if (_map getVariable ["TYR_mapControlsCreated", false]) exitWith {
        call TYR_refreshMapCardPositions;
    };
    _map setVariable ["TYR_mapControlsCreated", true];

    private _mapLB = missionConfigFile >> "myMissionConfig" >> "RscMapListbox";
    private _baseMapLB = missionConfigFile >> "myMissionConfig" >> "RscBaseMapListbox";

    TYR_mapMarks = [];
    TYR_baseMarks = [];

    private _baseBackground = _map ctrlCreate [_baseMapLB, 3002];
    private _baseHeader = _map ctrlCreate ["RscText", 3003];
    _baseHeader ctrlSetText "Hideout";
    _baseHeader ctrlSetBackgroundColor (if (Pside isEqualTo 0) then {[0.00, 0.30, 0.60, 1.00]} else {[0.50, 0.00, 0.00, 1.00]});
    _baseBackground ctrlSetBackgroundColor [0, 0, 0, 0.7];
    TYR_baseMarks = [_baseHeader, _baseBackground];

    private _nextIdc = 2000;
    {
        {
            private _background = _map ctrlCreate [_mapLB, _nextIdc];
            _nextIdc = _nextIdc + 1;
            private _header = _map ctrlCreate ["RscText", _nextIdc];
            _nextIdc = _nextIdc + 1;
            _header ctrlSetText (_x # 0);
            _header ctrlSetBackgroundColor [0.851, 0.5647, 0.0863, 1];
            _background ctrlSetBackgroundColor [0, 0, 0, 0.7];
            TYR_mapMarks pushBack [_x # 0, _header, _background, _x # 4];
        } forEach _x;
    } forEach (GameData # 1);

    call TYR_refreshMapCardPositions;
    _map displayAddEventHandler ["MouseMoving", {call TYR_refreshMapCardPositions}];
    _map displayAddEventHandler ["MouseHolding", {call TYR_refreshMapCardPositions}];
};

if (isNil "TYR_mapEventHandler") then {
    TYR_mapEventHandler = addMissionEventHandler ["Map", {
        params ["_mapIsOpened", "_mapIsForced"];
        if (_mapIsOpened) then {
            [] spawn {
                disableSerialization;
                waitUntil {
                    sleep 0.01;
                    !isNull findDisplay 12
                };
                call TYR_createMapControls;
            };
        } else {
            // Do not clear the control references here. Display 12 may persist while
            // hidden; keeping the references lets the next open reuse the same cards.
        };
    }];
};

// Handle the uncommon case where this script starts while the map is already open.
if (visibleMap) then {
    call TYR_createMapControls;
};

if (isNil "TYR_playerLoopsStarted") then {
    TYR_playerLoopsStarted = true;
    [] execVM "Player\PlayerLoops\mapUpdate.sqf";
    [] execVM "Player\PlayerLoops\mapCapture.sqf";
    [] execVM "Player\PlayerLoops\LoadoutSave.sqf";
};
