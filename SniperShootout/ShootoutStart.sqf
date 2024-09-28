openMap [true,false];
clicked = false;

player onMapSingleClick "

    ClickPos = _pos; 

    if (!surfaceIsWater ClickPos) then {clicked = true};
    
";

waitUntil {clicked};

openMap [false,false];
player onMapSingleClick "";

range = parseNumber(_this # 0);

_zoneCircle = createMarker ["ShootoutZone", ClickPos];
_zoneCircle setMarkerType "mil_circle_noShadow";
"ShootoutZone" setMarkerShape "ELLIPSE";
_zoneCircle setMarkerAlpha 0.85;
_zoneCircle setMarkerColor "Color6_FD_F";
_zoneCircle setMarkerSize [range,range];

GameMode = "SniperShootout";
publicVariable "range";
publicVariable "ClickPos";
publicVariable "GameMode";
