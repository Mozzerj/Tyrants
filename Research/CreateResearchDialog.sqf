CreateDialog "ResearchMenu";

_ResearchProgress = GameData # 0 # (Pside + 1) # 5;

_ResearchDisplay = findDisplay 1005;

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
_CtrlBI3 = _ResearchDisplay displayCtrl 1200;
_CtrlBI4 = _ResearchDisplay displayCtrl 1110;
_CtrlBI5 = _ResearchDisplay displayCtrl 1300;

_CtrlBI21 = _ResearchDisplay displayCtrl 2000;
_CtrlBI22 = _ResearchDisplay displayCtrl 2100;
_CtrlBI23 = _ResearchDisplay displayCtrl 2200;
_CtrlBI24 = _ResearchDisplay displayCtrl 2110;
_CtrlBI25 = _ResearchDisplay displayCtrl 2120;
_CtrlBI26 = _ResearchDisplay displayCtrl 2300;

_CtrlAP1 = _ResearchDisplay displayCtrl 3000;
_CtrlAP2 = _ResearchDisplay displayCtrl 3001;
_CtrlAP3 = _ResearchDisplay displayCtrl 3002;
_CtrlAP4 = _ResearchDisplay displayCtrl 3003;
_CtrlAP5 = _ResearchDisplay displayCtrl 3004;
_CtrlAP6 = _ResearchDisplay displayCtrl 3005;


switch (Pside) do {
    case 0: { _solidColor = [0.00, 0.30, 0.60, 1.00]};
    case 1: { _solidColor = [0.50, 0.00, 0.00, 1.00]};
};

_greyed = [0.851,0.5647,0.0863,1];

_changeCtrlColor = {
    params ["_ctrl", "_value"];
    if (_value == 0) then {
        _ctrl ctrlSetBackgroundColor _greyed;
        _ctrl ctrlSetActiveColor _greyed;
    } else {
        _ctrl ctrlSetBackgroundColor _solidColor;
        _ctrl ctrlSetActiveColor _solidColor;
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