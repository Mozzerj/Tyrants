if (!isServer) exitWith {};

private _savedTeams = +(GameData # 4);
{
    private _sideIndex = _forEachIndex;
    private _restored = [];
    {
        private _record = _x;
        if (_record isEqualType [] && {count _record >= 8}) then {
            private _created = [_record, _sideIndex] call TYR_fnc_VehicleCreate;
            private _veh = _created # 1;
            _veh setVariable ["TYR_sideIndex", _sideIndex, true];
            _veh addEventHandler ["Killed", {
                params ["_veh"];
                [_veh, _veh getVariable ["TYR_sideIndex", -1]] call TYR_fnc_ServerVehicleKilled;
            }];
            _restored pushBack _created;
        };
    } forEach _x;
    GameData # 4 set [_sideIndex, _restored];
} forEach _savedTeams;

[] call TYR_fnc_ServerBroadcastState;
