if (!isServer) exitWith {};

GameData = [] call TYR_fnc_CreateDefaultGameData;
TYR_savedLocationState = [];

private _saveData = profileNamespace getVariable ["TYR_Save_v2", []];
private _loaded = false;

if ((_saveData isEqualType []) && {count _saveData >= 8} && {_saveData # 0 isEqualTo 2}) then {
    private _setup = _saveData # 1;
    private _teams = _saveData # 2;
    private _players = _saveData # 3;
    private _destroyed = _saveData # 5;
    private _catalogue = _saveData # 6;
    private _vehicleState = _saveData # 7;

    if (_setup isEqualType [] && {count _setup >= 1}) then {
        (GameData # 0) set [0, +_setup];
    };
    if (_teams isEqualType [] && {count _teams >= 2}) then {
        (GameData # 0) set [1, +(_teams # 0)];
        (GameData # 0) set [2, +(_teams # 1)];
    };
    if (_players isEqualType []) then {
        (GameData # 0) set [3, +_players];
    };
    if (_destroyed isEqualType [] && {count _destroyed >= 2}) then {
        GameData set [2, +_destroyed];
    };
    if (_catalogue isEqualType [] && {count _catalogue >= 2}) then {
        GameData set [3, +_catalogue];
    };

    TYR_savedLocationState = +(_saveData # 4);

    private _runtimeVehicles = [[], []];
    if (_vehicleState isEqualType [] && {count _vehicleState >= 2}) then {
        {
            private _teamIndex = _forEachIndex;
            {
                if (_x isEqualType [] && {count _x >= 7}) then {
                    (_runtimeVehicles # _teamIndex) pushBack [
                        _x # 0,
                        objNull,
                        _x # 1,
                        _x # 2,
                        _x # 3,
                        _x # 4,
                        _x # 5,
                        _x # 6,
                        "undefined"
                    ];
                };
            } forEach _x;
        } forEach _vehicleState;
    };
    GameData set [4, _runtimeVehicles];
    _loaded = true;
};

// Best-effort migration from the original save format.
if (!_loaded) then {
    private _legacy = profileNamespace getVariable ["Tyrants", []];
    if (_legacy isEqualType [] && {count _legacy > 1} && {(_legacy # 1) isEqualType []}) then {
        private _legacyGameData = _legacy # 1;
        if (count _legacyGameData >= 5) then {
            GameData = +_legacyGameData;
            if !((GameData # 0 # 3) isEqualType []) then {(GameData # 0) set [3, []]};
            if !((GameData # 2) isEqualType []) then {GameData set [2, [[], []]]};
            if !((GameData # 3) isEqualType []) then {GameData set [3, [[], []]]};
            if !((GameData # 4) isEqualType []) then {GameData set [4, [[], []]]};
            _loaded = true;
            diag_log "[TYRANTS] Migrating legacy Tyrants save into v2 format.";
        };
    };
};

// Stage 2 in the old mission depended on an in-memory scan. Restart it safely at stage 1.
private _stage = GameData # 0 # 0 # 0;
if (_stage isEqualTo 2) then {
    GameData # 0 # 0 set [0, 1];
    _stage = 1;
};

// A completed setup must have a usable final vehicle catalogue.
if (_stage >= 3 && {count (GameData # 3) < 2 || {count (GameData # 3 # 1) == 0}}) then {
    GameData # 0 # 0 set [0, 1];
    _stage = 1;
};

publicVariable "GameData";
diag_log format ["[TYRANTS] Campaign state loaded. Setup stage: %1", _stage];
