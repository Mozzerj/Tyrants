_zonePos = getPosATL initZone;
cameraPos = [(_zonePos select 0) - 16, (_zonePos select 1) + 15, (_zonePos select 2) + 5];
camera = "CAMERA" camCreate cameraPos;
camera cameraEffect ["Internal", "Back"];
camera camSetTarget _zonePos;
camera camCommit 0;

player disableAI "MOVE";

waitUntil {isNull (findDisplay 46)};
waitUntil {gameData # 1 isNotEqualTo 0};

sleep 0.5;

waitUntil {gameData # 0 # 0 # 0 == 3};

camera cameraEffect ["terminate","back"];
camDestroy camera;


switch (player) do {
    case commanderEast: { 
        execVM "Setup\GameSetupStage3\mapSetup.sqf";
        execVM "Setup\GameSetupPlayer\BaseSetup.sqf";

    };
    case commanderWest: { 

        execVM "Setup\GameSetupStage3\mapSetup.sqf";
        execVM "Setup\GameSetupPlayer\BaseSetup.sqf";

    };
    default {[1, "BLACK", 3, 1] spawn BIS_fnc_fadeEffect; };
};

waitUntil {GameData # 0 # 1 # 0 isNotEqualTo 0};
waitUntil {GameData # 0 # 2 # 0 isNotEqualTo 0};

sleep 5;

switch (side player) do {
    case west: { 

        player setPos GameData # 0 # 1 # 0;
        [1, "BLACK", 3, 1] spawn BIS_fnc_fadeEffect;
    };
    case east: { 
        
        player setPos GameData # 0 # 2 # 0;
        [1, "BLACK", 3, 1] spawn BIS_fnc_fadeEffect;
    };
    default { };
};