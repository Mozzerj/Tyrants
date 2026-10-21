params ["_building"];
if (!isServer || {isNull _building}) exitWith {};
private _key = format ["%1@%2,%3",typeOf _building,round ((getPosWorld _building)#0),round ((getPosWorld _building)#1)];
private _arr = TYR_State getOrDefault ["destroyedBuildings",[]];
_arr pushBackUnique _key;
TYR_State set ["destroyedBuildings",_arr];
["destroyed-building"] call TYR_fnc_StateMarkDirty;
