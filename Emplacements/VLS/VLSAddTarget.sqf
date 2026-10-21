private _targets = GameData # 0 # (Pside + 1) param [6, []];
if (count _targets >= 18) exitWith {hint "Maximum of 18 stored targets."};
closeDialog 0;
TYR_vlsTargetChosen = false;
TYR_vlsTargetPosition = [0,0,0];
openMap [true, false];
hint "Select a VLS target location.";
onMapSingleClick {
    TYR_vlsTargetPosition = _pos;
    TYR_vlsTargetChosen = true;
    onMapSingleClick "";
};
waitUntil {sleep 0.1; TYR_vlsTargetChosen};
openMap [false, false];
[TYR_vlsTargetPosition] remoteExecCall ["TYR_fnc_ServerAddVLSTarget", 2];
