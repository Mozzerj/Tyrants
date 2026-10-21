if (!isServer) exitWith {createHashMap};

private _controller = {
    params ["_param", "_default"];
    private _v = [_param, _default] call BIS_fnc_getParamValue;
    switch (_v) do {
        case 0: {"human"};
        case 1: {"ai"};
        default {"disabled"};
    }
};

private _start = ["TYR_StartingResources", 15000] call BIS_fnc_getParamValue;
private _manpower = ["TYR_StartingManpower", 60] call BIS_fnc_getParamValue;
private _difficulty = ["TYR_AIDifficulty", 1] call BIS_fnc_getParamValue;
private _defs = call TYR_fnc_GetResearchDefinitions;

private _makeResearch = {
    private _m = createHashMap;
    {_m set [_x # 0, false]} forEach _defs;
    _m
};

private _pools = createHashMapFromArray [
    ["west", ["B_Quadbike_01_F","B_G_Offroad_01_F","B_G_Offroad_01_armed_F","B_APC_Wheeled_01_cannon_F","B_MBT_01_cannon_F","B_Heli_Light_01_F","B_Heli_Transport_01_F","B_Plane_CAS_01_dynamicLoadout_F"]],
    ["east", ["O_Quadbike_01_F","O_G_Offroad_01_F","O_G_Offroad_01_armed_F","O_APC_Wheeled_02_rcws_v2_F","O_MBT_02_cannon_F","O_Heli_Light_02_unarmed_F","O_Heli_Transport_04_F","O_Plane_CAS_02_dynamicLoadout_F"]],
    ["independent", ["I_Quadbike_01_F","I_G_Offroad_01_F","I_G_Offroad_01_armed_F","I_APC_Wheeled_03_cannon_F","I_MBT_03_cannon_F","I_Heli_light_03_unarmed_F","I_Heli_Transport_02_F","I_Plane_Fighter_03_dynamicLoadout_F"]]
];

private _names = createHashMapFromArray [["west","NATO"],["east","CSAT"],["independent","AAF"]];
private _personalities = createHashMapFromArray [["west","balanced"],["east","aggressive"],["independent","defensive"]];
private _params = createHashMapFromArray [
    ["west", ["TYR_WestController",0]],
    ["east", ["TYR_EastController",1]],
    ["independent", ["TYR_IndependentController",1]]
];

private _factions = createHashMap;
{
    private _id = _x;
    private _spec = _params get _id;
    private _ctrl = [_spec # 0, _spec # 1] call _controller;
    private _pool = (_pools get _id) select {isClass (configFile >> "CfgVehicles" >> _x)};
    private _commander = createHashMapFromArray [
        ["personality", _personalities get _id],
        ["difficulty", _difficulty],
        ["posture", "balanced"],
        ["objective", ""],
        ["reserveRatio", 0.2]
    ];
    private _f = createHashMapFromArray [
        ["id", _id],
        ["name", _names get _id],
        ["active", _ctrl isNotEqualTo "disabled"],
        ["eliminated", false],
        ["controller", _ctrl],
        ["basePosition", []],
        ["baseConfirmed", false],
        ["resources", createHashMapFromArray [["steel",_start],["ammo",_start],["fuel",_start],["manpower",_manpower]]],
        ["research", call _makeResearch],
        ["vlsTargets", []],
        ["vehiclePool", _pool],
        ["commander", _commander],
        ["commanderPublic", []]
    ];
    _factions set [_id, _f];
} forEach ["west","east","independent"];

private _stamp = systemTime;
private _campaignId = format ["TYR_%1%2%3_%4_%5", _stamp # 0, _stamp # 1, _stamp # 2, floor serverTime, floor random 1000000];

createHashMapFromArray [
    ["campaign", createHashMapFromArray [
        ["formatVersion",2],
        ["id",_campaignId],
        ["world",worldName],
        ["phase","deployment"],
        ["created",_stamp],
        ["nextId",1],
        ["deployment",createHashMapFromArray [["rotation",0],["buffer",2500],["sectors",createHashMap]]],
        ["settings",createHashMapFromArray [
            ["captureTime",90],
            ["captureRange",175],
            ["economyInterval",75],
            ["factoryMultiplier",1.25]
        ]]
    ]],
    ["factions",_factions],
    ["locations",createHashMap],
    ["players",createHashMap],
    ["vehicles",createHashMap],
    ["emplacements",createHashMap],
    ["forces",createHashMap],
    ["operations",createHashMap],
    ["destroyedBuildings",[]]
]
