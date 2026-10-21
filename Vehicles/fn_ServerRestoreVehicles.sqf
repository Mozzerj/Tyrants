if (!isServer) exitWith {};
private _runtime = TYR_Runtime get "vehicles";
private _map = TYR_State get "vehicles";
{
    private _id = _x;
    private _v = _map get _id;
    private _class = _v get "class";
    if (isClass (configFile >> "CfgVehicles" >> _class)) then {
        private _obj = createVehicle [_class,_v get "position",[],0,"NONE"];
        _obj setDir (_v getOrDefault ["direction",0]);
        _obj setDamage [_v getOrDefault ["damage",0],false];
        _obj setFuel (_v getOrDefault ["fuel",1]);
        _obj setVehicleAmmo (_v getOrDefault ["ammo",1]);
        _obj setVariable ["TYR_persistentId",_id,true];
        _obj setVariable ["TYR_factionId",_v get "faction",true];
        _obj addEventHandler ["Killed",{params ["_veh"];[_veh] call TYR_fnc_ServerVehicleKilled}];
        private _cargo = _v getOrDefault ["cargo",[[],[],[],[]]];
        clearWeaponCargoGlobal _obj; clearMagazineCargoGlobal _obj; clearItemCargoGlobal _obj; clearBackpackCargoGlobal _obj;
        if (count _cargo >= 4) then {
            private _applyCargo = {
                params ["_pair","_fn"];
                if (_pair isEqualType [] && {count _pair >= 2}) then {
                    for "_i" from 0 to ((count (_pair # 0))-1) do {
                        [_obj,(_pair # 0) # _i,(_pair # 1) # _i] call _fn;
                    };
                };
            };
            [_cargo # 0,{params ["_o","_c","_n"];_o addWeaponCargoGlobal [_c,_n]}] call _applyCargo;
            [_cargo # 1,{params ["_o","_c","_n"];_o addMagazineCargoGlobal [_c,_n]}] call _applyCargo;
            [_cargo # 2,{params ["_o","_c","_n"];_o addItemCargoGlobal [_c,_n]}] call _applyCargo;
            [_cargo # 3,{params ["_o","_c","_n"];_o addBackpackCargoGlobal [_c,_n]}] call _applyCargo;
        };
        _runtime set [_id,_obj];
    };
} forEach keys _map;
