params ["_map"];
// Region colour is supplied by the reliable local marker overlay. This draw pass
// keeps crisp sector boundaries and labels on top of it.
[_map,0.0,true,false] call TYR_fnc_DrawDeploymentSectors;
if (isNil "TYR_PlayerFaction" || {isNil "TYR_ClientState"}) exitWith {};

private _f = (TYR_ClientState get "factions") getOrDefault [TYR_PlayerFaction,[]];
private _color = [TYR_PlayerFaction,true] call TYR_fnc_FactionColor;
if (count _f > 11 && {_f # 11} && {count (_f # 4) >= 2}) then {
    _map drawIcon ["\A3\ui_f\data\map\markers\nato\b_hq.paa",_color,_f # 4,30,30,0,"YOUR CONFIRMED HQ",1,0.04,"PuristaMedium","right"];
};

// Pending HQ and collision footprints are intentionally NOT drawn here. The
// embedded map has proven inconsistent with small drawLine geometry. They are
// rendered as client-local rectangle markers in DeploymentMapClick, using the
// same reliable renderer as the coloured deployment regions.
// TYR_DeploymentCollisions remain client-local preview state; their visible
// geometry is created as reliable rectangle markers by DeploymentMapClick.
