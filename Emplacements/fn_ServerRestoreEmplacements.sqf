if (!isServer) exitWith {};
private _runtime = TYR_Runtime get "emplacements";
private _map = TYR_State get "emplacements";
{
    private _id = _x;
    private _e = _map get _id;
    private _class = _e get "class";
    if (isClass (configFile >> "CfgVehicles" >> _class)) then {
        private _obj = createVehicle [_class,_e get "position",[],0,"NONE"];
        _obj setDir (_e getOrDefault ["direction",0]);
        _obj setDamage [_e getOrDefault ["damage",0],false];
        _obj setVehicleAmmo (_e getOrDefault ["ammo",1]);
        _obj setVariable ["TYR_persistentId",_id,true];
        _obj setVariable ["TYR_factionId",_e get "faction",true];
        _obj setVariable ["TYR_emplacementKey",_e get "key",true];
        _obj addEventHandler ["Killed",{
            params ["_obj"];
            private _id = _obj getVariable ["TYR_persistentId",""];
            if (_id isNotEqualTo "") then {
                (TYR_State get "emplacements") deleteAt _id;
                (TYR_Runtime get "emplacements") deleteAt _id;
                ["emplacement-killed"] call TYR_fnc_StateMarkDirty;
            };
        }];
        _runtime set [_id,_obj];
        if ((_e getOrDefault ["key",""]) isEqualTo "vls") then {
            [_obj,"vls",_e get "faction"] remoteExec ["TYR_fnc_ClientAttachEmplacementActions",0,_obj];
        };
    };
} forEach keys _map;
