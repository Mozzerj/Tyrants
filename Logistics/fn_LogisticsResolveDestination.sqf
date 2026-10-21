params ["_job"];
private _type = _job getOrDefault ["destinationType","hq"];
private _id = _job getOrDefault ["destinationId",""];
private _pos = +(_job getOrDefault ["destinationPosition",[]]);
switch (_type) do {
    case "hq": {
        private _f = [_job getOrDefault ["faction",""]] call TYR_fnc_StateGetFaction;
        if (count _f > 0) then {_pos = +(_f getOrDefault ["basePosition",_pos])};
    };
    case "force": {
        private _fr = (TYR_State getOrDefault ["forces",createHashMap]) getOrDefault [_id,createHashMap];
        if (count _fr > 0) then {
            _pos = +(_fr getOrDefault ["position",_pos]);
            private _grp = (TYR_Runtime getOrDefault ["forces",createHashMap]) getOrDefault [_id,grpNull];
            if (!isNull _grp && {count units _grp > 0}) then {_pos = getPosATL leader _grp};
        };
    };
    case "factory"; case "location": {
        private _loc = [_id] call TYR_fnc_StateGetLocation;
        if (count _loc > 0) then {_pos = +(_loc getOrDefault ["position",_pos])};
    };
};
_pos
