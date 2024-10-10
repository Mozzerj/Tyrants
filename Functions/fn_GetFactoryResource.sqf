{

    if ((((getPos player) distance (_x # 4)) < 75) and (Pcolor == _x # 3)) then {

        _OverlayBackground = (findDisplay 46) displayCtrl 3000;
        _OverlayHeader = (findDisplay 46) displayCtrl 3001;

        _OverlayHeader ctrlSetBackgroundColor PlayerOverlayColor;
        _OverlayBackground ctrlSetBackgroundColor [0,0,0,0.7];

        for "_i" from 0 to 30 do { // change capture time to game data settings
                        
            if  (((getPos player) distance (_x # 4)) > 75) exitWith {


                _OverlayBackground lbAdd "";
                _OverlayBackground lbAdd ("Moved too far");

                sleep 2;

                lbClear _OverlayBackground;
                _OverlayHeader ctrlSetBackgroundColor [0,0,0,0];
                _OverlayBackground ctrlSetBackgroundColor [0,0,0,0];

            };

            _OverlayBackground lbAdd "";
            _OverlayBackground lbAdd format["Collected in: %1", (30 - _i)];

            sleep 1;

            lbClear _OverlayBackground;

        };
        if  (((getPos player) distance (_x # 4)) < 75) exitWith {
            
            _OverlayBackground lbAdd "";
            _OverlayBackground lbAdd ("Resources Collected");

            switch (_x # 7) do {
                case "Steel": {FType = 1};
                case "Ammo": {FType = 2};
                case "Fuel": {FType = 3};
            };

            gameData # 0 # (pside + 1) set[FType, (gameData # 0 # (pside + 1) # FType) + _x # 6];
            gameData # 1 # 2 # _forEachindex set [6,0];
            publicVariable "gameData";

            sleep 2;

            lbClear _OverlayBackground;
            
            _OverlayHeader ctrlSetBackgroundColor [0,0,0,0];
            _OverlayBackground ctrlSetBackgroundColor [0,0,0,0];
        };

    };


}forEach gameData # 1 # 2;