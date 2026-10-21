params ["_map"];
if (isNil "TYR_ClientState") exitWith {};
[_map,0.045,false] call TYR_fnc_DrawDeploymentSectors;
private _locations = TYR_ClientState get "locations";
{
    private _l = _x;
    private _kind = _l # 2;
    private _pos = _l # 3;
    private _owner = _l # 4;
    private _current = count _l > 10 && {_l # 10};
    private _observedAt = if (count _l > 8) then {_l # 8} else {[]};
    private _color = [0.48,0.48,0.48,0.45];
    if (_owner in ["west","east","independent"]) then {
        _color = [_owner,true] call TYR_fnc_FactionColor;
        if (!_current) then {_color set [3,0.48]};
    };
    if (_owner isEqualTo "neutral") then {_color=[0.62,0.62,0.62,0.55]};
    private _icon = switch (_kind) do {case "city":{"\A3\ui_f\data\map\markers\military\circle_CA.paa"};case "factory":{"\A3\ui_f\data\map\markers\nato\b_installation.paa"};default {"\A3\ui_f\data\map\markers\military\dot_CA.paa"}};
    private _status = "UNKNOWN";
    if (_current) then {
        _status = "FRIENDLY CONTROL";
    } else {
        if (_owner isNotEqualTo "unknown") then {
            private _stamp = "";
            if (_observedAt isEqualType [] && {count _observedAt >= 6}) then {
                _stamp = format [" %1:%2",[_observedAt # 3,2] call BIS_fnc_padNumber,[_observedAt # 4,2] call BIS_fnc_padNumber];
            };
            _status = format ["LAST OBS %1%2",toUpper _owner,_stamp];
        };
    };
    private _label = format ["%1  [%2]",_l # 1,_status];
    if (_kind isEqualTo "factory" && {_current} && {(_l # 5) >= 0}) then {
        _label = format ["%1  [%2 // STOCK %3]",_l # 1,_status,round (_l # 5)];
    };
    _map drawIcon [_icon,_color,_pos,20,20,0,_label,1,0.035,"PuristaMedium","right"];
} forEach values _locations;

// Enemy information on the normal map comes only from the faction intelligence database.
// Contact positions freeze when observation stops; the server never streams the live object here.
private _knowledge = TYR_ClientState getOrDefault ["knowledge",[]];
if (_knowledge isEqualType [] && {count _knowledge >= 4}) then {
    private _knowledgeServerTime = _knowledge # 1;
    private _receivedAt = missionNamespace getVariable ["TYR_ClientKnowledgeReceivedAt",diag_tickTime];
    private _estimatedServerTime = _knowledgeServerTime + (diag_tickTime - _receivedAt);
    {
        if (_x isEqualType [] && {count _x >= 10}) then {
            _x params ["_contactId","_targetFaction","_kind","_contactLabel","_exact","_pos","_dir","_observedAt","_source","_seenServerTime"];
            if (count _pos >= 2) then {
                private _age = (_estimatedServerTime - _seenServerTime) max 0;
                private _alpha = if (_age <= 10) then {0.95} else {if (_age <= 60) then {0.78} else {if (_age <= 300) then {0.58} else {0.38}}};
                private _color = if (_targetFaction in ["west","east","independent"]) then {[_targetFaction,true] call TYR_fnc_FactionColor} else {[0.7,0.7,0.7,1]};
                _color set [3,_alpha];
                private _icon = switch (_kind) do {
                    case "infantry": {"\A3\ui_f\data\map\markers\nato\b_inf.paa"};
                    case "air": {"\A3\ui_f\data\map\markers\nato\b_air.paa"};
                    case "emplacement": {"\A3\ui_f\data\map\markers\nato\b_art.paa"};
                    case "naval": {"\A3\ui_f\data\map\markers\nato\b_naval.paa"};
                    default {"\A3\ui_f\data\map\markers\nato\b_motor_inf.paa"};
                };
                private _ageText = if (_age < 10) then {"NOW"} else {if (_age < 60) then {format ["%1s AGO",floor _age]} else {if (_age < 3600) then {format ["%1m AGO",floor (_age / 60)]} else {"STALE"}}};
                private _idText = if (_exact) then {"IDENTIFIED"} else {"UNIDENTIFIED"};
                private _label = format ["%1 // %2 // LAST SEEN %3",toUpper _contactLabel,_idText,_ageText];
                _map drawIcon [_icon,_color,_pos,18,18,_dir,_label,1,0.025,"PuristaMedium","right"];
            };
        };
    } forEach (_knowledge # 2);
};

private _f = (TYR_ClientState get "factions") getOrDefault [TYR_PlayerFaction,[]];
if (count _f > 4 && {_f # 2} && {count (_f # 4) >= 2}) then {
    _map drawIcon ["\A3\ui_f\data\map\markers\nato\b_hq.paa",[TYR_PlayerFaction,true] call TYR_fnc_FactionColor,_f # 4,30,30,0,format ["%1 HQ",_f # 1],1,0.04,"PuristaMedium","right"];
};

{
    private _fid = _x getVariable ["TYR_factionId",""];
    if (_fid isEqualTo TYR_PlayerFaction && {alive _x}) then {
        private _emp = _x getVariable ["TYR_emplacementKey",""];
        private _icon = if (_emp isNotEqualTo "") then {"\A3\ui_f\data\map\markers\nato\b_art.paa"} else {"\A3\ui_f\data\map\markers\nato\b_motor_inf.paa"};
        private _label = if (_emp isNotEqualTo "") then {toUpper _emp} else {getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName")};
        _map drawIcon [_icon,[_fid,true] call TYR_fnc_FactionColor,getPosATL _x,17,17,getDir _x,_label,0,0.022,"PuristaMedium","right"];
    };
} forEach vehicles;
