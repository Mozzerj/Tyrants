_zonePos = getPosATL initZone;
_cameraPos = [(_zonePos select 0) - 16, (_zonePos select 1) + 15, (_zonePos select 2) + 5];
_camera = "CAMERA" camCreate _cameraPos;
_camera cameraEffect ["Internal", "Back"];
_camera camSetTarget _zonePos;
_camera camCommit 0;

player disableAI "MOVE";
