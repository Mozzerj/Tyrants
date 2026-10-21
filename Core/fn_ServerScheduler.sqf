if (!isServer) exitWith {};
[] spawn {
    private _settings = (TYR_State get "campaign") get "settings";
    private _nextEconomy = serverTime + (_settings getOrDefault ["economyInterval",75]);
    private _nextOps = serverTime + 3;
    private _nextObservation = serverTime + 2;
    private _nextCommandNetwork = serverTime + 1;
    private _nextProduction = serverTime + 2;
    private _nextLogistics = serverTime + 3;
    private _nextLogisticsPlan = serverTime + 8;
    private _nextProductionAI = createHashMapFromArray [["west",serverTime+5],["east",serverTime+10],["independent",serverTime+15]];
    private _nextCommander = createHashMapFromArray [["west",serverTime+2],["east",serverTime+7],["independent",serverTime+12]];
    while {true} do {
        sleep 1;
        if (((TYR_State get "campaign") getOrDefault ["phase","deployment"]) isEqualTo "running") then {
            // Only active capture sessions are evaluated; there is no global per-frame territory scan.
            call TYR_fnc_ServerTerritoryTick;

            if (serverTime >= _nextCommandNetwork) then {
                call TYR_fnc_ServerCommandTick;
                _nextCommandNetwork = serverTime + 2;
            };

            if (serverTime >= _nextObservation) then {
                call TYR_fnc_ServerObservationTick;
                _nextObservation = serverTime + 4;
            };

            if (serverTime >= _nextProduction) then {
                call TYR_fnc_ServerProductionTick;
                _nextProduction = serverTime + 2;
            };

            if (serverTime >= _nextLogistics) then {
                call TYR_fnc_ServerLogisticsTick;
                _nextLogistics = serverTime + 3;
            };

            if (serverTime >= _nextLogisticsPlan) then {
                call TYR_fnc_ServerLogisticsPlanner;
                _nextLogisticsPlan = serverTime + 12;
            };

            if (serverTime >= _nextOps) then {
                call TYR_fnc_AIOperationsTick;
                _nextOps = serverTime + 5;
            };

            if (serverTime >= _nextEconomy) then {
                call TYR_fnc_ServerEconomyTick;
                _nextEconomy = serverTime + (_settings getOrDefault ["economyInterval",75]);
            };

            {
                if (serverTime >= (_nextProductionAI getOrDefault [_x,0])) then {
                    [_x] call TYR_fnc_ServerProductionAIPlan;
                    _nextProductionAI set [_x,serverTime + 25];
                };
            } forEach ["west","east","independent"];

            // At most one commander gets a strategic thinking slice in any scheduler second.
            private _processed = false;
            {
                if (!_processed && {serverTime >= (_nextCommander getOrDefault [_x,0])}) then {
                    private _f = [_x] call TYR_fnc_StateGetFaction;
                    if ((_f getOrDefault ["controller","human"]) isEqualTo "ai" && {_f getOrDefault ["active",false]}) then {
                        [_x] call TYR_fnc_AICommanderThink;
                    };
                    private _difficulty = (_f getOrDefault ["commander",createHashMap]) getOrDefault ["difficulty",1];
                    private _interval = switch (_difficulty) do {case 0:{30};case 2:{15};case 3:{10};default {20}};
                    _nextCommander set [_x,serverTime+_interval];
                    _processed = true;
                };
            } forEach ["west","east","independent"];
        };
    };
};
