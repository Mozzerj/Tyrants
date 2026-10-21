private _emplacementDefs = [] call TYR_fnc_GetEmplacementDefinitions;
private _emplacementKeys = _emplacementDefs apply {_x # 0};
[(count (_emplacementKeys arrayIntersect _emplacementKeys)) isEqualTo (count _emplacementKeys), "Emplacement keys are unique", format ["Definitions: %1", count _emplacementDefs], "Duplicate emplacement keys found"] call _check;

private _missingImplementedClasses = [];
{
    if ((_x # 5) && {!(isClass (configFile >> "CfgVehicles" >> (_x # 4)))}) then {
        _missingImplementedClasses pushBack (_x # 4);
    };
} forEach _emplacementDefs;
[_missingImplementedClasses isEqualTo [], "Implemented emplacement classes exist", "", str _missingImplementedClasses] call _check;
[isClass (configFile >> "CfgAmmo" >> "ammo_Missile_Cruise_01"), "Cruise missile ammo class exists", "ammo_Missile_Cruise_01 available", "Cruise missile ammo class is unavailable"] call _check;
[isClass (configFile >> "CfgVehicles" >> "ArtilleryTargetW"), "Cruise missile target class exists", "ArtilleryTargetW available", "ArtilleryTargetW is unavailable"] call _check;

// Engine object-instantiation check, server-local only and immediately cleaned up.
private _vlsLocal = objNull;
if (isClass (configFile >> "CfgVehicles" >> "B_Ship_MRLS_01_F")) then {
    _vlsLocal = createVehicleLocal ["B_Ship_MRLS_01_F", [worldSize / 2, worldSize / 2, 1000], [], 0, "NONE"];
};
[!isNull _vlsLocal, "VLS class instantiates in engine", "Server-local test object created and removed", "B_Ship_MRLS_01_F could not be instantiated"] call _check;
if (!isNull _vlsLocal) then {deleteVehicle _vlsLocal};

if (_sideIndex in [0, 1]) then {
    private _teamIndex = _sideIndex + 1;

    // Missing prerequisite must reject without taking steel.
    private _beforeSteel = GameData # 0 # _teamIndex # 1;
    ["proc.heavy"] call TYR_fnc_ServerPurchaseResearch;
    private _prereqRejected = !([_sideIndex, "proc.heavy"] call TYR_fnc_IsResearchUnlocked) && {(GameData # 0 # _teamIndex # 1) isEqualTo _beforeSteel};
    [_prereqRejected, "Research prerequisite rejection", "Heavy Armour stayed locked and steel was unchanged", "Research unlocked or steel changed despite missing prerequisite"] call _check;

    // Successful purchase must unlock and deduct exact cost.
    _beforeSteel = GameData # 0 # _teamIndex # 1;
    ["proc.armored"] call TYR_fnc_ServerPurchaseResearch;
    private _armoredUnlocked = [_sideIndex, "proc.armored"] call TYR_fnc_IsResearchUnlocked;
    private _armoredCharged = (GameData # 0 # _teamIndex # 1) isEqualTo (_beforeSteel - 30000);
    [_armoredUnlocked && {_armoredCharged}, "Research purchase transaction", "Armoured Procurement unlocked for exactly 30,000 steel", format ["Unlocked %1, steel %2 -> %3", _armoredUnlocked, _beforeSteel, GameData # 0 # _teamIndex # 1]] call _check;

    // Duplicate purchase must not charge twice.
    _beforeSteel = GameData # 0 # _teamIndex # 1;
    ["proc.armored"] call TYR_fnc_ServerPurchaseResearch;
    [(GameData # 0 # _teamIndex # 1) isEqualTo _beforeSteel, "Duplicate research is not charged", "Steel unchanged", "Duplicate purchase changed steel"] call _check;

    // Dependent research should now succeed and unlock the tank category.
    _beforeSteel = GameData # 0 # _teamIndex # 1;
    ["proc.heavy"] call TYR_fnc_ServerPurchaseResearch;
    private _heavyOK = [_sideIndex, "proc.heavy"] call TYR_fnc_IsResearchUnlocked;
    private _heavyCostOK = (GameData # 0 # _teamIndex # 1) isEqualTo (_beforeSteel - 35000);
    [_heavyOK && {_heavyCostOK}, "Dependent research unlock", "Heavy Armour unlocked for exactly 35,000 steel", "Heavy Armour purchase failed or charged wrong amount"] call _check;
    [[_sideIndex, 4] call TYR_fnc_IsVehicleCategoryUnlocked, "Tank procurement gate follows Heavy Armour", "Tank category unlocked", "Tank category remained locked"] call _check;

    // An untouched autonomous gate should still be closed.
    [!([_sideIndex, 10] call TYR_fnc_IsVehicleCategoryUnlocked), "Autonomous procurement remains gated", "UGV category still locked", "UGV category unlocked too early"] call _check;

    // VLS target requests are gated by offensive emplacement research.
    GameData # 0 # _teamIndex set [6, []];
    [[2000, 2000, 0]] call TYR_fnc_ServerAddVLSTarget;
    [(count (GameData # 0 # _teamIndex # 6)) isEqualTo 0, "VLS targets require research", "Target rejected while Offensive Emplacements was locked", "Target was stored without required research"] call _check;

    // Unlock offensive research directly for target-storage boundary testing.
    private _offensiveDef = (_researchDefs select {(_x # 0) isEqualTo "infra.offensive"}) # 0;
    private _progress = +(GameData # 0 # _teamIndex # 5);
    private _infraBranch = +(_progress # (_offensiveDef # 2));
    _infraBranch set [_offensiveDef # 3, 1];
    _progress set [_offensiveDef # 2, _infraBranch];
    GameData # 0 # _teamIndex set [5, _progress];

    for "_i" from 0 to 18 do {
