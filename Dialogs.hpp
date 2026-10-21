#include "DialogsLegacy.hpp"

// Thin Tyrants-specific wrappers keep the generated legacy layout untouched.
// Only stable IDs and mission-owned actions are overridden here.
class TYR_SetupMenu : SetupMenu
{
    idd = 1100;
};

class TYR_SetupMenuVehicles : SetupMenuVehicles
{
    idd = 1101;
};

class TYR_SetupMenuFactions : SetupMenuFactions
{
    idd = 1102;
    class Controls : Controls
    {
        class Continue : Continue { idc = 6; };
    };
};

class TYR_PlayerMenu : TyrPlayerMenu
{
    idd = 1200;
    class Controls : Controls
    {
        class CollectResources : CollectResources
        {
            onButtonClick = "[] spawn TYR_fnc_GetFactoryResource;";
        };
        class BuyVehicle : BuyVehicle
        {
            onButtonClick = "createDialog 'TYR_VehicleBuyMenu';";
        };
        class HireSquads : HireSquads
        {
            onButtonClick = "createDialog 'TYR_AIHireMenu';";
        };
        class BuyEmplacement : BuyEmplacement
        {
            idc = 7;
            onButtonClick = "createDialog 'TYR_AIHireMenu';";
        };
    };
};

class TYR_VehicleBuyMenu : TyrVehicleBuyMenu
{
    idd = 1201;
    onLoad = "[] spawn TYR_fnc_VehicleBuyMenu";

    class ControlsBackground : ControlsBackground
    {
        class Background : Background { onLoad = ""; };
    };

    class Controls : Controls
    {
        class BuyVehicle : BuyVehicle
        {
            onButtonClick = "[lbData[4, lbCurSel 4]] spawn TYR_fnc_VehicleBuy";
        };
        class ButtonLeft : ButtonLeft
        {
            onButtonClick = "TYR_vehicleCategorySelection = TYR_vehicleCategorySelection - 1";
        };
        class ButtonRight : ButtonRight
        {
            onButtonClick = "TYR_vehicleCategorySelection = TYR_vehicleCategorySelection + 1";
        };
    };
};

class TYR_AIHireMenu : TyrAIHireMenu
{
    idd = 1202;
    class Controls : Controls
    {
        class ButtonLeft : ButtonLeft
        {
            idc = 20;
            onButtonClick = "TYR_aiHireSelection = TYR_aiHireSelection - 1";
        };
        class ButtonRight : ButtonRight
        {
            onButtonClick = "TYR_aiHireSelection = TYR_aiHireSelection + 1";
        };
    };
};
