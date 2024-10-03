_OverlayBackground = (findDisplay 46) displayCtrl 3000;
_OverlayHeader = (findDisplay 46) displayCtrl 3001;


captureTime = 90;


RegionUpdate = {
	
	{
		
		_regionType = _x;
		_regionID = _forEachIndex; 
		{
			
			_region = _x;
			{

				_regionPos = (_region # 4); 
				
				CountEast = 0;
				CountWest = 0;
				
				if ((((getPos player) distance (_regionPos)) < 250) && ((_region # 3) != Pcolor)) then {

                    lbClear _OverlayBackground;

                    _OverlayHeader ctrlSetBackgroundColor PlayerOverlayColor;
                    _OverlayBackground ctrlSetBackgroundColor [0,0,0,0.7];

                    for "_i" from 0 to captureTime do { // change capture time to game data settings
                        
                        if  (((getPos player) distance (_regionPos)) > 250) exitWith {

                            _OverlayHeader ctrlSetBackgroundColor PlayerOverlayColor;
                            _OverlayBackground ctrlSetBackgroundColor [0,0,0,0.7];

                            _OverlayBackground lbAdd "";
                            _OverlayBackground lbAdd ("Moved too far");

                            sleep 2;

                            lbClear _OverlayBackground;
                            _OverlayHeader ctrlSetBackgroundColor [0,0,0,0];
                            _OverlayBackground ctrlSetBackgroundColor [0,0,0,0];

                        };

                        _OverlayBackground lbAdd "";
                        _OverlayBackground lbAdd format["Capture in: %1", (captureTime - _i)];

                        sleep 1;

                        lbClear _OverlayBackground;
                    };

                    if  (((getPos player) distance (_regionPos)) < 250) then {
                        
                        _OverlayBackground lbAdd "";
                        _OverlayBackground lbAdd ("Captured");

                        sleep 2;

                        lbClear _OverlayBackground;
                        _OverlayHeader ctrlSetBackgroundColor [0,0,0,0];
                        _OverlayBackground ctrlSetBackgroundColor [0,0,0,0];

                        _RegionEntities = nearestObjects [_regionPos, ["man","car","tank"], 250];
                        
                        {
                        
                            if ((str (side _x)) == ("EAST")) then {CountEast = CountEast + 1};
                            if ((str (side _x)) == ("WEST")) then {CountWest = CountWest + 1};
                            
                        }forEach _RegionEntities;
                        
                        if ((CountEast > CountWest) && (PColor == "ColorEAST")) then {
                            
                            if ((_region select 3) == "ColorWEST") then {_region set [1, "ColorEAST"]};
                            _region set [2, "ColorEAST"];
                            _region set [3, "ColorEAST"];
                        
                        };
                        
                        if ((CountWest > CountEast) && (PColor == "ColorWEST")) then {
                            
                            if ((_region select 3) == "ColorEAST") then {_region set [2, "ColorWEST"]};
                            _region set [1, "ColorWEST"];
                            _region set [3, "ColorWEST"];
                        
                        };

                    };
					
				};
				
			}forEach _region;	
		
		_regionType set [_forEachIndex, _region];
		//e.g[[Town],[Town],[Town]]
		}forEach _regionType;
		
		(GameData select 1) set [_forEachIndex, _regionType];
	//[allTowns,allCity,allFactories]
	}forEach (GameData select 1);
	
	publicVariable "GameData";
};

call RegionUpdate;

while {True} do {

	call RegionUpdate;

	sleep (5);


};