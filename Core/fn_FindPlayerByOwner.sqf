params ["_owner"];
private _index = allPlayers findIf {owner _x isEqualTo _owner};
if (_index < 0) exitWith {objNull};
allPlayers # _index
