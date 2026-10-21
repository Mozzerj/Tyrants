params ["_sideIndex", "_key"];
if !(_sideIndex in [0, 1]) exitWith {false};
if (isNil "GameData") exitWith {false};

private _definition = ([] call TYR_fnc_GetResearchDefinitions) select {(_x # 0) isEqualTo _key};
if (_definition isEqualTo []) exitWith {false};
_definition = _definition # 0;

private _team = GameData # 0 # (_sideIndex + 1);
private _progress = _team param [5, [[0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]]];
private _branch = _definition # 2;
private _node = _definition # 3;
((_progress param [_branch, []]) param [_node, 0]) isEqualTo 1
