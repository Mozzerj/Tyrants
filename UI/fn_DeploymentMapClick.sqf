params ["_position"];
if (isNil "TYR_ClientState" || {isNil "TYR_PlayerFaction"}) exitWith {};
if !(_position isEqualType [] && {count _position >= 2}) exitWith {};

private _clicked = [_position # 0,_position # 1,0];
missionNamespace setVariable ["TYR_DeploymentLastClicked",_clicked];

private _campaign = TYR_ClientState getOrDefault ["campaign",[]];
if (count _campaign < 2 || {(_campaign # 0) isNotEqualTo "deployment"}) exitWith {
    missionNamespace setVariable ["TYR_DeploymentPending",[]];
    missionNamespace setVariable ["TYR_DeploymentLastCheck",[false,"DEPLOYMENT IS NOT CURRENTLY ACCEPTING HQ SELECTIONS",0,0]];
    [] call TYR_fnc_DeploymentMenuRefresh;
};

private _f = (TYR_ClientState get "factions") getOrDefault [TYR_PlayerFaction,[]];
if (count _f < 12) exitWith {};
if ((_f # 3) isNotEqualTo "human") exitWith {hint "This faction uses an AI strategic commander."};
if (_f # 11) exitWith {hint "Your faction HQ is already confirmed."};

private _deployment = _campaign # 1;
private _sectorEntry = (_deployment # 2) select {
    _x isEqualType [] && {count _x >= 2} && {(_x # 0) isEqualTo TYR_PlayerFaction}
};
if (count _sectorEntry isEqualTo 0) exitWith {
    missionNamespace setVariable ["TYR_DeploymentPending",[]];
    missionNamespace setVariable ["TYR_DeploymentLastCheck",[false,"NO DEPLOYMENT REGION DATA FOR YOUR FACTION",0,0]];
    [] call TYR_fnc_DeploymentMenuRefresh;
};

private _sector = (_sectorEntry # 0) # 1;
private _buffer = _deployment # 1;
private _check = [_clicked,_sector,_buffer] call TYR_fnc_DeploymentCheckPosition;
private _selected = [];

if (_check # 0) then {
    _selected = _clicked;
} else {
    // A click on a road, building, water edge or rough ground should not feel ignored.
    // If the click is inside the strategic region, search nearby for the closest legal HQ site.
    private _reason = _check # 1;
    private _hardReject = _reason in ["OUTSIDE YOUR DEPLOYMENT SECTOR","OUTSIDE THE OPERATION AREA","NO DEPLOYMENT SECTOR"];
    if (!_hardReject) then {
        private _found = false;
        {
            private _radius = _x;
            for "_a" from 0 to 330 step 30 do {
                if (!_found) then {
                    private _candidate = [
                        (_clicked # 0) + (sin _a) * _radius,
                        (_clicked # 1) + (cos _a) * _radius,
                        0
                    ];
                    private _candidateCheck = [_candidate,_sector,_buffer] call TYR_fnc_DeploymentCheckPosition;
                    if (_candidateCheck # 0) then {
                        _selected = _candidate;
                        _check = [true,format ["VALID HQ SITE // adjusted %1m to nearby clear ground",round (_clicked distance2D _candidate)],_candidateCheck # 2,_candidateCheck # 3];
                        _found = true;
                    };
                };
            };
            if (_found) exitWith {};
        } forEach [75,150,250,400,600,850,1100,1400];
    };
};

missionNamespace setVariable ["TYR_DeploymentLastCheck",_check];
missionNamespace setVariable ["TYR_DeploymentPending",_selected];
[] call TYR_fnc_DeploymentMenuRefresh;
