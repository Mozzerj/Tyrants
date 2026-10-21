if (!isServer) exitWith {};
if (((TYR_State get "campaign") getOrDefault ["phase","deployment"]) isNotEqualTo "running") exitWith {};

private _locations = TYR_State getOrDefault ["locations",createHashMap];
private _validFactions = [true] call TYR_fnc_FactionIds;
private _runtimeForces = TYR_Runtime getOrDefault ["forces",createHashMap];
private _forceObservers = [];
{
    private _grp = _runtimeForces getOrDefault [_x,grpNull];
    if (!isNull _grp && {count units _grp > 0}) then {
        private _lead = leader _grp;
        if (!isNull _lead && {alive _lead}) then {_forceObservers pushBackUnique _lead};
    };
} forEach keys _runtimeForces;

// Location ownership becomes known only when a faction viewpoint genuinely sees evidence at the site.
private _locationObservers = +allPlayers;
{_locationObservers pushBackUnique _x} forEach _forceObservers;
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
                                    if (_seenFaction isEqualTo _trueOwner && {[_observer,_x,1200,0.25] call TYR_fnc_ObservationCanSee}) then {_confirmed=true};
                                };
                            } forEach _presence;
                        } else {
                            if (_trueOwner isEqualTo "neutral" && {_d <= 120}) then {_confirmed = [_observer,_pos] call _canSeePoint};
                        };
                        if (_confirmed) then {
                            [_fid,_locationId,if (_observer in allPlayers) then {"player-visual"} else {"force-visual"}] call TYR_fnc_StateObserveLocation;
                        };
                    };
                };
            } forEach keys _locations;
        };
    };
} forEach _locationObservers;

// AI force leaders create real last-known contacts from their own line of sight.
{
    private _observer = _x;
    private _fid = [side group _observer] call TYR_fnc_SideFaction;
    if (_fid in _validFactions) then {
        private _seenCount = 0;
        {
            if (_seenCount < 10 && {alive _x} && {_x isNotEqualTo _observer}) then {
                // Do not double-report infantry that are sitting inside a vehicle; the vehicle is the useful contact.
                if !(_x isKindOf "Man" && {vehicle _x isNotEqualTo _x}) then {
                    private _targetFaction = if (_x isKindOf "Man") then {[side group _x] call TYR_fnc_SideFaction} else {_x getVariable ["TYR_factionId",[side _x] call TYR_fnc_SideFaction]};
                    if (_targetFaction in _validFactions && {_targetFaction isNotEqualTo _fid}) then {
                        if ([_observer,_x,900,0.10] call TYR_fnc_ObservationCanSee) then {
                            [_fid,_x,"force-visual",_observer] call TYR_fnc_StateObserveContact;
                            _seenCount = _seenCount + 1;
                        };
                    };
                };
            };
        } forEach (_observer nearEntities [["Man","LandVehicle","Air","Ship"],900]);
    };
} forEach _forceObservers;

// Physical UAVs can also gather intelligence. They only report objects with unobstructed visual line of sight.
{
    private _uav = _x;
    if (!isNull _uav && {alive _uav} && {(getNumber (configFile >> "CfgVehicles" >> typeOf _uav >> "isUav")) > 0}) then {
        private _fid = _uav getVariable ["TYR_factionId",[side _uav] call TYR_fnc_SideFaction];
        if (_fid in _validFactions) then {
            private _seenCount = 0;
            {
                if (_seenCount < 8 && {alive _x} && {_x isNotEqualTo _uav}) then {
                    if !(_x isKindOf "Man" && {vehicle _x isNotEqualTo _x}) then {
                        private _targetFaction = if (_x isKindOf "Man") then {[side group _x] call TYR_fnc_SideFaction} else {_x getVariable ["TYR_factionId",[side _x] call TYR_fnc_SideFaction]};
                        if (_targetFaction in _validFactions && {_targetFaction isNotEqualTo _fid}) then {
                            if ([_uav,_x,2500,0.0] call TYR_fnc_ObservationCanSee) then {
                                [_fid,_x,"uav-auto",_uav] call TYR_fnc_StateObserveContact;
                                _seenCount = _seenCount + 1;
                            };
                        };
                    };
                };
            } forEach (_uav nearEntities [["Man","LandVehicle","Air","Ship"],2500]);
        };
    };
} forEach vehicles;
