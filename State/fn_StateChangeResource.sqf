params ["_factionId", "_resource", "_delta", ["_reason", "resource"]];
if (!isServer) exitWith {false};
private _faction = [_factionId] call TYR_fnc_StateGetFaction;
if (count _faction isEqualTo 0 || {!(_faction getOrDefault ["active", false])}) exitWith {false};
private _resources = _faction get "resources";
if !(_resource in ["steel","ammo","fuel","manpower"]) exitWith {false};
private _old = _resources getOrDefault [_resource, 0];
private _new = (_old + _delta) max 0;
_resources set [_resource, _new];
[_reason] call TYR_fnc_StateMarkDirty;
[_factionId] call TYR_fnc_ServerPublishFaction;
true
