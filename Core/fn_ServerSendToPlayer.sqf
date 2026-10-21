params ["_player","_function",["_arguments",[]]];
if (!isServer || {isNull _player} || {!(_function isEqualType "")}) exitWith {};
if (local _player && {hasInterface}) then {
    private _fn = missionNamespace getVariable [_function,{}];
    _arguments call _fn;
} else {
    _arguments remoteExecCall [_function,_player];
};
