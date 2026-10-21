params ["_mode"];
disableSerialization;
private _d = findDisplay 1204;
if (isNull _d) exitWith {};
private _cover = _d displayCtrl 11;
private _launch = _d displayCtrl 10;
private _hint = _d displayCtrl 14;
if (_mode isEqualTo 0) exitWith {
    private _open = !(missionNamespace getVariable ["TYR_vlsCoverOpen",false]);
    missionNamespace setVariable ["TYR_vlsCoverOpen",_open];
    if (_open) then {
        _cover ctrlSetText "CLOSE SAFETY COVER";
        _cover ctrlSetPosition [safeZoneX+safeZoneW*0.055,safeZoneY+safeZoneH*0.685,safeZoneW*0.22,safeZoneH*0.035];
        _cover ctrlCommit 0.22;
        _launch ctrlEnable true;
        _hint ctrlSetText "Safety open. Launch control armed.";
    } else {
        _cover ctrlSetText "OPEN SAFETY COVER";
        _cover ctrlSetPosition [safeZoneX+safeZoneW*0.055,safeZoneY+safeZoneH*0.685,safeZoneW*0.22,safeZoneH*0.16];
        _cover ctrlCommit 0.22;
        _launch ctrlEnable false;
        _hint ctrlSetText "Safety closed.";
    };
};
if !(missionNamespace getVariable ["TYR_vlsCoverOpen",false]) exitWith {};
private _id = missionNamespace getVariable ["TYR_vlsEmplacementId",""];
private _selectedTarget = lbCurSel (_d displayCtrl 1);
if (_selectedTarget < 0) then {_selectedTarget = 0};
if (_id isNotEqualTo "") then {[_id,_selectedTarget] remoteExecCall ["TYR_fnc_ServerLaunchVLS",2]};
missionNamespace setVariable ["TYR_vlsCoverOpen",false];
_cover ctrlSetText "OPEN SAFETY COVER";
_cover ctrlSetPosition [safeZoneX+safeZoneW*0.055,safeZoneY+safeZoneH*0.685,safeZoneW*0.22,safeZoneH*0.16];
_cover ctrlCommit 0.22;
_launch ctrlEnable false;
_hint ctrlSetText "Launch requested. Safety re-engaged.";
