params ["_record"];
if !(_record isEqualType [] && {count _record isEqualTo 8}) exitWith {false};
if ((_record # 0) isNotEqualTo "TYRANTS_V4") exitWith {false};
if ((_record # 1) isNotEqualTo 2) exitWith {false};
if !((_record # 2) isEqualType 0 && {(_record # 2) >= 1}) exitWith {false};
if ((_record # 3) isNotEqualTo worldName) exitWith {false};
private _snapshot = _record # 6;
if !(_snapshot isEqualType []) exitWith {false};
if ((_record # 7) isNotEqualTo (hashValue (str _snapshot))) exitWith {false};

// Persisted records are deliberately restricted to primitive values and arrays.
private _serial = {
    params ["_v"];
    if (_v isEqualType []) exitWith {(_v findIf {!([_x] call _serial)}) < 0};
    (_v isEqualType "") || {_v isEqualType 0} || {_v isEqualType true}
};
if !([_record] call _serial) exitWith {false};

private _validPos = {
    params ["_p"];
    _p isEqualType [] && {count _p >= 2} && {(_p # 0) isEqualType 0} && {(_p # 1) isEqualType 0}
};
private _validLandPos = {
    params ["_p"];
    [_p] call TYR_fnc_IsValidLandPosition
};
private _unique = {
    params ["_ids"];
    (count _ids) isEqualTo (count (_ids arrayIntersect _ids)) && {(_ids findIf {_x isEqualTo ""}) < 0}
};
private _sectionKeys = _snapshot apply {_x param [0,""]};
private _required = ["campaign","factions","locations","players","vehicles","emplacements","forces","operations","destroyedBuildings"];
if ((count _sectionKeys) isNotEqualTo (count (_sectionKeys arrayIntersect _sectionKeys))) exitWith {false};
if ((_required findIf {!(_x in _sectionKeys)}) >= 0) exitWith {false};

private _campaign = [_snapshot,"campaign",[]] call TYR_fnc_RecordGet;
if !(_campaign isEqualType []) exitWith {false};
if (([_campaign,"world",""] call TYR_fnc_RecordGet) isNotEqualTo worldName) exitWith {false};
private _campaignId = [_campaign,"id",""] call TYR_fnc_RecordGet;
private _nextId = [_campaign,"nextId",0] call TYR_fnc_RecordGet;
if !(_campaignId isEqualType "" && {_campaignId isNotEqualTo ""}) exitWith {false};
if !(_nextId isEqualType 0 && {_nextId >= 1}) exitWith {false};
if !(([_campaign,"settings",[]] call TYR_fnc_RecordGet) isEqualType []) exitWith {false};
private _phase = [_campaign,"phase","deployment"] call TYR_fnc_RecordGet;
if !(_phase in ["deployment","running"]) exitWith {false};
private _dep = [_campaign,"deployment",[]] call TYR_fnc_RecordGet;
private _depSectors = [_dep,"sectors",[]] call TYR_fnc_RecordGet;
if !(_dep isEqualType [] && {_depSectors isEqualType []}) exitWith {false};
private _depRotation = [_dep,"rotation",-1] call TYR_fnc_RecordGet;
private _depBuffer = [_dep,"buffer",-1] call TYR_fnc_RecordGet;
if !(_depRotation isEqualType 0 && {_depBuffer isEqualType 0} && {_depBuffer >= 0}) exitWith {false};

private _knownFactions = ["west","east","independent"];
private _factions = [_snapshot,"factions",[]] call TYR_fnc_RecordGet;
if !(_factions isEqualType [] && {count _factions isEqualTo 3}) exitWith {false};
private _factionIds = _factions apply {[_x,"id",""] call TYR_fnc_RecordGet};
if !([_factionIds] call _unique) exitWith {false};
if !((_knownFactions findIf {!(_x in _factionIds)}) < 0) exitWith {false};
private _researchKeys = (call TYR_fnc_GetResearchDefinitions) apply {_x # 0};
if ((_factions findIf {
    private _id = [_x,"id",""] call TYR_fnc_RecordGet;
    private _active = [_x,"active",false] call TYR_fnc_RecordGet;
    private _eliminated = [_x,"eliminated",false] call TYR_fnc_RecordGet;
    private _controller = [_x,"controller",""] call TYR_fnc_RecordGet;
    private _base = [_x,"basePosition",[]] call TYR_fnc_RecordGet;
    private _confirmed = [_x,"baseConfirmed",false] call TYR_fnc_RecordGet;
    private _resources = [_x,"resources",[]] call TYR_fnc_RecordGet;
    private _research = [_x,"research",[]] call TYR_fnc_RecordGet;
    private _targets = [_x,"vlsTargets",[]] call TYR_fnc_RecordGet;
    private _pool = [_x,"vehiclePool",[]] call TYR_fnc_RecordGet;
    private _badResource = ["steel","ammo","fuel","manpower"] findIf {
        private _n = [_resources,_x,-1] call TYR_fnc_RecordGet;
        !(_n isEqualType 0) || {_n < 0}
    };
    !(_id in _knownFactions) ||
    {!(_active isEqualType true)} ||
    {!(_eliminated isEqualType true)} ||
    {!(_controller in ["human","ai","disabled"])} ||
    {!(_confirmed isEqualType true)} ||
    {_confirmed && {!([_base] call _validLandPos)}} ||
    {_phase isEqualTo "running" && {_active} && {!_confirmed}} ||
    {_badResource >= 0} ||
    {!(_research isEqualType [])} ||
    {(_research findIf {!(_x in _researchKeys)}) >= 0} ||
    {!(_targets isEqualType []) || {count _targets > 18} || {(_targets findIf {!([_x] call _validPos)}) >= 0}} ||
    {!(_pool isEqualType []) || {(_pool findIf {!(_x isEqualType "")}) >= 0}}
}) >= 0) exitWith {false};
private _activeFactionIds = (_factions select {[_x,"active",false] call TYR_fnc_RecordGet}) apply {[_x,"id",""] call TYR_fnc_RecordGet};
if ((_activeFactionIds findIf {private _fid=_x; (_depSectors findIf {(_x # 0) isEqualTo _fid && {(_x # 1) isEqualType [] && {count (_x # 1) >= 2}}}) < 0}) >= 0) exitWith {false};

private _locations = [_snapshot,"locations",[]] call TYR_fnc_RecordGet;
if !(_locations isEqualType []) exitWith {false};
private _locationIds = _locations apply {[_x,"id",""] call TYR_fnc_RecordGet};
if !([_locationIds] call _unique) exitWith {false};
if ((_locations findIf {
    private _owner = [_x,"owner","neutral"] call TYR_fnc_RecordGet;
    private _stock = [_x,"stock",0] call TYR_fnc_RecordGet;
    !(_owner in (["neutral"] + _knownFactions)) || {!(_stock isEqualType 0)} || {_stock < 0}
}) >= 0) exitWith {false};

private _players = [_snapshot,"players",[]] call TYR_fnc_RecordGet;
if !(_players isEqualType []) exitWith {false};
private _playerIds = _players apply {[_x,"uid",""] call TYR_fnc_RecordGet};
if !([_playerIds] call _unique) exitWith {false};
if ((_players findIf {
    private _fid = [_x,"faction",""] call TYR_fnc_RecordGet;
    private _pos = [_x,"position",[]] call TYR_fnc_RecordGet;
    private _dir = [_x,"direction",0] call TYR_fnc_RecordGet;
    private _loadout = [_x,"loadout",[]] call TYR_fnc_RecordGet;
    !(_fid in _knownFactions) || {!([_pos] call _validPos)} || {!(_dir isEqualType 0)} || {!(_loadout isEqualType [])}
}) >= 0) exitWith {false};

private _vehicles = [_snapshot,"vehicles",[]] call TYR_fnc_RecordGet;
if !(_vehicles isEqualType []) exitWith {false};
private _vehicleIds = _vehicles apply {[_x,"id",""] call TYR_fnc_RecordGet};
if !([_vehicleIds] call _unique) exitWith {false};
if ((_vehicles findIf {
    private _fid = [_x,"faction",""] call TYR_fnc_RecordGet;
    private _class = [_x,"class",""] call TYR_fnc_RecordGet;
    private _pos = [_x,"position",[]] call TYR_fnc_RecordGet;
    private _damage = [_x,"damage",-1] call TYR_fnc_RecordGet;
    private _fuel = [_x,"fuel",-1] call TYR_fnc_RecordGet;
    private _ammo = [_x,"ammo",-1] call TYR_fnc_RecordGet;
    !(_fid in _knownFactions) || {_class isEqualTo ""} || {!([_pos] call _validPos)} ||
    {!(_damage isEqualType 0 && {_damage >= 0} && {_damage <= 1.1})} ||
    {!(_fuel isEqualType 0 && {_fuel >= 0} && {_fuel <= 1.1})} ||
    {!(_ammo isEqualType 0 && {_ammo >= 0} && {_ammo <= 1.1})}
}) >= 0) exitWith {false};

private _emplacements = [_snapshot,"emplacements",[]] call TYR_fnc_RecordGet;
if !(_emplacements isEqualType []) exitWith {false};
private _emplacementIds = _emplacements apply {[_x,"id",""] call TYR_fnc_RecordGet};
if !([_emplacementIds] call _unique) exitWith {false};
private _emplacementKeys = (call TYR_fnc_GetEmplacementDefinitions) apply {_x # 0};
if ((_emplacements findIf {
    private _fid = [_x,"faction",""] call TYR_fnc_RecordGet;
    private _key = [_x,"key",""] call TYR_fnc_RecordGet;
    private _class = [_x,"class",""] call TYR_fnc_RecordGet;
    private _pos = [_x,"position",[]] call TYR_fnc_RecordGet;
    !(_fid in _knownFactions) || {!(_key in _emplacementKeys)} || {_class isEqualTo ""} || {!([_pos] call _validPos)}
}) >= 0) exitWith {false};

private _forces = [_snapshot,"forces",[]] call TYR_fnc_RecordGet;
if !(_forces isEqualType []) exitWith {false};
private _forceIds = _forces apply {[_x,"id",""] call TYR_fnc_RecordGet};
if !([_forceIds] call _unique) exitWith {false};
if ((_forces findIf {
    private _fid = [_x,"faction",""] call TYR_fnc_RecordGet;
    private _pos = [_x,"position",[]] call TYR_fnc_RecordGet;
    private _classes = [_x,"unitClasses",[]] call TYR_fnc_RecordGet;
    private _operation = [_x,"operation",""] call TYR_fnc_RecordGet;
    !(_fid in _knownFactions) || {!([_pos] call _validPos)} || {!(_classes isEqualType [])} ||
    {(_classes findIf {!(_x isEqualType "")}) >= 0} || {!(_operation isEqualType "")}
}) >= 0) exitWith {false};

private _operations = [_snapshot,"operations",[]] call TYR_fnc_RecordGet;
if !(_operations isEqualType []) exitWith {false};
private _operationIds = _operations apply {[_x,"id",""] call TYR_fnc_RecordGet};
if !([_operationIds] call _unique) exitWith {false};
if ((_operations findIf {
    private _fid = [_x,"faction",""] call TYR_fnc_RecordGet;
    private _target = [_x,"target",""] call TYR_fnc_RecordGet;
    private _assigned = [_x,"forces",[]] call TYR_fnc_RecordGet;
    !(_fid in _knownFactions) || {!(_target in _locationIds)} || {!(_assigned isEqualType [])} ||
    {(_assigned findIf {!(_x in _forceIds)}) >= 0}
}) >= 0) exitWith {false};

private _destroyed = [_snapshot,"destroyedBuildings",[]] call TYR_fnc_RecordGet;
if !(_destroyed isEqualType []) exitWith {false};
if ((_destroyed findIf {!(_x isEqualType "")}) >= 0) exitWith {false};

true
