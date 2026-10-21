params ["_class"];
private _cfg = configFile >> "CfgVehicles" >> _class;
if (!isClass _cfg) exitWith {999999};
private _armor = getNumber (_cfg >> "armor");
private _speed = getNumber (_cfg >> "maxSpeed");
private _transport = getNumber (_cfg >> "transportSoldier");
private _base = 1500 + (_armor * 18) + (_speed * 8) + (_transport * 250);
private _cat = [_class] call TYR_fnc_VehicleCategory;
private _mult = switch (_cat) do {
    case "heavy": {2.5};
    case "rotary": {2.0};
    case "fixed": {3.0};
    case "artillery": {2.2};
    case "armored": {1.4};
    default {1};
};
round (_base * _mult)
