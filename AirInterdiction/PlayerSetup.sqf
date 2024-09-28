_randomAngle = random 360;

_Dimension = worldSize/2;

_CentrePos = [_Dimension,_Dimension];

_offsetX = (_Dimension) * cos(_randomAngle);
_offsetY = (_Dimension) * sin(_randomAngle);

_newPos = [
    (_CentrePos select 0) + _offsetX,  
    (_CentrePos select 1) + _offsetY,  
    500                              
];

_plane = selectRandom ["B_Plane_Fighter_01_F","B_Plane_Fighter_01_Stealth_F","O_Plane_Fighter_02_F","O_Plane_Fighter_02_Stealth_F","I_Plane_Fighter_03_AA_F","I_Plane_Fighter_04_F"];

_plane = createVehicle [_plane, _newPos, [], 0, "FLY"];

player moveInAny _plane;
