params ["_prefix"];
if (!isServer || {isNil "TYR_State"}) exitWith {""};
private _campaign = TYR_State get "campaign";
private _next = _campaign getOrDefault ["nextId", 1];
_campaign set ["nextId", _next + 1];
[format ["id:%1", _prefix]] call TYR_fnc_StateMarkDirty;
format ["%1_%2", _prefix, _next]
