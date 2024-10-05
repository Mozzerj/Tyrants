// Extract Points and Calculate Regression Line

GraphPoints = [];
{
	_regionType = _x;
	{
		GraphPoints pushBack (_x # 4); // Extract position (coordinates) for each region or factory
	} forEach _regionType;
} forEach (GameData # 1);

n = count GraphPoints;
Ex = 0; Ey = 0; Exy = 0; Ex2 = 0;

// Calculate necessary sums for linear regression
{
	_xVal = _x # 0; _yVal = _x # 1;
	Ex = Ex + _xVal;
	Ey = Ey + _yVal;
	Exy = Exy + (_xVal * _yVal);
	Ex2 = Ex2 + (_xVal * _xVal);
} forEach GraphPoints;

// Linear regression formula to calculate slope (m) and intercept (b)
m = (((n * Exy) - (Ex * Ey)) / (n * Ex2 - Ex ^ 2));
b = ((Ey - m * Ex) / n);

// Calculate y-values at x=0 and x=worldSize for the regression line
y0 = (m * 0) + b;
y1 = (m * worldSize) + b;

// Calculate angle of the dividing line
_angleDeg = ((y1 - y0) atan2 worldSize) * -1;

// Create red and blue markers for visual divider
_markerPosY = ((y1 + y0) / 2);
divederMarker = createMarkerLocal ["divederMarker1", [(worldSize/2), _markerPosY + 30]];
divederMarker setMarkerTypeLocal "mil_box";
divederMarker setMarkerColorLocal "ColorRED";
divederMarker setMarkerSizeLocal [0.75, 200];
divederMarker setMarkerAlphaLocal 0.5;
divederMarker setMarkerDirLocal (_angleDeg + 90);

divederMarker1 = createMarkerLocal ["divederMarker12", [(worldSize/2), _markerPosY - 30]];
divederMarker1 setMarkerTypeLocal "mil_box";
divederMarker1 setMarkerColorLocal "ColorBLUE";
divederMarker1 setMarkerSizeLocal [0.75, 200];
divederMarker1 setMarkerAlphaLocal 0.5;
divederMarker1 setMarkerDirLocal (_angleDeg + 90);

execVM "Setup\player\playerBaseSetup.sqf";