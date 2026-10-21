params ["_position"];
if (!isServer) exitWith {};
private _owner = remoteExecutedOwner;
private _player = [_owner] call TYR_fnc_FindPlayerByOwner;
if (isNull _player) exitWith {};
private _fid = [side _player] call TYR_fnc_SideFaction;
private _campaign = TYR_State get "campaign";
if ((_campaign getOrDefault ["phase","deployment"]) isNotEqualTo "deployment") exitWith {};
private _f = [_fid] call TYR_fnc_StateGetFaction;
if (count _f isEqualTo 0 || {!(_f getOrDefault ["active",false])}) exitWith {};
if ((_f getOrDefault ["controller","human"]) isNotEqualTo "human") exitWith {
    [_player,"TYR_fnc_ClientHint",["This faction's strategic controller is AI; its HQ is selected automatically."]] call TYR_fnc_ServerSendToPlayer;
};
if (_f getOrDefault ["baseConfirmed",false]) exitWith {
    [_player,"TYR_fnc_ClientHint",["Your faction HQ has already been confirmed."]] call TYR_fnc_ServerSendToPlayer;
};
private _deployment = _campaign get "deployment";
private _sector = (_deployment get "sectors") getOrDefault [_fid,[]];
private _check = [_position,_sector,_deployment getOrDefault ["buffer",2500]] call TYR_fnc_DeploymentCheckPosition;
if !(_check # 0) exitWith {[_player,"TYR_fnc_ClientHint",[format ["HQ rejected: %1",_check # 1]]] call TYR_fnc_ServerSendToPlayer};
_f set ["basePosition",[_position # 0,_position # 1,0]];
_f set ["baseConfirmed",true];
["human-hq-confirmed",true] call TYR_fnc_StateMarkDirty;
call TYR_fnc_ServerPublishDeployment;
call TYR_fnc_ServerFinalizeDeployment;
