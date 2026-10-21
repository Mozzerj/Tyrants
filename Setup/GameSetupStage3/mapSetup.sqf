private _divider = [] call TYR_fnc_GetDividerLine;
TYR_dividerSlope = _divider # 0;
TYR_dividerIntercept = _divider # 1;

private _y0 = TYR_dividerIntercept;
private _y1 = (TYR_dividerSlope * worldSize) + TYR_dividerIntercept;
private _angleDeg = ((_y1 - _y0) atan2 worldSize) * -1;
private _markerPosY = (_y1 + _y0) / 2;

deleteMarkerLocal "TYR_dividerNorth";
deleteMarkerLocal "TYR_dividerSouth";

private _dividerNorth = createMarkerLocal ["TYR_dividerNorth", [worldSize / 2, _markerPosY + 30]];
_dividerNorth setMarkerTypeLocal "mil_box";
_dividerNorth setMarkerColorLocal "ColorRED";
_dividerNorth setMarkerSizeLocal [0.75, 200];
_dividerNorth setMarkerAlphaLocal 0.5;
_dividerNorth setMarkerDirLocal (_angleDeg + 90);

private _dividerSouth = createMarkerLocal ["TYR_dividerSouth", [worldSize / 2, _markerPosY - 30]];
_dividerSouth setMarkerTypeLocal "mil_box";
_dividerSouth setMarkerColorLocal "ColorBLUE";
_dividerSouth setMarkerSizeLocal [0.75, 200];
_dividerSouth setMarkerAlphaLocal 0.5;
_dividerSouth setMarkerDirLocal (_angleDeg + 90);
