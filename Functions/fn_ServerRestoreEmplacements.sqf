if (!isServer) exitWith {};
if (count GameData < 6) exitWith {};
{
    private _sideIndex = _forEachIndex;
    {
        private _recordIndex = _forEachIndex;
        private _record = _x;
        private _class = _record # 1;
        private _asset = _record # 2;
        if (isNull _asset) then {
            _asset = createVehicle [_class, _record # 8, [], 0, "NONE"];
            _asset setDir (_record # 7);
            _asset setFuel (_record # 6);
            private _damage = _record # 4;
            if (_damage isEqualType [] && {count _damage >= 3}) then {
                {
                    if (_forEachIndex < count (_damage # 2)) then {
                        _asset setHitPointDamage [_x, (_damage # 2) # _forEachIndex];
                    };
                } forEach (_damage # 0);
            };
            _record set [2, _asset];
            _record set [8, getPosATL _asset];
            (GameData # 5 # _sideIndex) set [_recordIndex, _record];
        };
        _asset setVariable ["TYR_sideIndex", _sideIndex, true];
        _asset setVariable ["TYR_emplacementKey", _record # 0, true];
        _asset addEventHandler ["Killed", {
            params ["_asset"];
            [_asset, _asset getVariable ["TYR_sideIndex", -1]] call TYR_fnc_ServerEmplacementKilled;
        }];
        [_asset, _record # 0, _sideIndex] remoteExec ["TYR_fnc_ClientAttachEmplacementActions", 0, _asset];
    } forEach _x;
} forEach (GameData # 5);
[] call TYR_fnc_ServerBroadcastState;
