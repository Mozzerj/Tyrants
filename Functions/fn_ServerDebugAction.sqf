if (!isServer) exitWith {};
if (!(missionNamespace getVariable ["TYR_debugMode", false])) exitWith {};

params [
    ["_action", "", [""]],
    ["_args", [], [[]]]
];

private _requester = [remoteExecutedOwner] call TYR_fnc_FindPlayerByOwner;
if (isNull _requester) exitWith {};

private _requesterSide = switch (side group _requester) do {
    case west: {0};
    case east: {1};
    default {-1};
};
if (_requesterSide < 0) exitWith {};

private _changed = false;
private _message = "Debug action completed.";
private _validSide = {
    params ["_value"];
    _value isEqualType 0 && {_value in [0, 1]}
};

switch (_action) do {
    case "resource": {
        private _sideIndex = _args param [0, _requesterSide];
        private _resourceIndex = _args param [1, -1];
        private _amount = _args param [2, 0];
        if ([_sideIndex] call _validSide && {_resourceIndex in [1, 2, 3, 4]} && {_amount isEqualType 0}) then {
            _amount = (_amount max -1000000) min 1000000;
            private _team = GameData # 0 # (_sideIndex + 1);
            _team set [_resourceIndex, ((_team # _resourceIndex) + _amount) max 0];
            _changed = true;
            private _names = ["", "steel", "ammo", "fuel", "manpower"];
            _message = format ["Debug: %1 %2 changed by %3.", ["WEST", "EAST"] # _sideIndex, _names # _resourceIndex, _amount];
        };
    };

    case "boostResources": {
        private _sideIndex = _args param [0, _requesterSide];
        if ([_sideIndex] call _validSide) then {
            private _team = GameData # 0 # (_sideIndex + 1);
            _team set [1, (_team # 1) + 100000];
            _team set [2, (_team # 2) + 100000];
            _team set [3, (_team # 3) + 100000];
            _team set [4, (_team # 4) + 1000];
            _changed = true;
            _message = format ["Debug: boosted all %1 resources.", ["WEST", "EAST"] # _sideIndex];
        };
    };

    case "maxResources": {
        private _sideIndex = _args param [0, _requesterSide];
        if ([_sideIndex] call _validSide) then {
            private _team = GameData # 0 # (_sideIndex + 1);
            _team set [1, 1000000];
            _team set [2, 1000000];
            _team set [3, 1000000];
            _team set [4, 10000];
            _changed = true;
            _message = format ["Debug: maxed %1 resources.", ["WEST", "EAST"] # _sideIndex];
        };
    };

    case "unlockResearch": {
        private _sideIndex = _args param [0, _requesterSide];
        if ([_sideIndex] call _validSide) then {
            private _research = GameData # 0 # (_sideIndex + 1) # 5;
            {
                _research # (_x # 2) set [_x # 3, 1];
            } forEach (call TYR_fnc_GetResearchDefinitions);
            _changed = true;
            _message = format ["Debug: unlocked all %1 research.", ["WEST", "EAST"] # _sideIndex];
        };
    };

    case "resetResearch": {
        private _sideIndex = _args param [0, _requesterSide];
        if ([_sideIndex] call _validSide) then {
            GameData # 0 # (_sideIndex + 1) set [5, [[0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]]];
            _changed = true;
            _message = format ["Debug: reset %1 research.", ["WEST", "EAST"] # _sideIndex];
        };
    };

    case "fillFactories": {
        {
            if (count _x > 6) then {_x set [6, 50000]};
        } forEach (GameData # 1 # 2);
        _changed = true;
        _message = "Debug: filled all factory stockpiles.";
    };

    case "factoryTick": {
        [] call TYR_fnc_FactoryUpdate;
        _changed = true;
        _message = "Debug: forced one factory production tick.";
    };

    case "refillVLS": {
        private _sideIndex = _args param [0, _requesterSide];
        if ([_sideIndex] call _validSide && {count GameData > 5}) then {
            {
                if (count _x > 2 && {!isNull (_x # 2)}) then {
                    (_x # 2) setVehicleAmmo 1;
                };
            } forEach (GameData # 5 # _sideIndex);
            _message = format ["Debug: refilled live %1 emplacements.", ["WEST", "EAST"] # _sideIndex];
        };
    };

    case "save": {
        [] call TYR_fnc_ServerSaveState;
        _message = "Debug: campaign saved now.";
    };
};

if (_changed) then {
    [] call TYR_fnc_ServerBroadcastState;
    [] call TYR_fnc_ServerSaveState;
};

[_message] remoteExecCall ["TYR_fnc_ClientHint", owner _requester];
