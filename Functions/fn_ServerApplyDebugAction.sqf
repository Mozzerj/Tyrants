if (!isServer) exitWith {[false, "Server-only debug helper."]};

params [
    ["_requesterSide", -1, [0]],
    ["_action", "", [""]],
    ["_args", [], [[]]]
];

if !(_requesterSide in [0, 1]) exitWith {[false, "Debug: invalid requester side."]};

private _changed = false;
private _message = "Debug: action ignored.";
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
            private _research = +(GameData # 0 # (_sideIndex + 1) # 5);
            {
                private _branchIndex = _x # 2;
                private _branch = +(_research # _branchIndex);
                _branch set [_x # 3, 1];
                _research set [_branchIndex, _branch];
            } forEach ([] call TYR_fnc_GetResearchDefinitions);
            GameData # 0 # (_sideIndex + 1) set [5, _research];
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
        if (count (GameData # 1) >= 3) then {
            {
                if (count _x > 6) then {_x set [6, 50000]};
            } forEach (GameData # 1 # 2);
            _changed = true;
            _message = "Debug: filled all factory stockpiles.";
        };
    };

    case "factoryTick": {
        [] call TYR_fnc_FactoryUpdate;
        _changed = true;
        _message = "Debug: forced one factory production tick.";
    };

    case "refillVLS": {
        private _sideIndex = _args param [0, _requesterSide];
        if ([_sideIndex] call _validSide && {count GameData > 5}) then {
            private _count = 0;
            {
                if (count _x > 2 && {!isNull (_x # 2)}) then {
                    (_x # 2) setVehicleAmmo 1;
                    _count = _count + 1;
                };
            } forEach (GameData # 5 # _sideIndex);
            _message = format ["Debug: refilled %1 live %2 emplacement(s).", _count, ["WEST", "EAST"] # _sideIndex];
        };
    };

    case "save": {
        [] call TYR_fnc_ServerSaveState;
        _message = "Debug: campaign saved now.";
    };

    default {
        _message = format ["Debug: unknown action '%1'.", _action];
    };
};

[_changed, _message]
