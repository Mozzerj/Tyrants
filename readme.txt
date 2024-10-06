// Access the display and controls
_display = findDisplay 5030;
_Lb = _display displayCtrl 3; // List box control
_Image = _display displayCtrl 4; // Image control (if needed)
_VehNameBar = _display displayCtrl 10;
_VehCostBar = _display displayCtrl 11;
_VehCapBar = _display displayCtrl 12;
_Lbweapons = _display displayCtrl 13;

// Get vehicle classes with required conditions
_cfgs = ("((str (_x >> 'editorPreview') != '<NULL-config>') && ((getNumber(_x >> 'hasDriver')) != 0) && ((getText (_x >> 'aiBrainType')) == ''))" configClasses (configFile >> "CfgVehicles"));

// Sort vehicle classes
_cfgs sort true;

// Iterate through all vehicle classes in CfgVehicles
_cfgsVeh = [];
{
    _Vehicle = configName _x; // Get the class name of the vehicle
    _cfgsVeh pushBack _Vehicle;
    _VehName = getText (configFile >> "CfgVehicles" >> _Vehicle >> "displayname");
    
    // Add the vehicle name to the list box
    _Lb lbAdd _VehName;
} forEach _cfgs;

// Define the event handler function
fnc_updateVehicleDisplay = {
    private ["_index", "_Vehicle", "_imagePath", "_VehName", "_Cost", "_VehCap", "_testVeh", "_testVehWeapons", "_weapon"];
    
    // Get the current index and vehicle
    _index = lbcursel _Lb;
    if (_index >= 0) then {
        _Vehicle = _cfgsVeh select _index;

        // Fetch vehicle details
        _imagePath = format ["%1", getText (configfile >> "CfgVehicles" >> _Vehicle >> "editorPreview")];
        _VehName = getText (configFile >> "CfgVehicles" >> _Vehicle >> "displayname");
        _Cost = getNumber (configFile >> "CfgVehicles" >> _Vehicle >> "cost");
        _VehCap = getNumber (configFile >> "CfgVehicles" >> _Vehicle >> "transportSoldier");

        // Update the UI elements
        _Image ctrlSetText _imagePath;
        _VehNameBar ctrlSetText format ["   %1", _VehName];
        _VehCostBar ctrlSetText format ["   Cost: %1", _Cost];
        _VehCapBar ctrlSetText format ["   Capacity: %1", _VehCap];

        // Initialize weapon list
        lbClear _Lbweapons;

        // Create a temporary vehicle to get its weapons
        _testVeh = _Vehicle createVehicle [0, 0, 100];
        _testVehWeapons = weapons _testVeh;
        deleteVehicle _testVeh;

        // Populate the weapons list
        {
            _weapon = _x splitString "_" joinString " ";
            _Lbweapons lbAdd _weapon;
        } forEach _testVehWeapons;

        // Optional sleep for smoother UI updates
        sleep 1;
    };
};

// Initialize the total ammo volume
_ammoVolume = 0;

// Loop through all magazine class names
{
    _x = _forEachIndex; // This will represent each magazine class name in the array

    // Get the ammo count and ammo type from the config
    _AmmoCount = getNumber(configFile >> "cfgMagazines" >> _x >> "count");
    _AmmoType = getText(configFile >> "cfgMagazines" >> _x >> "ammo");

    // Check if ammo type is valid
    if (!isNull _AmmoType) then {
        // Create an instance of the ammo type at a dummy position
        _AmmoVeh = _AmmoType createVehicle [0, 0, 0];

        // Get the bounding box of the ammo vehicle
        _AmmoSize = boundingBox _AmmoVeh;
        deleteVehicle _AmmoVeh; // Clean up the created ammo instance

        // Extract max and min corners of the bounding box
        _max = _AmmoSize select 1;
        _min = _AmmoSize select 0;

        // Calculate dimensions (width, height, depth)
        _width = _max select 0 - _min select 0; // Width (X-axis)
        _height = _max select 1 - _min select 1; // Height (Y-axis)
        _depth = _max select 2 - _min select 2; // Depth (Z-axis)

        // Calculate the volume of this ammunition type
        _volume = _width * _height * _depth;

        // Accumulate total ammo volume
        _ammoVolume = _ammoVolume + (_volume * _AmmoCount);
    };
} forEach configClasses(configFile >> "cfgMagazines");

// Display the total ammo volume
hint format ["Total Ammo Volume: %1 cubic meters", _ammoVolume]; // Volume in cubic meters
