disableSerialization;
private _d = findDisplay 1450;
if (isNull _d || {isNil "TYR_ClientState"}) exitWith {};
private _factoryId = missionNamespace getVariable ["TYR_factoryMenuId",""];
private _loc = (TYR_ClientState getOrDefault ["locations",createHashMap]) getOrDefault [_factoryId,[]];
if (count _loc < 14) exitWith {(_d displayCtrl 1) ctrlSetText "FACTORY DATA UNAVAILABLE"};
private _factoryType = _loc # 11;
private _operational = _loc param [14,true];
(_d displayCtrl 1) ctrlSetText (_loc # 1);
(_d displayCtrl 2) ctrlSetText format ["TYPE // %1 // %2",toUpper _factoryType,if (_operational) then {"ONLINE"} else {"PRODUCTION PAUSED"}];

private _list = _d displayCtrl 10;
private _oldSel = lbCurSel _list;
if (lbSize _list isEqualTo 0) then {
    private _catalog = [TYR_PlayerFaction,_factoryType] call TYR_fnc_ProductionGetCatalog;
    {
        private _i = _list lbAdd format ["%1 // x%2 // %3s",_x # 1,_x # 3,round (_x # 4)];
        _list lbSetData [_i,_x # 0];
    } forEach _catalog;
    if (lbSize _list > 0) then {_list lbSetCurSel 0};
};
private _sel = lbCurSel _list;
private _productId = if (_sel >= 0) then {_list lbData _sel} else {""};
private _catalog = [TYR_PlayerFaction,_factoryType] call TYR_fnc_ProductionGetCatalog;
private _def = [];
{if ((_x # 0) isEqualTo _productId) exitWith {_def = _x}} forEach _catalog;
if (count _def > 0) then {
    (_d displayCtrl 13) ctrlSetText format ["%1\nOUTPUT: %2 // BUILD TIME: %3s\nProduction is capacity/time based; completed stock remains at this physical factory until moved.",_def # 1,_def # 3,round (_def # 4)];
};
private _q = _d displayCtrl 11;
lbClear _q;
private _received = missionNamespace getVariable ["TYR_ClientLocationReceivedAt",createHashMap];
private _elapsed = (diag_tickTime - (_received getOrDefault [_factoryId,diag_tickTime])) max 0;
{
    private _eta = ((_x # 4) - _elapsed) max 0;
    private _i = _q lbAdd format ["%1 x%2 // %3",_x # 2,_x # 3,if (_operational) then {format ["ETA %1s",ceil _eta]} else {"PAUSED"}];
    _q lbSetTooltip [_i,_x # 5];
} forEach (_loc # 13);
if (lbSize _q isEqualTo 0) then {_q lbAdd "QUEUE EMPTY"};
private _stockParts = [];
{
    if ((_x # 1) > 0) then {_stockParts pushBack format ["%1: %2",toUpper (_x # 0),_x # 1]};
} forEach (_loc # 12);
(_d displayCtrl 12) ctrlSetText format ["LOCAL STOCK\n%1",if (count _stockParts > 0) then {_stockParts joinString "\n"} else {"EMPTY"}];
(_d displayCtrl 20) ctrlEnable (_productId isNotEqualTo "" && {count (_loc # 13) < 3});
