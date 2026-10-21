params ["_box","_factionId"];
if (isNull _box || {_box getVariable ["TYR_arsenalActionAttached",false]}) exitWith {};
_box setVariable ["TYR_arsenalActionAttached",true];
_box addAction [
    "Open Arsenal",
    {[] remoteExecCall ["TYR_fnc_ServerBeginArsenal",2]},
    nil,1.5,true,true,"",
    "(missionNamespace getVariable ['TYR_PlayerFaction','']) isEqualTo (_target getVariable ['TYR_baseFaction',''])",
    10
];
