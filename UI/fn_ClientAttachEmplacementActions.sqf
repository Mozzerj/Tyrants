params ["_obj","_key","_factionId"];
if (isNull _obj || {_key isNotEqualTo "vls"}) exitWith {};
if (isNil "TYR_PlayerFaction" || {TYR_PlayerFaction isNotEqualTo _factionId}) exitWith {};
if (_obj getVariable ["TYR_vlsActionAttached",false]) exitWith {};
_obj setVariable ["TYR_vlsActionAttached",true];
_obj addAction ["Open VLS Launch Control",{params ["_target"];[_target] call TYR_fnc_OpenVLSMenu},nil,1.5,true,true,"","_this distance _target < 25",25];
