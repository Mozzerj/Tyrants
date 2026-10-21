params ["_factionId","_picture","_posture","_candidates"];
private _f = [_factionId] call TYR_fnc_StateGetFaction;
private _cmd = _f getOrDefault ["commander",createHashMap];
private _personality = _cmd getOrDefault ["personality","balanced"];
private _forcePositions = _picture getOrDefault ["forcePositions",createHashMap];
private _freeForces = _picture getOrDefault ["freeForces",[]];
private _network = _picture getOrDefault ["networkStatus","forming"];
private _ranked = [];

{
    private _c = _x;
    private _type = _c getOrDefault ["type","hold"];
    private _score = _c getOrDefault ["baseScore",0];
    private _pos = _c getOrDefault ["targetPosition",[]];
    private _age = _c getOrDefault ["intelAge",0];
    private _distance = 0;
    if (count _pos >= 2 && {count _freeForces > 0}) then {
        _distance = 1e12;
        {
            private _fp = _forcePositions getOrDefault [_x,[]];
            if (count _fp >= 2) then {_distance = _distance min (_fp distance2D _pos)};
        } forEach _freeForces;
        if (_distance >= 1e12) then {_distance = 0};
    };
    _score = _score - (_distance / 300);

    if (_age < 1e8) then {_score = _score - ((_age max 0) / 8)};
    if (_type in ["recon","probe"] && {_age >= 1e8}) then {_score = _score + 35};

    switch (_posture) do {
        case "emergency_defence": {if (_type in ["defend","reinforce"]) then {_score = _score + 600} else {_score = _score - 250}};
        case "defensive": {if (_type in ["defend","reinforce","recon","raise_force","research","hold"]) then {_score = _score + 30}; if (_type in ["attack","exploit","raid"]) then {_score = _score - 25}};
        case "consolidate": {if (_type in ["raise_force","research","hold","recon","defend","reinforce"]) then {_score = _score + 45}; if (_type in ["attack","exploit"]) then {_score = _score - 30}};
        case "probe": {if (_type in ["probe","recon"]) then {_score = _score + 55}};
        case "offensive": {if (_type in ["attack","raid"]) then {_score = _score + 45}};
        case "exploit": {if (_type in ["exploit","raid","attack"]) then {_score = _score + 70}};
    };

    if (_personality isEqualTo "aggressive") then {
        if (_type in ["attack","exploit","raid","probe"]) then {_score = _score + 22};
        if (_type isEqualTo "hold") then {_score = _score - 12};
    };
    if (_personality isEqualTo "defensive") then {
        if (_type in ["defend","reinforce","recon","raise_force","hold"]) then {_score = _score + 22};
        if (_type in ["attack","exploit"]) then {_score = _score - 18};
    };

    if (_network in ["degraded","succession"]) then {_score = _score - (if (_type in ["attack","raid","exploit"]) then {25} else {8})};
    if (_network isEqualTo "isolated") then {_score = _score - (if (_type in ["attack","raid","exploit"]) then {50} else {15})};

    _c set ["score",_score];
    _c set ["distance",_distance];
    _c set ["scoreBreakdown",format ["base %1 // distance -%2 // intel age %3s // posture %4 // personality %5",round (_c getOrDefault ["baseScore",0]),round (_distance / 300),if (_age >= 1e8) then {-1} else {round _age},toUpper _posture,toUpper _personality]];
    _ranked pushBack [_score,_forEachIndex,_c];
} forEach _candidates;
_ranked sort false;
_ranked apply {_x # 2}
