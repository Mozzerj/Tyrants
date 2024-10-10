systemChat "Location Setup";

_Towns = nearestLocations [[0,0,0], ["NameCity", "NameVillage"], 999999];
_Cities = nearestLocations [[0,0,0], ["NameCityCapital"], 999999];
_factory = nearestObjects [[0,0,0], ["Land_dp_mainFactory_F", "Land_Factory_Main_F","Land_DPP_01_smallFactory_F"], 999999];
_Hangers = nearestObjects [[0,0,0], ["Land_Hangar_F","Land_TentHangar_V1_F","Land_Airport_01_hangar_F"], 999999];
_Helipads = nearestObjects [[0,0,0], ["Land_HelipadCircle_F","Land_HelipadSquare_F"], 999999];
_LargeTowers = nearestObjects [[0,0,0], ["Land_Cargo_Tower_V1_F", "Land_Cargo_Tower_V3_F","Land_Cargo_Tower_V4_F","Land_Cargo_HQ_V1_F","Land_Cargo_HQ_V3_F","Land_Cargo_HQ_V4_F"], 999999];
_SmallTowers = nearestObjects [[0,0,0], ["Land_Cargo_Patrol_V4_F", "Land_Cargo_House_V4_F", "Land_Cargo_House_V1_F", "Land_Cargo_House_V3_F","Land_Cargo_Patrol_V1_F",""], 999999];
_Towers = _LargeTowers + _SmallTowers;

// Town/City Data [_Town, _WSide, _ESide, _ASide ,Position, _popcount]
// factoryBuilding Data [_Factory, _WSide, _ESide ,_ASide ,Position, [FactoryID], Resource, ResourceType]

LocationData = [];

//[Type, locationArray, saveLocation]
_GroupData = [];
{
	
	
	_Town = format ["Town_%1",_forEachIndex];

	_GroupData append [[_Town,  "ColorGUER",  "ColorGUER",  "ColorGUER", (LocationPosition _x), 0, 0]];
	
} forEach _Towns;

LocationData set [0,_GroupData];
_GroupData = [];

{
	
	
	_City = format ["City_%1",_forEachIndex];

	_GroupData append [[_City,  "ColorGUER",  "ColorGUER",  "ColorGUER", (LocationPosition _x), 0, 0]];
	
} forEach _Cities;

LocationData set [1,_GroupData];

factoryBuildingsGroup = [];


// takes all the factory buildings and puts them into groups based on position
while {count _factory > 0} do {

	_factoryBuilding = (_factory select 0); 
	
    _pregroup = [_factoryBuilding]; 
	
	_factory deleteAt (_factory find _factoryBuilding); 
    _toRemove = [];
	
	{
	
		if (((getPos _factoryBuilding) distance (getPos _x)) < 250) then {
			
			_pregroup pushBack _x;
			_toRemove pushBack _x; 
		
		};
	
	}forEach _factory;
	
	{
        _factory deleteAt (_factory find _x); 
    } forEach _toRemove;
	
	factoryBuildingsGroup pushBack (_pregroup);

};


factories = [];
// takes the groups of factories and adds the appropriate data to the group // also adds fuel tanks to the group
{
	factory = [];
	factory set [5, _x]; 
	
	factory = [(format ["factory_%1", _forEachIndex]),"ColorGUER","ColorGUER","ColorGUER",0,_x,0];

	GroupToProcess = _x;
	xpos = 0;
	ypos = 0;
	Zpos = 0;
	
	{
		
		factoryBuilding = _x;
		xpos = xpos + ((getPos factoryBuilding) select 0);
		ypos = ypos + ((getPos factoryBuilding) select 1);
		Zpos = Zpos + ((getPos factoryBuilding) select 2);	
	
	}forEach groupToProcess;
	
	groupCount = (count GroupToProcess);
	averagePos = [xpos/groupCount, ypos/groupCount, Zpos/groupCount];

	fuelTanks = nearestObjects [averagePos, ["Land_dp_bigTank_F", "Land_dp_smallTank_F"], 200];
	
	{
		(factory select 5) pushBack _x;
	}forEach fuelTanks;

	factory = [(format ["factory_%1", _forEachIndex]),"ColorGUER","ColorGUER","ColorGUER",averagePos,_x,0, 0, 0];
	
	factories pushBack factory;

}forEach factoryBuildingsGroup;


// sets what the factories will make
for "_i" from 0 to (count factories) do {

	factoriesTypes = ["Fuel","Steel","Ammo","Fuel","Steel","Ammo","Fuel","Steel","Ammo","Fuel","Steel","Ammo","Fuel","Steel","Ammo"];
	
	(factories select _i) set [7, (factoriesTypes select _i)];

};
	
LocationData set [2, factories];

GameData set [1, LocationData];	

publicVariable "GameData";

