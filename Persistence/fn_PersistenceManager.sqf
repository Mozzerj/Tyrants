if (!isServer) exitWith {};
[] spawn {
    while {true} do {
        sleep 5;
        if (!isNil "TYR_Runtime" && {TYR_Runtime getOrDefault ["saveDirty",false]}) then {
            private _urgent = TYR_Runtime getOrDefault ["saveUrgent",false];
            private _lastSave = TYR_Runtime getOrDefault ["lastSaveAt",-9999];
            private _dirtySince = TYR_Runtime getOrDefault ["dirtySince",serverTime];
            private _lastDirty = TYR_Runtime getOrDefault ["lastDirtyAt",serverTime];
            private _quiet = serverTime - _lastDirty;
            private _age = serverTime - _dirtySince;
            private _sinceSave = serverTime - _lastSave;
            if (_urgent || {(_sinceSave >= 45 && {_quiet >= 6}) || {_age >= 120}}) then {
                [false] call TYR_fnc_PersistenceSave;
            };
        };
    };
};
