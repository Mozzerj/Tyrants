params ["_factionId","_factoryType"];
private _pool = [];
private _unlocked = [];
if (isServer) then {
    private _f = [_factionId] call TYR_fnc_StateGetFaction;
    if (count _f > 0) then {
        _pool = +(_f getOrDefault ["vehiclePool",[]]);
        private _research = _f getOrDefault ["research",createHashMap];
        _unlocked = (keys _research) select {_research getOrDefault [_x,false]};
    };
} else {
    if (!isNil "TYR_ClientState") then {
        private _f = (TYR_ClientState getOrDefault ["factions",createHashMap]) getOrDefault [_factionId,[]];
        if (count _f > 8) then {_pool = +(_f # 8)};
        if (count _f > 6) then {_unlocked = +(_f # 6)};
    };
};

private _catalog = [];
if (_factoryType isEqualTo "vehicle") then {
    {
        private _class = _x;
        if (isClass (configFile >> "CfgVehicles" >> _class)) then {
            private _cat = [_class] call TYR_fnc_VehicleCategory;
            private _gate = switch (_cat) do {
                case "armored": {"proc.armored"};
                case "heavy": {"proc.heavy"};
                case "rotary": {"proc.rotary"};
                case "artillery": {"proc.artillery"};
                case "fixed": {"proc.fixed"};
                default {""};
            };
            if (_gate isEqualTo "" || {_gate in _unlocked}) then {
                private _time = switch (_cat) do {
                    case "heavy": {210};
                    case "fixed": {240};
                    case "rotary": {180};
                    case "artillery": {170};
                    case "armored": {130};
                    default {70};
                };
                _catalog pushBack [format ["vehicle:%1",_class],getText (configFile >> "CfgVehicles" >> _class >> "displayName"),"vehicle",1,_time,_gate,_class];
            };
        };
    } forEach _pool;
} else {
    switch (_factoryType) do {
        case "munitions": {
            _catalog = [
                ["general_ammo","GENERAL AMMUNITION BATCH","ammo",500,45,"",""],
                ["artillery_he","ARTILLERY HE SHELLS","ammo",40,70,"proc.artillery",""],
                ["artillery_smoke","ARTILLERY SMOKE SHELLS","ammo",12,55,"proc.artillery",""]
            ];
        };
        case "air_defence": {
            _catalog = [
                ["sam_missile","SAM MISSILES","ammo",4,120,"",""],
                ["cram_ammo","C-RAM AMMUNITION","ammo",1000,80,"",""]
            ];
        };
        case "strategic": {
            _catalog = [["vls_missile","VLS CRUISE MISSILE","ammo",1,210,"infra.vls",""]];
        };
    };
};
_catalog
