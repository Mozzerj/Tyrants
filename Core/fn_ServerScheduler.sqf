if (!isServer) exitWith {};
[] spawn {
    private _settings = (TYR_State get "campaign") get "settings";
    private _nextEconomy = serverTime + (_settings getOrDefault ["economyInterval",75]);
    private _nextOps = serverTime + 3;
    private _nextObservation = serverTime + 2;
    private _nextCommander = createHashMapFromArray [["west",serverTime+2],["east",serverTime+7],["independent",serverTime+12]];
    while {true} do {
        sleep 1;
        if (((TYR_State get "campaign") getOrDefault ["phase","deployment"]) isEqualTo "running") then {
            // Only active capture sessions are evaluated; there is no global per-frame territory scan.
            call TYR_fnc_ServerTerritoryTick;

            if (serverTime >= _nextObservation) then {
                call TYR_fnc_ServerObservationTick;
                _nextObservation = serverTime + 4;
            };

            if (serverTime >= _nextOps) then {
                call TYR_fnc_AIOperationsTick;
                _nextOps = serverTime + 5;
            };

            if (serverTime >= _nextEconomy) then {
                call TYR_fnc_ServerEconomyTick;
                _nextEconomy = serverTime + (_settings getOrDefault ["economyInterval",75]);
            };

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
