params ["_factionId"];
if (!isServer) exitWith {false};
private _f = [_factionId] call TYR_fnc_StateGetFaction;
if (count _f isEqualTo 0 || {!(_f getOrDefault ["active",false])} || {_f getOrDefault ["eliminated",false]}) exitWith {false};
private _network = _f getOrDefault ["commandNetwork",createHashMap];
if (count _network isEqualTo 0) then {
    _network = createHashMapFromArray [
        ["status","forming"],["main",""],["officers",[]],["targetOfficers",3],
        ["successionAt",-1],["replacementAt",-1],["collapseSince",-1],
        ["lastLossAt",-1],["lastStatusChange",serverTime]
    ];
    _f set ["commandNetwork",_network];
};
private _personnel = TYR_State getOrDefault ["commandPersonnel",createHashMap];
private _created = false;
private _mainId = _network getOrDefault ["main",""];
private _officers = +(_network getOrDefault ["officers",[]]);

if (_mainId isEqualTo "" && {count _officers isEqualTo 0}) then {
    private _names = switch (_factionId) do {
        case "west": {["GEN MASON","COL HAYES","MAJ CROSS","CAPT WARD"]};
        case "east": {["GEN SOKOLOV","COL VOLKOV","MAJ ORLOV","CAPT MOROZOV"]};
        default {["GEN STAVROU","COL KYROS","MAJ NIKAS","CAPT ALEXIOU"]};
    };
    private _base = _f getOrDefault ["basePosition",[]];
    private _offsets = [[0,8,0],[-8,0,0],[8,0,0],[0,-8,0]];
    for "_i" from 0 to 3 do {
        private _id = ["cmd"] call TYR_fnc_StateNextId;
        private _role = if (_i isEqualTo 0) then {"commander"} else {"officer"};
        private _rank = [100,80,70,60] # _i;
        private _o = _offsets # _i;
        private _pos = if (count _base >= 2) then {[(_base # 0)+(_o # 0),(_base # 1)+(_o # 1),0.2]} else {[]};
        _personnel set [_id,createHashMapFromArray [
            ["id",_id],["faction",_factionId],["role",_role],["name",_names # _i],
            ["rank",_rank],["alive",true],["position",_pos],["class",""],
            ["createdAt",serverTime],["deathAt",-1]
        ]];
        if (_i isEqualTo 0) then {_mainId = _id} else {_officers pushBack _id};
    };
    _network set ["main",_mainId];
    _network set ["officers",_officers];
    _network set ["status","forming"];
    _network set ["lastStatusChange",serverTime];
    _created = true;
};

{
    private _rec = _personnel getOrDefault [_x,createHashMap];
    if (count _rec > 0 && {_rec getOrDefault ["alive",false]}) then {[_x] call TYR_fnc_ServerCommandSpawnPerson};
} forEach ([_mainId] + _officers);
if (_created) then {["command-network-created",true] call TYR_fnc_StateMarkDirty};
true
