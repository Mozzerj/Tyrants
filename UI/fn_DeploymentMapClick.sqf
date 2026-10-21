params ["_position"];
if (isNil "TYR_ClientState" || {isNil "TYR_PlayerFaction"}) exitWith {};
if !(_position isEqualType [] && {count _position >= 2}) exitWith {};

private _clicked = [_position # 0,_position # 1,0];
missionNamespace setVariable ["TYR_DeploymentLastClicked",_clicked];
missionNamespace setVariable ["TYR_DeploymentPending",_clicked];
missionNamespace setVariable ["TYR_DeploymentCollisions",[]];

private _campaign = TYR_ClientState getOrDefault ["campaign",[]];
if (count _campaign < 2 || {(_campaign # 0) isNotEqualTo "deployment"}) exitWith {
    missionNamespace setVariable ["TYR_DeploymentLastCheck",[false,"DEPLOYMENT IS NOT CURRENTLY ACCEPTING HQ SELECTIONS",0,0,0]];
    [] call TYR_fnc_DeploymentMenuRefresh;
};

private _f = (TYR_ClientState get "factions") getOrDefault [TYR_PlayerFaction,[]];
if (count _f < 12) exitWith {};
if ((_f # 3) isNotEqualTo "human") exitWith {hint "This faction uses an AI strategic commander."};
if (_f # 11) exitWith {hint "Your faction HQ is already confirmed."};

private _deployment = _campaign # 1;
private _sectorEntry = (_deployment # 2) select {
    _x isEqualType [] && {count _x >= 2} && {(_x # 0) isEqualTo TYR_PlayerFaction}
};
if (count _sectorEntry isEqualTo 0) exitWith {
    missionNamespace setVariable ["TYR_DeploymentLastCheck",[false,"NO DEPLOYMENT REGION DATA FOR YOUR FACTION",0,0,0]];
    [] call TYR_fnc_DeploymentMenuRefresh;
};

private _sector = (_sectorEntry # 0) # 1;
private _buffer = _deployment # 1;
private _check = [_clicked,_sector,_buffer] call TYR_fnc_DeploymentCheckPosition;
private _collisions = [_clicked,20,15] call TYR_fnc_DeploymentFindCollisions;

// The cursor is authoritative: never search for or substitute a nearby point.
missionNamespace setVariable ["TYR_DeploymentLastCheck",_check];
missionNamespace setVariable ["TYR_DeploymentCollisions",_collisions];

// Map Draw lines proved unreliable on the embedded deployment map. Use the same
// local-marker rendering path as the sector colours so the exact footprint and
// collision boxes are always visible.
private _oldMarkers = missionNamespace getVariable ["TYR_DeploymentPlacementMarkers",[]];
{
    if (_x isEqualType "" && {_x isNotEqualTo ""}) then {deleteMarkerLocal _x};
} forEach _oldMarkers;

private _markers = [];
private _ownerTag = if (isMultiplayer) then {str clientOwner} else {"SP"};
private _serial = floor (diag_tickTime * 1000);

private _makeRect = {
    params ["_name","_pos","_size","_dir","_colour",["_alpha",0.95]];
    createMarkerLocal [_name,_pos];
    _name setMarkerShapeLocal "RECTANGLE";
    _name setMarkerBrushLocal "Solid";
    _name setMarkerSizeLocal _size;
    _name setMarkerDirLocal _dir;
    _name setMarkerColorLocal _colour;
    _name setMarkerAlphaLocal _alpha;
    _markers pushBack _name;
};

private _makeBox = {
    params ["_prefix","_centre","_halfW","_halfD",["_dir",0],"_colour",["_thickness",2.5]];
    private _right = [cos _dir,-sin _dir];
    private _forward = [sin _dir,cos _dir];
    private _top = [
        (_centre # 0) + ((_forward # 0) * _halfD),
        (_centre # 1) + ((_forward # 1) * _halfD),0
    ];
    private _bottom = [
        (_centre # 0) - ((_forward # 0) * _halfD),
        (_centre # 1) - ((_forward # 1) * _halfD),0
    ];
    private _left = [
        (_centre # 0) - ((_right # 0) * _halfW),
        (_centre # 1) - ((_right # 1) * _halfW),0
    ];
    private _rightPos = [
        (_centre # 0) + ((_right # 0) * _halfW),
        (_centre # 1) + ((_right # 1) * _halfW),0
    ];
    [format ["%1_T",_prefix],_top,[_halfW,_thickness],_dir,_colour] call _makeRect;
    [format ["%1_B",_prefix],_bottom,[_halfW,_thickness],_dir,_colour] call _makeRect;
    [format ["%1_L",_prefix],_left,[_thickness,_halfD],_dir,_colour] call _makeRect;
    [format ["%1_R",_prefix],_rightPos,[_thickness,_halfD],_dir,_colour] call _makeRect;
};

private _hqColour = if (_check # 0) then {"ColorGreen"} else {"ColorRed"};
private _hqPrefix = format ["TYR_DEPLOY_HQ_%1_%2",_ownerTag,_serial];
[_hqPrefix,_clicked,20,15,0,_hqColour,1.5] call _makeBox;

private _hqLabel = format ["%1_C",_hqPrefix];
createMarkerLocal [_hqLabel,_clicked];
_hqLabel setMarkerShapeLocal "ICON";
_hqLabel setMarkerTypeLocal "mil_dot";
_hqLabel setMarkerColorLocal _hqColour;
_hqLabel setMarkerSizeLocal [0.85,0.85];
_hqLabel setMarkerTextLocal "HQ FOOTPRINT 40 x 30m";
_markers pushBack _hqLabel;

{
    if (_x isEqualType [] && {count _x >= 6}) then {
        _x params ["_obj","_kind","_centre","_halfW","_halfD","_dir"];
        private _prefix = format ["TYR_DEPLOY_COLL_%1_%2_%3",_ownerTag,_serial,_forEachIndex];
        [_prefix,_centre,_halfW,_halfD,_dir,"ColorRed",1.6] call _makeBox;

        private _label = format ["%1_C",_prefix];
        createMarkerLocal [_label,_centre];
        _label setMarkerShapeLocal "ICON";
        _label setMarkerTypeLocal "mil_dot";
        _label setMarkerColorLocal "ColorRed";
        _label setMarkerSizeLocal [0.55,0.55];
        _label setMarkerTextLocal format ["COLLISION: %1",_kind];
        _markers pushBack _label;
    };
} forEach _collisions;

missionNamespace setVariable ["TYR_DeploymentPlacementMarkers",_markers];

// The exact 40 x 30 m footprint is deliberately compact. On the first click,
// zoom in enough to fine-tune placement without moving the selected centre.
disableSerialization;
private _display = findDisplay 1300;
if (!isNull _display) then {
    private _map = _display displayCtrl 1000;
    if (!isNull _map && {(ctrlMapScale _map) > 0.012}) then {
        _map ctrlMapAnimAdd [0.18,0.005,_clicked];
        ctrlMapAnimCommit _map;
    };
};

[] call TYR_fnc_DeploymentMenuRefresh;
