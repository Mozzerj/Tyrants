if (!isServer) exitWith {};

GameData = [] call TYR_fnc_CreateDefaultGameData;
TYR_savedLocationState = [];
private _loaded = false;

private _normaliseTeam = {
    params ["_team"];
    private _result = +_team;
    while {count _result < 5} do {_result pushBack 0};
    private _research = _result param [5, [[0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]]];
    if !(_research isEqualType [] && {count _research >= 3}) then {
        _research = [[0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]];
    };
    _result set [5, +_research];
    private _targets = _result param [6, []];
    if !(_targets isEqualType []) then {_targets = []};
    _result set [6, +_targets];
    _result
};

private _loadSave = {
    params ["_saveData", "_version"];
    private _setup = _saveData # 1;
    private _teams = _saveData # 2;
    private _players = _saveData # 3;
    private _destroyed = _saveData # 5;
    private _catalogue = _saveData # 6;
    private _vehicleState = _saveData # 7;

    if (_setup isEqualType [] && {count _setup >= 1}) then {(GameData # 0) set [0, +_setup]};
    if (_teams isEqualType [] && {count _teams >= 2}) then {
        (GameData # 0) set [1, [_teams # 0] call _normaliseTeam];
        (GameData # 0) set [2, [_teams # 1] call _normaliseTeam];
    };
    if (_players isEqualType []) then {(GameData # 0) set [3, +_players]};
    if (_destroyed isEqualType [] && {count _destroyed >= 2}) then {GameData set [2, +_destroyed]};
    if (_catalogue isEqualType [] && {count _catalogue >= 2}) then {GameData set [3, +_catalogue]};
    TYR_savedLocationState = +(_saveData # 4);

    private _runtimeVehicles = [[], []];
    if (_vehicleState isEqualType [] && {count _vehicleState >= 2}) then {
        {
            private _teamIndex = _forEachIndex;
            {
                if (_x isEqualType [] && {count _x >= 7}) then {
                    (_runtimeVehicles # _teamIndex) pushBack [_x # 0, objNull, _x # 1, _x # 2, _x # 3, _x # 4, _x # 5, _x # 6, "undefined"];
                };
            } forEach _x;
        } forEach _vehicleState;
    };
    GameData set [4, _runtimeVehicles];

    private _runtimeEmplacements = [[], []];
    if (_version >= 3 && {count _saveData >= 9}) then {
        private _emplacementState = _saveData # 8;
        if (_emplacementState isEqualType [] && {count _emplacementState >= 2}) then {
            {
                private _teamIndex = _forEachIndex;
                {
                    if (_x isEqualType [] && {count _x >= 8}) then {
                        (_runtimeEmplacements # _teamIndex) pushBack [_x # 0, _x # 1, objNull, _x # 2, _x # 3, _x # 4, _x # 5, _x # 6, _x # 7];
                    };
                } forEach _x;
            } forEach _emplacementState;
        };
    };
    GameData set [5, _runtimeEmplacements];
};

private _saveV3 = profileNamespace getVariable ["TYR_Save_v3", []];
if (_saveV3 isEqualType [] && {count _saveV3 >= 9} && {_saveV3 # 0 isEqualTo 3}) then {
    [_saveV3, 3] call _loadSave;
    _loaded = true;
};

if (!_loaded) then {
    private _saveV2 = profileNamespace getVariable ["TYR_Save_v2", []];
    if (_saveV2 isEqualType [] && {count _saveV2 >= 8} && {_saveV2 # 0 isEqualTo 2}) then {
        [_saveV2, 2] call _loadSave;
        _loaded = true;
        diag_log "[TYRANTS] Migrating v2 campaign save to v3.";
    };
};

if (!_loaded) then {
    private _legacy = profileNamespace getVariable ["Tyrants", []];
    if (_legacy isEqualType [] && {count _legacy > 1} && {(_legacy # 1) isEqualType []}) then {
        private _legacyGameData = +(_legacy # 1);
        if (count _legacyGameData >= 5) then {
            GameData = _legacyGameData;
            if !((GameData # 0 # 3) isEqualType []) then {(GameData # 0) set [3, []]};
            (GameData # 0) set [1, [GameData # 0 # 1] call _normaliseTeam];
            (GameData # 0) set [2, [GameData # 0 # 2] call _normaliseTeam];
            if !((GameData # 2) isEqualType []) then {GameData set [2, [[], []]]};
            if !((GameData # 3) isEqualType []) then {GameData set [3, [[], []]]};
            if !((GameData # 4) isEqualType []) then {GameData set [4, [[], []]]};
            private _legacyEmplacements = [[], []];
            if (count GameData > 5 && {(GameData # 5) isEqualType []} && {count (GameData # 5) >= 2}) then {
                {
                    private _sideIndex = _forEachIndex;
                    {
                        // 18/10/2024 prototype: [class, object, colour, damage, ammo, fuel, dir, pos, marker]
                        if (_x isEqualType [] && {count _x >= 8}) then {
                            private _class = _x # 0;
                            private _key = if (_class isEqualTo "B_Ship_MRLS_01_F") then {"vls"} else {"legacy"};
                            (_legacyEmplacements # _sideIndex) pushBack [_key, _class, objNull, _x # 2, _x # 3, _x # 4, _x # 5, _x # 6, _x # 7];
                        };
                    } forEach _x;
                } forEach (GameData # 5);
            };
            GameData set [5, _legacyEmplacements];
            _loaded = true;
            diag_log "[TYRANTS] Migrating legacy Tyrants save into v3 format.";
        };
    };
};

private _stage = GameData # 0 # 0 # 0;
if (_stage isEqualTo 2) then {GameData # 0 # 0 set [0, 1]; _stage = 1};
if (_stage >= 3 && {count (GameData # 3) < 2 || {count (GameData # 3 # 1) == 0}}) then {
    GameData # 0 # 0 set [0, 1];
    _stage = 1;
};

publicVariable "GameData";
diag_log format ["[TYRANTS] Campaign state loaded. Save v3, setup stage: %1", _stage];
