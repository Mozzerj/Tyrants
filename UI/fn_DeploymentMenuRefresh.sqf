disableSerialization;
private _display = findDisplay 1300;
if (isNull _display || {isNil "TYR_ClientState"} || {isNil "TYR_PlayerFaction"}) exitWith {};
private _campaign = TYR_ClientState getOrDefault ["campaign",[]];
private _factions = TYR_ClientState get "factions";
private _f = _factions getOrDefault [TYR_PlayerFaction,[]];
if (count _campaign < 2 || {count _f < 12}) exitWith {};
private _phase = _campaign # 0;
private _deployment = if (count _campaign >= 2) then {_campaign # 1} else {[]};
private _sectorPairs = if (_deployment isEqualType [] && {count _deployment >= 3}) then {_deployment # 2} else {[]};
private _ownSectorEntries = _sectorPairs select {_x isEqualType [] && {count _x >= 2} && {(_x # 0) isEqualTo TYR_PlayerFaction}};
private _hasOwnSector = count _ownSectorEntries > 0;
private _name = _f # 1;
(_display displayCtrl 101) ctrlSetText format ["%1 // DEPLOYMENT",toUpper _name];

private _regionCount = count _sectorPairs;
private _intel = if (_regionCount > 0) then {
    format ["%1 DEPLOYMENT REGIONS LOADED\n\nThe coloured regions are known starting areas. Enemy HQ coordinates are NOT shared. LEFT-CLICK to place an exact 40 x 30 m HQ footprint. GREY NO-HQ corridors apply equally to every faction border. Red hollow boxes show hard physical obstructions; roads do not block placement. Move your click until the HQ box turns green.",_regionCount]
} else {
    "NO DEPLOYMENT REGION DATA RECEIVED\n\nThe server has not supplied deployment-sector geometry yet."
};
(_display displayCtrl 102) ctrlSetText _intel;

private _readyLines = [];
{
    private _fr = _x;
    if (count _fr > 11 && {_fr # 2}) then {
        _readyLines pushBack format ["%1  %2",toUpper (_fr # 1),if (_fr # 11) then {"READY"} else {"SELECTING HQ..."}];
    };
} forEach values _factions;
(_display displayCtrl 105) ctrlSetText (_readyLines joinString toString [10]);

private _controller = _f # 3;
private _confirmed = _f # 11;
private _pending = missionNamespace getVariable ["TYR_DeploymentPending",[]];
if (_confirmed && {count _pending > 0}) then {missionNamespace setVariable ["TYR_DeploymentPending",[]];_pending=[]};
private _check = missionNamespace getVariable ["TYR_DeploymentLastCheck",[false,"CLICK INSIDE YOUR COLOURED REGION",0,0,0]];
private _status = "";
if (_phase isEqualTo "running") then {
    _status = "DEPLOYMENT COMPLETE // preparing combat insertion";
} else {
    if (!_hasOwnSector) then {
        _status = "WAITING FOR DEPLOYMENT REGION DATA...";
    } else {
    if (_controller isEqualTo "ai") then {
        _status = if (_confirmed) then {"AI COMMANDER HAS LOCKED YOUR HQ // waiting for other factions"} else {"AI COMMANDER IS EVALUATING HQ SITES..."};
    } else {
        if (_confirmed) then {_status = "HQ CONFIRMED // exact position hidden from hostile factions"} else {_status = _check # 1};
    };
    };
};
(_display displayCtrl 103) ctrlSetText _status;
private _canConfirm = _phase isEqualTo "deployment" && {_hasOwnSector} && {_controller isEqualTo "human"} && {!_confirmed} && {count _pending >= 2} && {_check # 0};
(_display displayCtrl 10) ctrlEnable _canConfirm;
(_display displayCtrl 10) ctrlSetText (if (_confirmed) then {"HQ LOCKED"} else {"CONFIRM HQ"});
