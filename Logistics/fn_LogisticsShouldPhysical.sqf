params ["_job",["_position",[]]];
if (!isServer || {count _position < 2}) exitWith {false};
private _fid = _job getOrDefault ["faction",""];
private _side = [_fid] call TYR_fnc_FactionSide;

// Human presence always makes the convoy worth physically simulating.
if ((allPlayers findIf {alive _x && {_x distance2D _position <= 4500}}) >= 0) exitWith {true};

// Hostile fighting units near the route can actually intercept it, even if no
// human is nearby. This uses server truth only for simulation relevance; it is
// never exposed as faction intelligence.
if ((allUnits findIf {
    alive _x && {(side group _x) isNotEqualTo civilian} && {(side group _x) isNotEqualTo _side} && {_x distance2D _position <= 3200}
}) >= 0) exitWith {true};

// Active strategic objectives make the area relevant enough to keep the convoy real.
private _ops = TYR_State getOrDefault ["operations",createHashMap];
if (((keys _ops) findIf {
    private _o = _ops get _x;
    private _phase = _o getOrDefault ["phase",""];
    private _p = +(_o getOrDefault ["targetPosition",[]]);
    !(_phase in ["complete","failed"]) && {count _p >= 2} && {_p distance2D _position <= 2500}
}) >= 0) exitWith {true};
false
