private _markers = missionNamespace getVariable ["TYR_DeploymentOverlayMarkers",[]];
{
    if (_x isEqualType "" && {_x isNotEqualTo ""}) then {deleteMarkerLocal _x};
} forEach _markers;
missionNamespace setVariable ["TYR_DeploymentOverlayMarkers",[]];
missionNamespace setVariable ["TYR_DeploymentOverlayCount",0];

private _placementMarkers = missionNamespace getVariable ["TYR_DeploymentPlacementMarkers",[]];
{
    if (_x isEqualType "" && {_x isNotEqualTo ""}) then {deleteMarkerLocal _x};
} forEach _placementMarkers;
missionNamespace setVariable ["TYR_DeploymentPlacementMarkers",[]];
true
