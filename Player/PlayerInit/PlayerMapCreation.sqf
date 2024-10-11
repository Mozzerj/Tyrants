// basic script setup

sleep 2;

_map = findDisplay 12;
_mapCtrl = _map displayCtrl 51;
marks = [];
ctrlCount = 0;
MapLB = missionConfigFile >> "myMissionConfig" >> "RscMapListbox";
BaseMapLB = missionConfigFile >> "myMissionConfig" >> "RscBaseMapListbox";

waitUntil {!isNull (findDisplay 46)};









// create player overlay on screen to display capture time or mission info                this is the top middle thing 

_OverlayBackground = (findDisplay 46) ctrlCreate [MapLB, (3000)];// id 3000 - 3999 for player overaly ctrls
_OverlayHeader = (findDisplay 46) ctrlCreate ["RscText", (3001)];

_OverlayBackground ctrlSetPosition [(safeZoneX + safeZoneW * 0.45),(safeZoneY + safeZoneH * 0.01), 0.2,  0.12];
_OverlayHeader ctrlSetPosition [(safeZoneX + safeZoneW * 0.45),(safeZoneY + safeZoneH * 0.01), 0.2, 0.025];

_OverlayBackground ctrlCommit 0;
_OverlayHeader ctrlCommit 0;

_OverlayBackground ctrlSetBackgroundColor [0,0,0,0];
_OverlayHeader ctrlSetBackgroundColor [0,0,0,0];













// marker for the player base
_BaseBackGround = _map ctrlCreate [BaseMapLB, 3002]; // id 2000 - 2999 for map ctrls
_BaseHeader = _map ctrlCreate ["RscText", 3003];

_BaseHeader ctrlSetText "Hideout";

_screenPos = _mapCtrl ctrlMapWorldToScreen (gamedata # 0 # (pside + 1) # 0); 

_BaseBackGround ctrlSetPosition [_screenPos select 0, _screenPos select 1, 0.1, 0.05];
_BaseHeader ctrlSetPosition [_screenPos select 0, _screenPos select 1, 0.1, 0.05];

_BaseBackGround ctrlCommit 0;
_BaseHeader ctrlCommit 0;












// set the correct colour for the base
switch (Pside) do {
    case 0: { _BaseHeader ctrlSetBackgroundColor [0.00, 0.30, 0.60, 1.00]};
    case 1: { _BaseHeader ctrlSetBackgroundColor [0.50, 0.00, 0.00, 1.00]};
};
_BaseBackGround ctrlSetBackgroundColor [0,0,0,0.7];

baseMarks = [_BaseHeader,_BaseBackGround];

















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
    params["_Header","_Background","_Pos","_height","_width","_height1","_width1"];

    _map = findDisplay 12;
    _mapCtrl = _map displayCtrl 51;

    _Pos = _Pos vectorAdd [0,-20,0];
    _screenPos = _mapCtrl ctrlMapWorldToScreen _Pos; 

    _BackGround ctrlSetPosition [_screenPos select 0, (_screenPos select 1), _width,  _height];
    _Header ctrlSetPosition [_screenPos select 0, _screenPos select 1, _width1, _height1];

    _Header ctrlSetScale (1 - ctrlMapScale  _mapCtrl);
    _BackGround ctrlSetScale (1 - ctrlMapScale  _mapCtrl);
    
    _BackGround ctrlCommit 0;
    _Header ctrlCommit 0;

};





// creates the markers on the map
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







// adds an event handler that updates the position when it is moved so they are in the correct position relative to the map
_map displayAddEventHandler ["MouseMoving", {
    {
        _Header =(marks # _forEachIndex # 0);
        _BackGround = (marks # _forEachIndex # 1);
        _pos = (marks # _forEachIndex # 2);

        [_Header, _BackGround, _pos, 0.12, 0.15, 0.025, 0.15]call UpdateMarks;

        
    } forEach marks;

    [baseMarks # 0, baseMarks # 1, (gamedata # 0 # (pside + 1) # 0), 0.155, 0.16, 0.025, 0.16]call UpdateMarks;
}];

_map displayAddEventHandler ["MouseHolding", {
    {
        
        _Header =(marks # _forEachIndex # 0);
        _BackGround = (marks # _forEachIndex # 1);
        _pos = (marks # _forEachIndex # 2);

        [_Header, _BackGround, _pos, 0.12, 0.15, 0.025, 0.15]call UpdateMarks;

    } forEach marks;

    [baseMarks # 0, baseMarks # 1, (gamedata # 0 # (pside + 1) # 0), 0.155, 0.16, 0.025, 0.16]call UpdateMarks;
}];







execVM "player\PlayerLoops\mapUpdate.sqf"
execVM "player\PlayerLoops\mapCapture.sqf"
execVM "player\PlayerLoops\LoadoutSave.sqf"