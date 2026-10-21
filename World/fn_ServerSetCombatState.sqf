params ["_enabled"];
if (!isServer) exitWith {};
private _v = if (_enabled) then {0} else {1};
west setFriend [east,_v];
east setFriend [west,_v];
west setFriend [resistance,_v];
resistance setFriend [west,_v];
east setFriend [resistance,_v];
resistance setFriend [east,_v];
