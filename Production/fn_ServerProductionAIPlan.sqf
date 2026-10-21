params ["_factionId"];
if (!isServer) exitWith {};
private _f = [_factionId] call TYR_fnc_StateGetFaction;
if ((_f getOrDefault ["controller","human"]) isNotEqualTo "ai" || {!(_f getOrDefault ["active",false])}) exitWith {};
private _depot = _f getOrDefault ["depotInventory",createHashMap];
private _locations = TYR_State getOrDefault ["locations",createHashMap];
{
    private _id = _x;
    private _loc = _locations get _id;
    if ((_loc getOrDefault ["kind",""]) isEqualTo "factory" && {(_loc getOrDefault ["owner","neutral"]) isEqualTo _factionId}) then {
        private _queue = _loc getOrDefault ["productionQueue",[]];
        if (count _queue < 2) then {
            private _type = _loc getOrDefault ["factoryType","munitions"];
            private _product = "";
            private _reason = "Maintain strategic reserve";
            switch (_type) do {
                case "munitions": {
                    if ((_depot getOrDefault ["general_ammo",0]) < 2500) then {_product = "general_ammo"; _reason = "General ammunition depot below 2500 reserve"}
                    else {if ((_depot getOrDefault ["artillery_he",0]) < 180) then {_product = "artillery_he"; _reason = "Artillery shell reserve below target"} else {_product = "general_ammo"}};
                };
                case "air_defence": {
                    _product = if ((_depot getOrDefault ["sam_missile",0]) < 20) then {"sam_missile"} else {"cram_ammo"};
                    _reason = if (_product isEqualTo "sam_missile") then {"SAM missile reserve below target"} else {"C-RAM ammunition reserve below target"};
                };
                case "strategic": {_product = "vls_missile"; _reason = "Build strategic missile reserve"};
                case "vehicle": {
                    private _catalog = [_factionId,_type] call TYR_fnc_ProductionGetCatalog;
                    private _inventory = _loc getOrDefault ["inventory",createHashMap];
                    private _vehicleStock = 0;
                    {if ((_x find "vehicle:") isEqualTo 0) then {_vehicleStock = _vehicleStock + (_inventory getOrDefault [_x,0])}} forEach keys _inventory;
                    if (_vehicleStock < 2 && {count _catalog > 0}) then {
                        // Prefer armoured/motorised equipment without reading hidden enemy state.
                        private _pick = _catalog # (floor random (count _catalog));
                        _product = _pick # 0;
                        _reason = "Vehicle reserve at factory below two ready vehicles";
                    };
                };
            };
            if (_product isNotEqualTo "") then {[_factionId,_id,_product,_reason,"AI logistics planner"] call TYR_fnc_ProductionQueue};
        };
    };
} forEach keys _locations;
