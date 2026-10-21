if (!isServer) exitWith {};
if (count (GameData # 1) < 3) exitWith {};

private _factoryData = GameData # 1 # 2;
private _settings = GameData # 0 # 0 param [1, []];
private _factoryMultiplier = _settings param [6, 1];

{
    private _resource = _x # 6;
    private _production = 0;
    private _parts = _x # 5;

    {
        private _class = toLower typeOf _x;
        private _output = 0;

        if (_class find "dp_mainfactory_f" >= 0 || {_class find "factory_main_f" >= 0}) then {_output = 250};
        if (_class find "dp_bigtank_f" >= 0 || {_class find "storagetank_01_large_f" >= 0}) then {_output = 125};
        if (_class find "dp_smalltank_f" >= 0 || {_class find "storagetank_01_small_f" >= 0}) then {_output = 75};

        if (_output > 0) then {
            _production = _production + ((1 - damage _x) * _output);
        };
    } forEach _parts;

    private _ownerSideIndex = ["ColorWEST", "ColorEAST"] find (_x # 3);
    private _researchMultiplier = 1;
    if (_ownerSideIndex >= 0 && {[_ownerSideIndex, "infra.factory"] call TYR_fnc_IsResearchUnlocked}) then {
        _researchMultiplier = 1.25;
    };
    _resource = (_resource + (_production * _factoryMultiplier * _researchMultiplier)) min 50000;
    _x set [6, _resource];
} forEach _factoryData;

GameData # 1 set [2, _factoryData];
