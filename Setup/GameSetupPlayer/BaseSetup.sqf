_LocationChosen = false;

openMap [true,true];

pos = [0,0,0];
_lineY = 0;
_pointY = 1;

switch (Pside) do {
    case 0: { lineSide = 500 };
    case 1: { lineSide = -500 };
};


LocationChoose = {
    clicked = false;

    if (((Pside == 0 && _pointY < _lineY) || (Pside == 1 && _pointY > _lineY)) && (!surfaceIsWater [pos select 0, pos select 1])) then {
        onMapSingleClick "";
        LocationChosen = true;
    } else {
        onMapSingleClick "pos = _pos; clicked = true";
        waitUntil {clicked};

        _pointX = (pos select 0);
        _pointY = (pos select 1);
        _lineY = m * _pointX + b;

        call LocationChoose;
    };
};

call LocationChoose;

waitUntil {LocationChosen};

switch (Pside) do {
    case 0: {
        GameData # 0 # 1 set [0, pos];
    };
    case 1: {
        GameData # 0 # 2 set [0, pos];
    };
};

deleteMarkerLocal divederMarker;
deleteMarkerLocal divederMarker1;

[0, "BLACK", 3, 1] spawn BIS_fnc_fadeEffect;
sleep 5;
openMap [false, false];

publicVariable "GameData";