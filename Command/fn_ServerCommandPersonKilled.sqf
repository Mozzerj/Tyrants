params ["_personId",["_unit",objNull]];
if (!isServer || {_personId isEqualTo ""}) exitWith {};
private _personnel = TYR_State getOrDefault ["commandPersonnel",createHashMap];
private _rec = _personnel getOrDefault [_personId,createHashMap];
if (count _rec isEqualTo 0 || {!(_rec getOrDefault ["alive",false])}) exitWith {};
_rec set ["alive",false];
_rec set ["deathAt",serverTime];
if (!isNull _unit) then {_rec set ["position",getPosATL _unit]};
private _fid = _rec getOrDefault ["faction",""];
private _network = [_fid] call TYR_fnc_CommandNetworkGet;
if (count _network > 0) then {
    _network set ["lastLossAt",serverTime];
    if ((_rec getOrDefault ["role",""]) isEqualTo "commander") then {
        _network set ["successionAt",serverTime + 30];
    };
};
["command-person-killed",true] call TYR_fnc_StateMarkDirty;
if (_fid isNotEqualTo "") then {[_fid] call TYR_fnc_ServerPublishFaction};
diag_log format ["[TYRANTS COMMAND] %1 %2 killed (%3).",toUpper _fid,_rec getOrDefault ["name",_personId],_rec getOrDefault ["role",""]];
