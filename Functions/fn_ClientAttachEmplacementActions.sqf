params ["_asset", "_key", "_sideIndex"];
if (!hasInterface || {isNull _asset}) exitWith {};
if (_key isNotEqualTo "vls") exitWith {};
if (isNil "Pside" || {Pside isNotEqualTo _sideIndex}) exitWith {};
if (_asset getVariable ["TYR_actionAttached", false]) exitWith {};
_asset setVariable ["TYR_actionAttached", true];
_asset addAction [
    "Open Targeting System",
    {
        params ["_target"];
        missionNamespace setVariable ["TYR_activeVLS", _target];
        [] execVM "Emplacements\VLS\VLSMenu.sqf";
    },
    nil,
    6,
    true,
    true,
    "",
    "alive _target",
    10
];
