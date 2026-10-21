if (!isServer) exitWith {};
private _jobs = TYR_State getOrDefault ["logistics",createHashMap];
private _locations = TYR_State getOrDefault ["locations",createHashMap];
private _activeJobExists = {
    params ["_originId","_destType","_destId",["_product",""]];
    private _found = false;
    {
        private _j = _jobs get _x;
        if ((_j getOrDefault ["status",""]) in ["virtual","physical"] && {(_j getOrDefault ["originId",""]) isEqualTo _originId} && {(_j getOrDefault ["destinationType",""]) isEqualTo _destType} && {(_j getOrDefault ["destinationId",""]) isEqualTo _destId}) then {
            if (_product isEqualTo "" || {((_j getOrDefault ["cargo",[]]) findIf {(_x # 0) isEqualTo _product}) >= 0}) then {_found = true};
        };
    } forEach keys _jobs;
    _found
};

// Factory output moves to the faction HQ depot. Vehicle products remain at their
// factory because driving/spawning the actual produced vehicle is more meaningful
// than putting a tank inside an ammo truck abstraction.
{
    private _id = _x;
    private _loc = _locations get _id;
    if ((_loc getOrDefault ["kind",""]) isEqualTo "factory") then {
        private _fid = _loc getOrDefault ["owner","neutral"];
        if (_fid in ["west","east","independent"]) then {
            private _inv = _loc getOrDefault ["inventory",createHashMap];
            {
                private _product = _x;
                private _qty = floor (_inv getOrDefault [_product,0]);
                if (_qty > 0 && {!((_product find "vehicle:") isEqualTo 0)} && {!([_id,"hq","",_product] call _activeJobExists)}) then {
                    private _move = _qty min (if (_product isEqualTo "general_ammo") then {1000} else {_qty});
                    private _f = [_fid] call TYR_fnc_StateGetFaction;
                    private _hq = +(_f getOrDefault ["basePosition",[]]);
                    if (count _hq >= 2) then {
                        [_fid,"factory",_id,+(_loc getOrDefault ["position",[]]),"hq","",_hq,[[_product,_move]],format ["Move produced %1 to main depot",_product]] call TYR_fnc_LogisticsCreateJob;
                        [_id,_fid] call TYR_fnc_ServerPublishLocation;
                    };
                };
            } forEach keys _inv;
        };
    };
} forEach keys _locations;

// Forces consume strategic supply while active. Low-supply forces request a real
// convoy from the HQ depot. General ammunition must already have been manufactured.
// Fuel remains a support resource rather than factory output; when a force needs it,
// a bounded quantity is packed into HQ-depot `fuel_supply` stock and then still has
// to travel physically/virtually to the force like every other logistics manifest.
{
    private _fid = _x;
    private _f = [_fid] call TYR_fnc_StateGetFaction;
    private _depot = _f getOrDefault ["depotInventory",createHashMap];
    private _resources = _f getOrDefault ["resources",createHashMap];
    private _hq = +(_f getOrDefault ["basePosition",[]]);
    {
        private _forceId = _x;
        private _fr = (TYR_State getOrDefault ["forces",createHashMap]) get _forceId;
        if ((_fr getOrDefault ["faction",""]) isEqualTo _fid && {_fr getOrDefault ["active",true]}) then {
            private _supply = _fr getOrDefault ["supply",createHashMapFromArray [["ammo",100],["fuel",100]]];
            _fr set ["supply",_supply];
            private _needAmmo = (_supply getOrDefault ["ammo",100]) < 45;
            private _needFuel = (_supply getOrDefault ["fuel",100]) < 35;
            private _hasActive = ["HQ_DEPOT","force",_forceId,""] call _activeJobExists;
            if ((_needAmmo || {_needFuel}) && {!_hasActive} && {count _hq >= 2}) then {
                private _cargo = [];
                if (_needAmmo && {(_depot getOrDefault ["general_ammo",0]) >= 300}) then {
                    _cargo pushBack ["general_ammo",300];
                };
                if (_needFuel) then {
                    if ((_depot getOrDefault ["fuel_supply",0]) < 300 && {(_resources getOrDefault ["fuel",0]) >= 300}) then {
                        _resources set ["fuel",(_resources getOrDefault ["fuel",0]) - 300];
                        _depot set ["fuel_supply",(_depot getOrDefault ["fuel_supply",0]) + 300];
                        _f set ["resources",_resources];
                        _f set ["depotInventory",_depot];
                        ["fuel-packed-for-logistics"] call TYR_fnc_StateMarkDirty;
                        [_fid] call TYR_fnc_ServerPublishFaction;
                    };
                    if ((_depot getOrDefault ["fuel_supply",0]) >= 300) then {_cargo pushBack ["fuel_supply",300]};
                };
                if (count _cargo > 0) then {
                    private _dest = +(_fr getOrDefault ["position",_hq]);
                    private _grp = (TYR_Runtime getOrDefault ["forces",createHashMap]) getOrDefault [_forceId,grpNull];
                    if (!isNull _grp && {count units _grp > 0}) then {_dest = getPosATL leader _grp};
                    private _reasonParts = [];
                    if (_needAmmo) then {_reasonParts pushBack "ammo <45%"};
                    if (_needFuel) then {_reasonParts pushBack "fuel <35%"};
                    [_fid,"depot","HQ_DEPOT",_hq,"force",_forceId,_dest,_cargo,format ["Resupply %1 // %2",_forceId,_reasonParts joinString " + "]] call TYR_fnc_LogisticsCreateJob;
                };
            };
        };
    } forEach keys (TYR_State getOrDefault ["forces",createHashMap]);
} forEach ([true] call TYR_fnc_FactionIds);
