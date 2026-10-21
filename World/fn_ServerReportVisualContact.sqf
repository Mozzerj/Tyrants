params ["_target",["_reportedObserver",objNull],["_reportedSource","player-visual"]];
if (!isServer || {isNull _target} || {!alive _target}) exitWith {};
private _owner = remoteExecutedOwner;
private _player = [_owner] call TYR_fnc_FindPlayerByOwner;
if (isNull _player || {!alive _player}) exitWith {};
private _factionId = [side _player] call TYR_fnc_SideFaction;
if !(_factionId in ["west","east","independent"]) exitWith {};

private _connectedUAV = getConnectedUAV _player;
private _observer = _reportedObserver;
if (isNull _observer) then {_observer = _player};
private _allowedObserver = _observer isEqualTo _player || {_observer isEqualTo vehicle _player} || {!isNull _connectedUAV && {_observer isEqualTo _connectedUAV}};
if (!_allowedObserver) exitWith {};

private _source = "player-visual";
private _maxRange = 2500;
if (!isNull _connectedUAV && {_observer isEqualTo _connectedUAV}) then {
    _source = "uav-visual";
    _maxRange = 6500;
} else {
    private _weapon = toLower currentWeapon _player;
    private _usingOptics = (_weapon find "binocular") >= 0 || {(_weapon find "rangefinder") >= 0} || {(_weapon find "laserdesignator") >= 0};
    if (_usingOptics) then {_source="player-optics";_maxRange=4500};
};

private _targetFaction = if (_target isKindOf "Man") then {[side group _target] call TYR_fnc_SideFaction} else {_target getVariable ["TYR_factionId",[side _target] call TYR_fnc_SideFaction]};
if !(_targetFaction in ["west","east","independent"] && {_targetFaction isNotEqualTo _factionId}) exitWith {};
if !([_observer,_target,_maxRange,-2] call TYR_fnc_ObservationCanSee) exitWith {};
[_factionId,_target,_source,_observer] call TYR_fnc_StateObserveContact;
