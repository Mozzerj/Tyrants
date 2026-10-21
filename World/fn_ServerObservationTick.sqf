if (!isServer) exitWith {};
if (((TYR_State get "campaign") getOrDefault ["phase","deployment"]) isNotEqualTo "running") exitWith {};

private _locations = TYR_State getOrDefault ["locations",createHashMap];
private _validFactions = [true] call TYR_fnc_FactionIds;
private _observers = +allPlayers;
private _runtimeForces = TYR_Runtime getOrDefault ["forces",createHashMap];
{
    private _grp = _runtimeForces getOrDefault [_x,grpNull];
    if (!isNull _grp && {count units _grp > 0}) then {
        private _lead = leader _grp;
        if (!isNull _lead && {alive _lead}) then {_observers pushBackUnique _lead};
    };
} forEach keys _runtimeForces;

private _canSeeObject = {
    params ["_observer","_obj"];
    if (isNull _observer || {isNull _obj} || {!alive _observer} || {!alive _obj}) exitWith {false};
    private _from = eyePos _observer;
    private _to = aimPos _obj;
    private _delta = _to vectorDiff _from;
    if ((vectorMagnitude _delta) <= 0.01) exitWith {true};
    private _look = vectorNormalized (eyeDirection _observer);
    private _toward = vectorNormalized _delta;
    if ((_look vectorDotProduct _toward) < 0.25) exitWith {false};
    (count (lineIntersectsSurfaces [_from,_to,_observer,_obj,true,1,"VIEW","NONE"])) isEqualTo 0
};

private _canSeePoint = {
    params ["_observer","_posATL"];
    if (isNull _observer || {!alive _observer}) exitWith {false};
    private _from = eyePos _observer;
    private _to = AGLToASL (_posATL vectorAdd [0,0,2]);
    private _delta = _to vectorDiff _from;
    if ((vectorMagnitude _delta) <= 0.01) exitWith {true};
    private _look = vectorNormalized (eyeDirection _observer);
    private _toward = vectorNormalized _delta;
    if ((_look vectorDotProduct _toward) < 0.25) exitWith {false};
    private _veh = vehicle _observer;
    (count (lineIntersectsSurfaces [_from,_to,_observer,_veh,true,1,"VIEW","NONE"])) isEqualTo 0
};

{
    private _observer = _x;
    if (!isNull _observer && {alive _observer}) then {
        private _fid = [side group _observer] call TYR_fnc_SideFaction;
        if (_fid in _validFactions) then {
            {
                private _locationId = _x;
                private _l = _locations get _locationId;
                private _pos = _l get "position";
                private _d = _observer distance2D _pos;
                if (_d <= 900) then {
                    private _trueOwner = _l getOrDefault ["owner","neutral"];
                    if (_trueOwner isNotEqualTo _fid) then {
                        private _confirmed = false;
                        if (_trueOwner in _validFactions) then {
                            private _presence = _pos nearEntities [["Man","LandVehicle","Air"],200];
                            {
                                if (!_confirmed && {alive _x}) then {
                                    private _seenFaction = if (_x isKindOf "Man") then {[side group _x] call TYR_fnc_SideFaction} else {_x getVariable ["TYR_factionId",[side _x] call TYR_fnc_SideFaction]};
                                    if (_seenFaction isEqualTo _trueOwner && {[_observer,_x] call _canSeeObject}) then {_confirmed=true};
                                };
                            } forEach _presence;
                        } else {
                            if (_trueOwner isEqualTo "neutral" && {_d <= 120}) then {
                                _confirmed = [_observer,_pos] call _canSeePoint;
                            };
                        };
                        if (_confirmed) then {
                            [_fid,_locationId,if (_observer in allPlayers) then {"player-visual"} else {"force-visual"}] call TYR_fnc_StateObserveLocation;
                        };
                    };
                };
            } forEach keys _locations;
        };
    };
} forEach _observers;
