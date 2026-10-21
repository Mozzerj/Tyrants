// Full spectator during the respawn delay, but never grant enemy intelligence.
// The spectator can follow friendly players/AI; free camera is disabled so a dead
// player cannot roam into hostile territory and bypass Tyrants' observation rules.
if (hasInterface) then {
    ["Initialize",[player,[playerSide],true,false,true,true,true,true,true,true]] call BIS_fnc_EGSpectator;
};
