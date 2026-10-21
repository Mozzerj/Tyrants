params ["_asset"];
if (!isServer || {isNull _asset}) exitWith {};
private _ownerId = remoteExecutedOwner;
private _caller = [_ownerId] call TYR_fnc_FindPlayerByOwner;
if (isNull _caller) exitWith {};
private _sideIndex = [west, east] find (side _caller);
if (_sideIndex < 0) exitWith {};
if ((_asset getVariable ["TYR_sideIndex", -1]) isNotEqualTo _sideIndex) exitWith {};
if ((_asset getVariable ["TYR_emplacementKey", ""]) isNotEqualTo "vls") exitWith {};
if (_caller distance2D _asset > 20) exitWith {["Move closer to the VLS to launch."] remoteExecCall ["TYR_fnc_ClientHint", _ownerId];};

private _recordIndex = (GameData # 5 # _sideIndex) findIf {(_x # 2) isEqualTo _asset};
if (_recordIndex < 0) exitWith {};
private _record = GameData # 5 # _sideIndex # _recordIndex;
private _ammo = _record # 5;
private _targets = +(GameData # 0 # (_sideIndex + 1) param [6, []]);
if (_targets isEqualTo []) exitWith {["No VLS targets are stored."] remoteExecCall ["TYR_fnc_ClientHint", _ownerId];};
if (_ammo <= 0) exitWith {["The VLS has no missiles remaining."] remoteExecCall ["TYR_fnc_ClientHint", _ownerId];};

private _launchCount = _ammo min (count _targets);
_record set [5, _ammo - _launchCount];
(GameData # 5 # _sideIndex) set [_recordIndex, _record];
[] call TYR_fnc_ServerBroadcastState;
[] call TYR_fnc_ServerSaveState;
[format ["Launch authorised: %1 cruise missile(s).", _launchCount]] remoteExecCall ["TYR_fnc_ClientHint", _ownerId];

[_asset, _targets select [0, _launchCount], _sideIndex] spawn {
    params ["_vls", "_launchTargets", "_launchSideIndex"];
    {
        if (isNull _vls || {!alive _vls}) exitWith {};
        [_vls, _x, _launchSideIndex] spawn TYR_fnc_CruiseMissileLaunch;
        sleep 1;
    } forEach _launchTargets;
};
