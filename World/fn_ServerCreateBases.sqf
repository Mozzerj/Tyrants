if (!isServer) exitWith {};
if (count keys (TYR_Runtime getOrDefault ["bases",createHashMap]) > 0) exitWith {};
private _bases = createHashMap;
private _boxClasses = createHashMapFromArray [["west","B_supplyCrate_F"],["east","O_supplyCrate_F"],["independent","I_supplyCrate_F"]];
private _manClasses = createHashMapFromArray [["west","B_G_Soldier_unarmed_F"],["east","O_G_Soldier_unarmed_F"],["independent","I_G_Soldier_unarmed_F"]];
private _respawnNames = createHashMapFromArray [["west","respawn_west"],["east","respawn_east"],["independent","respawn_guerrila"]];

{
    private _fid = _x;
    private _f = [_fid] call TYR_fnc_StateGetFaction;
    if (_f getOrDefault ["active",false]) then {
        private _pos = _f getOrDefault ["basePosition",[]];
        if ([_pos] call TYR_fnc_IsValidLandPosition) then {
            private _side = [_fid] call TYR_fnc_FactionSide;
            private _box = createVehicle [_boxClasses get _fid,_pos vectorAdd [4,2,0],[],0,"NONE"];
            _box setVariable ["TYR_baseFaction",_fid,true];
            _box allowDamage false;
            [_box,_fid] remoteExec ["TYR_fnc_ClientAttachBaseActions",0,_box];
            private _grp = createGroup [_side,true];
            private _accountant = _grp createUnit [_manClasses get _fid,_pos vectorAdd [-3,2,0],[],0,"NONE"];
            _accountant setVariable ["TYR_baseFaction",_fid,true];
            _accountant setVariable ["TYR_isAccountant",true,true];
            _accountant disableAI "PATH";
            private _mName = _respawnNames get _fid;
            deleteMarker _mName;
            private _m = createMarker [_mName,_pos];
            _m setMarkerType "mil_start";
            _m setMarkerAlpha 0;
            _m setMarkerText "";
            _bases set [_fid,createHashMapFromArray [["box",_box],["accountant",_accountant],["group",_grp]]];
        } else {
            diag_log format ["[TYRANTS BASE] Refused to create %1 HQ at invalid position %2.",_fid,_pos];
        };
    };
} forEach ([false] call TYR_fnc_FactionIds);
TYR_Runtime set ["bases",_bases];
