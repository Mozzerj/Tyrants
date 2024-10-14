params["_ResearchSelected"];

_ResearchInfo = [];
if (isNil "ResearchSelectedID") then {ResearchSelectedID = -1};
if (isNil "ResearchSelectedValue") then {ResearchSelectedValue = 9999999999};


switch (_ResearchSelected) do {
    case 1000: {ResearchSelectedValue = 30000; ResearchSelectedID = _ResearchSelected; _ResearchInfo = ["Basic Intelligence","","Allows for the start of research into","intelligence","","Research Available:","Communications Intercept","Vehicle Trackers","","Cost:",(str ResearchSelectedValue)] };
    case 1100: {ResearchSelectedValue = 50000; ResearchSelectedID = _ResearchSelected; _ResearchInfo = ["Communication Intercept","","Random transmitions between enemy ","forces can be picked up and can be","narrowed down to a region","","Research Needed:","Basic Intelligence","","Research Available:","Listening Devices","","Cost:",(str ResearchSelectedValue)] };
    case 1110: {ResearchSelectedValue = 75000; ResearchSelectedID = _ResearchSelected; _ResearchInfo = ["Listening Devices","","Planned attacks can be revealed","allowing for pre-emptive actions","","Research Needed:","Communication Intercept","","Research Available:","Satellite Surveillance","","Cost:",(str ResearchSelectedValue)] };
    case 1200: {ResearchSelectedValue = 40000; ResearchSelectedID = _ResearchSelected; _ResearchInfo = ["Vehicle Trackers","","Can plant tracking devices on enemy","vehicles","","Info:","Tracking device will deactive after 45","minutes","","Research Needed:","Basic Intelligence","","Research Available:","Satellite Surveillance","","Cost:",(str ResearchSelectedValue)] };
    case 1300: {ResearchSelectedValue = 150000; ResearchSelectedID = _ResearchSelected; _ResearchInfo = ["Satellite Surveillance","","You have access to a Satellite for","""Research Purposes""","","Info:","Live view of chosen location","","Research Needed:","Listening Devices","Vehicle Trackers","","Cost:",(str ResearchSelectedValue)] };

    case 2000: {ResearchSelectedValue = 30000; ResearchSelectedID = _ResearchSelected; _ResearchInfo = ["Basic Infrastructure","","Allows for the start of research into","offensive and defesnive structures","","Research Available:","Strategic Emplacements","Factory Production","","Cost:",(str ResearchSelectedValue)] };
    case 2100: {ResearchSelectedValue = 35000; ResearchSelectedID = _ResearchSelected; _ResearchInfo = ["Strategic Emplacements","","Vehicles can now be manned by","recruits and dug in","","Research Available:","Counter Battery Radars","Roadblocks","","Cost:",(str ResearchSelectedValue)] };
    case 2110: {ResearchSelectedValue = 40000; ResearchSelectedID = _ResearchSelected; _ResearchInfo = ["Counter Battery Radars","","Research into how counter battery","radars work","","Research Needed:","Strategic Emplacements","","Research Available:","Offensive Emplacements","","Cost:",(str ResearchSelectedValue)] };
    case 2120: {ResearchSelectedValue = 35000; ResearchSelectedID = _ResearchSelected; _ResearchInfo = ["Roadblocks","","Roadblocked physically or with mines","","Research Needed:","Strategic Emplacements","","Research Available:","Offensive Emplacements","","Cost:",(str ResearchSelectedValue)] };
    case 2200: {ResearchSelectedValue = 75000; ResearchSelectedID = _ResearchSelected; _ResearchInfo = ["Factory Production","","Factories are now more effecient and","capable of more advanced equipment","","Info:","Factories produce 15% more resources","","Research Needed:","Basic Infrastructure","","Research Available:","Offensive Emplacements","","Cost:",(str ResearchSelectedValue)] };
    case 2300: {ResearchSelectedValue = 250000; ResearchSelectedID = _ResearchSelected; _ResearchInfo = ["Offensive Emplacements","","Static Emplacements that can deliver","a lot of firepower","","Research Needed:","Counter Battery Radars","Roadblocks","Factory Production","","Cost:",(str ResearchSelectedValue)] };

    case 3000: {ResearchSelectedValue = 30000; ResearchSelectedID = _ResearchSelected; _ResearchInfo = ["Armoured Procurement","","You can now buy armoured vehicles","","Research Available:","Heavy Armour","","Cost:",(str ResearchSelectedValue)] };
    case 3001: {ResearchSelectedValue = 35000; ResearchSelectedID = _ResearchSelected; _ResearchInfo = ["Heavy Armour","","You can now buy heavy armoured","vehicles","","Research Needed:","Armoured Procurement","","Research Available:","Rotary Wing","","Cost:",(str ResearchSelectedValue)] };
    case 3002: {ResearchSelectedValue = 45000; ResearchSelectedID = _ResearchSelected; _ResearchInfo = ["Rotary Wing","","You can now buy rotary wing aircraft","","Research Needed:","Heavy Armour","","Research Available:","Artillery","","Cost:",(str ResearchSelectedValue)] };
    case 3003: {ResearchSelectedValue = 60000; ResearchSelectedID = _ResearchSelected; _ResearchInfo = ["Artillery","","You can now buy Artillery","","Research Needed:","Rotary Wing","","Research Available:","Fixed Wing","","Cost:",(str ResearchSelectedValue)] };
    case 3004: {ResearchSelectedValue = 100000; ResearchSelectedID = _ResearchSelected; _ResearchInfo = ["Fixed Wing","","You can now buy fixed wing aircraft","","Research Needed:","Artillery","","Research Available:","Autonomous Capabilities","","Cost:",(str ResearchSelectedValue)] };
    case 3005: {ResearchSelectedValue = 100000; ResearchSelectedID = _ResearchSelected; _ResearchInfo = ["Autonomous Capabilities","","You can now buy autonomous vehicles","","Research Needed:","Fixed Wing","","Cost:",(str ResearchSelectedValue)] };
    case 5: {

        // research button pressed
        _SideData = gameData # 0 # (Pside + 1);
        
        if (_SideData # 1 > ResearchSelectedValue) then {

            _SideData1 = _SideData # 5 # 0;
            _SideData2 = _SideData # 5 # 1;
            _SideData3 = _SideData # 5 # 2;


            switch (ResearchSelectedID) do {
                case 1000: {if (_SideData1 # 0 == 0) then {_SideData# 5 # 0  set [0,1]}};
                case 1100: {if (_SideData1 # 0 == 1) then {_SideData # 5 # 0  set [1,1]}};
                case 1110: {if (_SideData1 # 1 == 1) then {_SideData # 5 # 0  set [2,1]}};
                case 1200: {if (_SideData1 # 0 == 1) then {_SideData # 5 # 0  set [3,1]}};
                case 1300: {if (_SideData1 # 2 == 1 && _SideData1 # 3 == 1) then {_SideData # 5 # 0  set [4,1]}};

                case 2000: {if (_SideData2 # 0 == 0) then {_SideData # 5 # 1  set [0,1]}};
                case 2100: {if (_SideData2 # 0 == 1) then {_SideData # 5 # 1  set [1,1]}};
                case 2110: {if (_SideData2 # 1 == 1) then {_SideData # 5 # 1  set [2,1]}};
                case 2120: {if (_SideData2 # 1 == 1) then {_SideData # 5 # 1  set [3,1]}};
                case 2200: {if (_SideData2 # 0 == 1) then {_SideData # 5 # 1  set [4,1]}};
                case 2300: {if (_SideData2 # 4 == 1 && _SideData2 # 3 == 1 && _SideData2 # 2 == 1) then {_SideData # 5 # 1  set [5,1]}};

                case 3000: {if (_SideData3 # 0 == 0) then {_SideData # 5 # 2  set [0,1]}};
                case 3001: {if (_SideData3 # 0 == 1) then {_SideData # 5 # 2  set [1,1]}};
                case 3002: {if (_SideData3 # 1 == 1) then {_SideData # 5 # 2  set [2,1]}};
                case 3003: {if (_SideData3 # 2 == 1) then {_SideData # 5 # 2  set [3,1]}};
                case 3004: {if (_SideData3 # 3 == 1) then {_SideData # 5 # 2  set [4,1]}};
                case 3005: {if (_SideData3 # 4 == 1) then {_SideData # 5 # 2  set [5,1]}};

            };

            gameData # 0 # (Pside + 1) set [1,(gameData # 0 # (Pside + 1) # 1) - ResearchSelectedValue];

        }
        else
        {

            hint "Not Enough";
            sleep 1;
            hint "";

        };


        gameData # 0 set [(Pside + 1), _SideData];
        publicVariable "gameData";

    };
    
};

//hint str ResearchSelectedID;// shows id of selected

_researchDisplay = findDisplay 1005;

(_ResearchDisplay displayCtrl 2)ctrlSetText format["Steel: %1", (gameData # 0 # (Pside + 1) # 1)];

_ResearchInfoLB = _researchDisplay displayCtrl 1;

lbClear _ResearchInfoLB;

{

    _ResearchInfoLB lbAdd _x;
    
} forEach _ResearchInfo;

_ResearchProgress = GameData # 0 # (Pside + 1) # 5;

ctrlSetFocus (_ResearchDisplay displayCtrl 5);

_BI1 = _ResearchProgress # 0 # 0;
_BI2 = _ResearchProgress # 0 # 1;
_BI3 = _ResearchProgress # 0 # 2;
_BI4 = _ResearchProgress # 0 # 3;
_BI5 = _ResearchProgress # 0 # 4;

_BI21 = _ResearchProgress # 1 # 0;
_BI22 = _ResearchProgress # 1 # 1;
_BI23 = _ResearchProgress # 1 # 2;
_BI24 = _ResearchProgress # 1 # 3;
_BI25 = _ResearchProgress # 1 # 4;
_BI26 = _ResearchProgress # 1 # 5;

_AP1 = _ResearchProgress # 2 # 0;
_AP2 = _ResearchProgress # 2 # 1;
_AP3 = _ResearchProgress # 2 # 2;
_AP4 = _ResearchProgress # 2 # 3;
_AP5 = _ResearchProgress # 2 # 4;
_AP6 = _ResearchProgress # 2 # 5;

_CtrlBI1 = _ResearchDisplay displayCtrl 1000;
_CtrlBI2 = _ResearchDisplay displayCtrl 1100;
_CtrlBI3 = _ResearchDisplay displayCtrl 1110;
_CtrlBI4 = _ResearchDisplay displayCtrl 1200;
_CtrlBI5 = _ResearchDisplay displayCtrl 1300;

_CtrlBI21 = _ResearchDisplay displayCtrl 2000;
_CtrlBI22 = _ResearchDisplay displayCtrl 2100;
_CtrlBI23 = _ResearchDisplay displayCtrl 2110;
_CtrlBI24 = _ResearchDisplay displayCtrl 2120;
_CtrlBI25 = _ResearchDisplay displayCtrl 2200;
_CtrlBI26 = _ResearchDisplay displayCtrl 2300;

_CtrlAP1 = _ResearchDisplay displayCtrl 3000;
_CtrlAP2 = _ResearchDisplay displayCtrl 3001;
_CtrlAP3 = _ResearchDisplay displayCtrl 3002;
_CtrlAP4 = _ResearchDisplay displayCtrl 3003;
_CtrlAP5 = _ResearchDisplay displayCtrl 3004;
_CtrlAP6 = _ResearchDisplay displayCtrl 3005;


switch (Pside) do {
    case 0: { solidColor = [0.00, 0.30, 0.60, 1.00]};
    case 1: { solidColor = [0.50, 0.00, 0.00, 1.00]};
};

_greyed = [0.851,0.5647,0.0863,1];

_changeCtrlColor = {
    params ["_ctrl", "_value"];
    if (_value == 0) then {
        _ctrl ctrlSetBackgroundColor _greyed;
        _ctrl ctrlSetActiveColor _greyed;
    } else {
        _ctrl ctrlSetActiveColor solidColor;
        _ctrl ctrlSetBackgroundColor solidColor;
    };
};

[_CtrlBI1, _BI1] call _changeCtrlColor;
[_CtrlBI2, _BI2] call _changeCtrlColor;
[_CtrlBI3, _BI3] call _changeCtrlColor;
[_CtrlBI4, _BI4] call _changeCtrlColor;
[_CtrlBI5, _BI5] call _changeCtrlColor;

[_CtrlBI21, _BI21] call _changeCtrlColor;
[_CtrlBI22, _BI22] call _changeCtrlColor;
[_CtrlBI23, _BI23] call _changeCtrlColor;
[_CtrlBI24, _BI24] call _changeCtrlColor;
[_CtrlBI25, _BI25] call _changeCtrlColor;
[_CtrlBI26, _BI26] call _changeCtrlColor;

[_CtrlAP1, _AP1] call _changeCtrlColor;
[_CtrlAP2, _AP2] call _changeCtrlColor;
[_CtrlAP3, _AP3] call _changeCtrlColor;
[_CtrlAP4, _AP4] call _changeCtrlColor;
[_CtrlAP5, _AP5] call _changeCtrlColor;
[_CtrlAP6, _AP6] call _changeCtrlColor;