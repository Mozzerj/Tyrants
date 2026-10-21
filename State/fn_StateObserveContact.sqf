params ["_factionId","_target",["_source","visual"],["_observer",objNull]];
if (!isServer || {isNull _target} || {!alive _target}) exitWith {false};

private _viewerFaction = [_factionId] call TYR_fnc_StateGetFaction;
if (count _viewerFaction isEqualTo 0) exitWith {false};

private _targetFaction = if (_target isKindOf "Man") then {
    [side group _target] call TYR_fnc_SideFaction
} else {
    _target getVariable ["TYR_factionId",[side _target] call TYR_fnc_SideFaction]
};
if !(_targetFaction in ["west","east","independent"]) exitWith {false};
if (_targetFaction isEqualTo _factionId) exitWith {false};

private _knowledge = _viewerFaction getOrDefault ["knowledge",createHashMapFromArray [["locations",createHashMap],["contacts",createHashMap],["log",[]]]];
if !("locations" in keys _knowledge) then {_knowledge set ["locations",createHashMap]};
if !("contacts" in keys _knowledge) then {_knowledge set ["contacts",createHashMap]};
if !("log" in keys _knowledge) then {_knowledge set ["log",[]]};
_viewerFaction set ["knowledge",_knowledge];
private _contacts = _knowledge get "contacts";

private _contactId = _target getVariable ["TYR_intelContactId",""];
if (_contactId isEqualTo "") then {
    private _persistentId = _target getVariable ["TYR_persistentId",""];
    _contactId = if (_persistentId isNotEqualTo "") then {format ["contact_%1",_persistentId]} else {["contact"] call TYR_fnc_StateNextId};
    _target setVariable ["TYR_intelContactId",_contactId,false];
};
private _old = _contacts getOrDefault [_contactId,createHashMap];
private _newContact = count _old isEqualTo 0;
private _oldExact = _old getOrDefault ["exact",false];

private _emplacementKey = _target getVariable ["TYR_emplacementKey",""];
private _commandRole = _target getVariable ["TYR_commandRole",""];
private _kind = if (_commandRole in ["commander","officer","force_commander"]) then {
    "command"
} else {
    if (_emplacementKey isNotEqualTo "") then {
        "emplacement"
    } else {
        if (_target isKindOf "Man") then {"infantry"} else {
            if (_target isKindOf "Air") then {"air"} else {
                if (_target isKindOf "Ship") then {"naval"} else {"vehicle"}
            }
        }
    }
};

private _broadLabel = switch (_kind) do {
    case "command": {"COMMAND PERSONNEL"};
    case "infantry": {"INFANTRY"};
    case "emplacement": {
        switch (toLower _emplacementKey) do {
            case "vls": {"MISSILE EMPLACEMENT"};
            default {"WEAPON EMPLACEMENT"};
        }
    };
    case "air": {
        if (_target isKindOf "Helicopter") then {"HELICOPTER"} else {
            if ((getNumber (configFile >> "CfgVehicles" >> typeOf _target >> "isUav")) > 0) then {"UAV"} else {"AIRCRAFT"}
        }
    };
    case "naval": {"VESSEL"};
    default {
        if (_target isKindOf "Tank") then {"ARMOURED VEHICLE"} else {
            if (_target isKindOf "Car") then {"WHEELED VEHICLE"} else {"VEHICLE"}
        }
    };
};

private _distance = if (isNull _observer) then {99999} else {_observer distance _target};
private _exactRange = switch (_source) do {
    case "player-optics": {1600};
    case "uav-visual": {2200};
    case "force-visual": {450};
    case "uav-auto": {1200};
    default {300};
};
private _exactObserved = _distance <= _exactRange;
private _exact = _oldExact || {_exactObserved};
private _displayName = getText (configFile >> "CfgVehicles" >> typeOf _target >> "displayName");
if (_displayName isEqualTo "") then {_displayName = _broadLabel};
private _label = if (_exact) then {
    if (_kind isEqualTo "command") then {
        switch (_commandRole) do {case "commander": {"MAIN COMMANDER"}; case "officer": {"COMMAND OFFICER"}; default {"FORCE COMMANDER"}}
    } else {_displayName}
} else {_broadLabel};
private _pos = getPosATL _target;
private _oldPos = _old getOrDefault ["position",_pos];
private _oldSeenServer = _old getOrDefault ["seenServerTime",-9999];
private _identUpgrade = _exactObserved && {!_oldExact};
private _reacquired = !_newContact && {(serverTime - _oldSeenServer) > 20};
private _moved = (_oldPos distance2D _pos) > 15;
private _previousPublish = _old getOrDefault ["publishedAt",-9999];

private _record = createHashMapFromArray [
    ["id",_contactId],
    ["targetFaction",_targetFaction],
    ["kind",_kind],
    ["label",_label],
    ["exact",_exact],
    ["class",if (_exact) then {typeOf _target} else {""}],
    ["position",[_pos # 0,_pos # 1,_pos param [2,0]]],
    ["direction",getDir _target],
    ["observedAt",+systemTimeUTC],
    ["seenServerTime",serverTime],
    ["source",_source],
    ["roleTag",if (_exact) then {_commandRole} else {""}],
    ["publishedAt",_previousPublish]
];
_contacts set [_contactId,_record];

private _event = "";
if (_newContact) then {_event = "NEW CONTACT"};
if (_identUpgrade) then {_event = "IDENTIFIED"};
if (_event isEqualTo "" && {_reacquired}) then {_event = "REACQUIRED"};
if (_event isNotEqualTo "") then {
    private _log = +(_knowledge getOrDefault ["log",[]]);
    _log pushBack [+systemTimeUTC,_contactId,_targetFaction,_label,+_pos,_source,_event];
    if (count _log > 80) then {_log deleteRange [0,(count _log) - 80]};
    _knowledge set ["log",_log];
};

if (_newContact || {_identUpgrade} || {_reacquired} || {_moved}) then {
    ["intelligence-contact"] call TYR_fnc_StateMarkDirty;
};

// Seeing an enemy at a strategic site is also the visual confirmation that updates site ownership.
// Automated state tests deliberately skip this side effect.
if (_source isNotEqualTo "autotest") then {
    private _locations = TYR_State getOrDefault ["locations",createHashMap];
    {
        private _location = _locations get _x;
        if ((_location getOrDefault ["owner","neutral"]) isEqualTo _targetFaction && {(_location get "position") distance2D _pos <= 220}) then {
            [_factionId,_x,_source] call TYR_fnc_StateObserveLocation;
        };
    } forEach keys _locations;
};

private _publish = _newContact || {_identUpgrade} || {_reacquired} || {_moved} || {(serverTime - _previousPublish) >= 3};
if (_publish) then {
    _record set ["publishedAt",serverTime];
    [_factionId] call TYR_fnc_ServerPublishKnowledge;
};
true
