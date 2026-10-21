if (!isServer) exitWith {};
private _forces = TYR_State get "forces";
private _runtime = TYR_Runtime get "forces";
{
    private _id = _x;
    private _f = _forces get _id;
    if (_f getOrDefault ["active",true]) then {
        private _side = [_f get "faction"] call TYR_fnc_FactionSide;
        private _grp = createGroup [_side,true];
        private _pos = _f getOrDefault ["position",[0,0,0]];
        {
            if (isClass (configFile >> "CfgVehicles" >> _x)) then {
                private _u = _grp createUnit [_x,_pos,[],15,"FORM"];
                _u setVariable ["TYR_factionId",_f get "faction",true];
            };
        } forEach (_f getOrDefault ["unitClasses",[]]);
        if (count units _grp > 0) then {_runtime set [_id,_grp]} else {_f set ["active",false];deleteGroup _grp};
    };
} forEach keys _forces;
