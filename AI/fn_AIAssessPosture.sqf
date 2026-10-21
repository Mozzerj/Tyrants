params ["_factionId","_picture"];
private _f = [_factionId] call TYR_fnc_StateGetFaction;
private _cmd = _f getOrDefault ["commander",createHashMap];
private _personality = _cmd getOrDefault ["personality","balanced"];
private _network = _picture getOrDefault ["networkStatus","forming"];
private _forceCount = _picture getOrDefault ["forceCount",0];
private _desired = _picture getOrDefault ["desiredForces",3];
private _available = _picture getOrDefault ["availableCount",0];
private _resources = _picture getOrDefault ["resources",createHashMap];
private _unknown = count (_picture getOrDefault ["unknownLocations",[]]);
private _hostile = count (_picture getOrDefault ["knownHostileLocations",[]]);
private _threats = count (_picture getOrDefault ["emergencyThreats",[]]);
private _ammo = _resources getOrDefault ["ammo",0];
private _fuel = _resources getOrDefault ["fuel",0];

private _posture = "hold";
private _reason = "No stronger strategic condition";
if (_threats > 0) then {
    _posture = "emergency_defence";
    _reason = format ["%1 recent known threat(s) inside critical friendly radius",_threats];
} else {
    if (_network in ["succession","degraded","isolated"]) then {
        _posture = "defensive";
        _reason = format ["Command network is %1",toUpper _network];
    } else {
        if (_forceCount < _desired || {_ammo < 1500} || {_fuel < 1000}) then {
            _posture = "consolidate";
            _reason = format ["Force/logistics rebuild required (%1/%2 forces)",_forceCount,_desired];
        } else {
            if (_unknown > (_hostile max 1)) then {
                _posture = "probe";
                _reason = format ["Strategic picture incomplete: %1 unknown locations",_unknown];
            } else {
                if (_hostile > 0 && {_available > 0}) then {
                    _posture = if (_personality isEqualTo "aggressive" && {_forceCount >= (_desired + 1)}) then {"exploit"} else {"offensive"};
                    _reason = format ["%1 known hostile location(s) and mobile reserve available",_hostile];
                } else {
                    if (_personality isEqualTo "defensive") then {
                        _posture = "defensive";
                        _reason = "Defensive personality with no compelling attack";
                    };
                };
            };
        };
    };
};
_cmd set ["posture",_posture];
[_posture,_reason]
