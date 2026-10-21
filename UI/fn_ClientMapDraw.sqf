params ["_map"];
if (isNil "TYR_ClientState") exitWith {};
[_map,0.045,false] call TYR_fnc_DrawDeploymentSectors;
private _locations = TYR_ClientState get "locations";
{
    private _l = _x;
    private _kind = _l # 2;
    private _pos = _l # 3;
    private _owner = _l # 4;
    private _color = if (_owner in ["west","east","independent"]) then {[_owner,true] call TYR_fnc_FactionColor} else {[0.6,0.6,0.6,0.8]};
    private _icon = switch (_kind) do {case "city":{"\A3\ui_f\data\map\markers\military\circle_CA.paa"};case "factory":{"\A3\ui_f\data\map\markers\nato\b_installation.paa"};default {"\A3\ui_f\data\map\markers\military\dot_CA.paa"}};
    private _label = _l # 1;
    if (_kind isEqualTo "factory") then {_label = format ["%1  [%2]",_label,round (_l # 5)]};
    _map drawIcon [_icon,_color,_pos,20,20,0,_label,1,0.035,"PuristaMedium","right"];
} forEach values _locations;

private _f = (TYR_ClientState get "factions") getOrDefault [TYR_PlayerFaction,[]];
if (count _f > 4 && {_f # 2} && {count (_f # 4) >= 2}) then {
    _map drawIcon ["\A3\ui_f\data\map\markers\nato\b_hq.paa",[TYR_PlayerFaction,true] call TYR_fnc_FactionColor,_f # 4,30,30,0,format ["%1 HQ",_f # 1],1,0.04,"PuristaMedium","right"];
};

// Friendly persistent assets are already networked objects; no global campaign scan or marker objects are needed.
{
    private _fid = _x getVariable ["TYR_factionId",""];
    if (_fid isEqualTo TYR_PlayerFaction && {alive _x}) then {
        private _emp = _x getVariable ["TYR_emplacementKey",""];
        private _icon = if (_emp isNotEqualTo "") then {"\A3\ui_f\data\map\markers\nato\b_art.paa"} else {"\A3\ui_f\data\map\markers\nato\b_motor_inf.paa"};
        private _label = if (_emp isNotEqualTo "") then {toUpper _emp} else {getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName")};
        _map drawIcon [_icon,[_fid,true] call TYR_fnc_FactionColor,getPosATL _x,17,17,getDir _x,_label,0,0.022,"PuristaMedium","right"];
    };
} forEach vehicles;
