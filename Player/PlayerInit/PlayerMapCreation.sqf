_map = findDisplay 12;
_mapCtrl = _map displayCtrl 51;
marks = [];
ctrlCount = 0;
MapLB = missionConfigFile >> "myMissionConfig" >> "RscMapListbox";

waitUntil {!isNull (findDisplay 46)};


// create player overlay on screen to display capture time or mission info
_OverlayBackground = (findDisplay 46) ctrlCreate [MapLB, (3000)];// id 3000 - 3999 for player overaly ctrls
_OverlayHeader = (findDisplay 46) ctrlCreate ["RscText", (3001)];

_OverlayBackground ctrlSetPosition [(safeZoneX + safeZoneW * 0.45),(safeZoneY + safeZoneH * 0.01), 0.2,  0.12];
_OverlayHeader ctrlSetPosition [(safeZoneX + safeZoneW * 0.45),(safeZoneY + safeZoneH * 0.01), 0.2, 0.025];

_OverlayBackground ctrlCommit 0;
_OverlayHeader ctrlCommit 0;

_OverlayBackground ctrlSetBackgroundColor [0,0,0,0];
_OverlayHeader ctrlSetBackgroundColor [0,0,0,0];

//(findDisplay 12) displayCtrl 3001

CreateTownInfo = {
    params["_map","_mapCtrl","_pos"];



    _BackGround = _map ctrlCreate [MapLB, (ctrlCount + 2000)]; // id 2000 - 2999 for map ctrls
    ctrlCount = ctrlCount + 1;

    _Header = _map ctrlCreate ["RscText", (ctrlCount + 2000)];
    ctrlCount = ctrlCount + 1;

    _Pos = _Pos vectorAdd [0,-20,0];
    _screenPos = _mapCtrl ctrlMapWorldToScreen _Pos; 

    _BackGround ctrlSetPosition [_screenPos select 0, _screenPos select 1, 0.15,  0.12];
    _Header ctrlSetPosition [_screenPos select 0, _screenPos select 1, 0.15, 0.025];

    _BackGround ctrlCommit 0;
    _Header ctrlCommit 0;

    _Header ctrlSetBackgroundColor [0.851,0.5647,0.0863,1];
    _BackGround ctrlSetBackgroundColor [0,0,0,0.7];

    marks pushBack [_Header,_BackGround, _pos];

};

UpdateMarks = {
    params["_Header","_Background","_Pos"];

    _map = findDisplay 12;
    _mapCtrl = _map displayCtrl 51;

    _Pos = _Pos vectorAdd [0,-20,0];
    _screenPos = _mapCtrl ctrlMapWorldToScreen _Pos; 

    _BackGround ctrlSetPosition [_screenPos select 0, (_screenPos select 1), 0.15,  0.12];
    _Header ctrlSetPosition [_screenPos select 0, _screenPos select 1, 0.15, 0.025];

    _Header ctrlSetScale (1 - ctrlMapScale  _mapCtrl);
    _BackGround ctrlSetScale (1 - ctrlMapScale  _mapCtrl);
    
    _BackGround ctrlCommit 0;
    _Header ctrlCommit 0;


};

{

    _yy = _X;
    {
        _map = findDisplay 12;
        _mapCtrl = _map displayCtrl 51;
        _Pos = _x select 4;

        [_map,_mapCtrl,_Pos]call CreateTownInfo;

        sleep 0.02;

        _x set [count _x - 1,ctrlCount - 2];

    }forEach _yy;

} forEach (GameData # 1);
publicVariable "GameData";

_map displayAddEventHandler ["MouseMoving", {
    {
        _Header =(marks # _forEachIndex # 0);
        _BackGround = (marks # _forEachIndex # 1);
        _pos = (marks # _forEachIndex # 2);

        [_Header, _BackGround, _pos]call UpdateMarks;

        
    } forEach marks;
}];
_map displayAddEventHandler ["MouseHolding", {
    {
        
        _Header =(marks # _forEachIndex # 0);
        _BackGround = (marks # _forEachIndex # 1);
        _pos = (marks # _forEachIndex # 2);

        [_Header, _BackGround, _pos]call UpdateMarks;

    } forEach marks;
}];

execVM "player\PlayerLoops\mapUpdate.sqf"
execVM "player\PlayerLoops\mapCapture.sqf"