params ["_map"];
[_map,0.055,true] call TYR_fnc_DrawDeploymentSectors;
if (isNil "TYR_PlayerFaction" || {isNil "TYR_ClientState"}) exitWith {};
private _f = (TYR_ClientState get "factions") getOrDefault [TYR_PlayerFaction,[]];
private _color = [TYR_PlayerFaction,true] call TYR_fnc_FactionColor;
if (count _f > 11 && {_f # 11} && {count (_f # 4) >= 2}) then {
    _map drawIcon ["\A3\ui_f\data\map\markers\nato\b_hq.paa",_color,_f # 4,30,30,0,"YOUR CONFIRMED HQ",1,0.04,"PuristaMedium","right"];
};
private _clicked = missionNamespace getVariable ["TYR_DeploymentLastClicked",[]];
if (count _clicked >= 2) then {
    private _check = missionNamespace getVariable ["TYR_DeploymentLastCheck",[false,"",0,0]];
    private _clickColor = if (_check # 0) then {[0.35,1,0.45,1]} else {[1,0.32,0.24,1]};
    _map drawIcon ["\A3\ui_f\data\map\markers\military\dot_CA.paa",_clickColor,_clicked,18,18,0,if (_check # 0) then {"CLICK ACCEPTED"} else {"CLICKED POSITION"},1,0.032,"PuristaMedium","right"];
};
private _pending = missionNamespace getVariable ["TYR_DeploymentPending",[]];
if (count _pending >= 2) then {
    _map drawIcon ["\A3\ui_f\data\map\markers\military\pickup_CA.paa",_color,_pending,28,28,0,"PROPOSED HQ",1,0.04,"PuristaMedium","right"];
};
