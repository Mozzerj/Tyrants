params ["_class"];
private _cfg = configFile >> "CfgVehicles" >> _class;
if (!isClass _cfg) exitWith {"other"};
if ((_class find "Quadbike") >= 0 || {_class find "Offroad_01_F" >= 0}) exitWith {"other"};
if (_class isKindOf "Tank") exitWith {"heavy"};
if (_class isKindOf "Wheeled_APC_F" || {_class isKindOf "Car"}) exitWith {"armored"};
if (_class isKindOf "Helicopter") exitWith {"rotary"};
if (_class isKindOf "Plane") exitWith {"fixed"};
if (_class isKindOf "StaticMortar" || {_class isKindOf "StaticWeapon"}) exitWith {"artillery"};
"other"
