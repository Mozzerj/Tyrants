params ["_emplacementId","_targets","_ammo"];
missionNamespace setVariable ["TYR_vlsTargets",+_targets];
if (_emplacementId isNotEqualTo "") then {missionNamespace setVariable ["TYR_vlsEmplacementId",_emplacementId]};
if (_ammo >= 0) then {missionNamespace setVariable ["TYR_vlsAmmo",_ammo]};
if (!isNull findDisplay 1204) then {[] call TYR_fnc_VLSMenuRefresh};
