params ["_factoryId","_item"];
if (!isServer) exitWith {};
private _loc = [_factoryId] call TYR_fnc_StateGetLocation;
if (count _loc isEqualTo 0) exitWith {};
private _inventory = _loc getOrDefault ["inventory",createHashMap];
private _product = _item getOrDefault ["product",""];
private _amount = _item getOrDefault ["amount",0];
if (_product isNotEqualTo "" && {_amount > 0}) then {
    _inventory set [_product,(_inventory getOrDefault [_product,0]) + _amount];
    _loc set ["inventory",_inventory];
    _loc set ["lastProduction",serverTime];
    _loc set ["lastProductionText",format ["%1 x%2",_item getOrDefault ["display",_product],_amount]];
    ["factory-production-complete"] call TYR_fnc_StateMarkDirty;
    private _owner = _loc getOrDefault ["owner","neutral"];
    if (_owner in ["west","east","independent"]) then {[_factoryId,_owner] call TYR_fnc_ServerPublishLocation};
};
