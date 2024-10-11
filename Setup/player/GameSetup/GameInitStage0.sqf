_zonePos = getPosATL initZone;
cameraPos = [(_zonePos select 0) - 16, (_zonePos select 1) + 15, (_zonePos select 2) + 5];
camera = "CAMERA" camCreate cameraPos;
camera cameraEffect ["Internal", "Back"];
camera camSetTarget _zonePos;
camera camCommit 0;

player disableAI "MOVE";
