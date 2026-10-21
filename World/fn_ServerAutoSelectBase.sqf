params ["_factionId"];
if (!isServer) exitWith {false};
private _campaign = TYR_State get "campaign";
if ((_campaign getOrDefault ["phase","deployment"]) isNotEqualTo "deployment") exitWith {false};
private _f = [_factionId] call TYR_fnc_StateGetFaction;
if (count _f isEqualTo 0 || {!(_f getOrDefault ["active",false])} || {_f getOrDefault ["baseConfirmed",false]}) exitWith {false};
private _deployment = _campaign get "deployment";
private _sector = (_deployment get "sectors") getOrDefault [_factionId,[]];
private _buffer = _deployment getOrDefault ["buffer",2500];
if (count _sector < 2) exitWith {false};

private _locations = values (TYR_State get "locations");
private _best = [];
private _bestScore = -1e12;
private _step = worldSize / 28;
for "_gx" from (_step * 0.5) to (worldSize - _step * 0.5) step _step do {
    for "_gy" from (_step * 0.5) to (worldSize - _step * 0.5) step _step do {
        private _p = [_gx,_gy,0];
        private _check = [_p,_sector,_buffer] call TYR_fnc_DeploymentCheckPosition;
        if (_check # 0) then {
            private _score = ((_check # 2) min 7000) * 0.25;
            {
                private _loc = _x;
                private _d = _p distance2D (_loc get "position");
                if (_d < 6500) then {_score = _score + ((_loc getOrDefault ["value",1]) * (6500 - _d) / 6500 * 900)};
            } forEach _locations;
            _score = _score + random 250;
            if (_score > _bestScore) then {_bestScore=_score;_best=_p};
        };
    };
};
if (count _best < 2) exitWith {diag_log format ["[TYRANTS DEPLOYMENT] AI %1 could not find a valid HQ position.",_factionId];false};
_f set ["basePosition",_best];
_f set ["baseConfirmed",true];
["ai-hq-selected",true] call TYR_fnc_StateMarkDirty;
diag_log format ["[TYRANTS DEPLOYMENT] AI %1 selected an HQ inside its deployment region.",_factionId];
true
