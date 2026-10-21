class TyrPlayerMenu
{
    idd = 1200;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = "[] call TYR_fnc_PlayerMenuRefresh;";

    class ControlsBackground
    {
        class Shade: TYR_UI_Text
        {
            x = safeZoneX + safeZoneW * 0.02;
            y = safeZoneY + safeZoneH * 0.08;
            w = safeZoneW * 0.31;
            h = safeZoneH * 0.84;
            colorBackground[] = {0.025,0.03,0.038,0.96};
        };
        class Accent: TYR_UI_Text
        {
            x = safeZoneX + safeZoneW * 0.02;
            y = safeZoneY + safeZoneH * 0.08;
            w = safeZoneW * 0.006;
            h = safeZoneH * 0.84;
            colorBackground[] = {0.851,0.5647,0.0863,1};
        };
        class Header: TYR_UI_Text
        {
            x = safeZoneX + safeZoneW * 0.026;
            y = safeZoneY + safeZoneH * 0.08;
            w = safeZoneW * 0.304;
            h = safeZoneH * 0.067;
            text = "TYRANTS // COMMAND";
            sizeEx = 0.043;
            colorBackground[] = {0.07,0.08,0.095,1};
        };
        class ResourcePanel: TYR_UI_Text
        {
            x = safeZoneX + safeZoneW * 0.04;
            y = safeZoneY + safeZoneH * 0.255;
            w = safeZoneW * 0.27;
            h = safeZoneH * 0.18;
            colorBackground[] = {0.055,0.065,0.075,1};
        };
    };

    class Controls
    {
        class Name: TYR_UI_Text {idc=1; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.16; w=safeZoneW*0.19; h=safeZoneH*0.035; sizeEx=0.035; text="COMMANDER";};
        class Rank: TYR_UI_Text {idc=2; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.198; w=safeZoneW*0.14; h=safeZoneH*0.03; sizeEx=0.026; colorText[]={0.62,0.66,0.71,1}; text="Private";};
        class Progress
        {
            type = 8;
            idc = 3;
            x = safeZoneX + safeZoneW * 0.19;
            y = safeZoneY + safeZoneH * 0.203;
            w = safeZoneW * 0.12;
            h = safeZoneH * 0.014;
            style = 0;
            colorBar[] = {0.851,0.5647,0.0863,1};
            colorFrame[] = {0.16,0.18,0.20,1};
            texture = "#(argb,8,8,3)color(1,1,1,1)";
        };

        class ResourceTitle: TYR_UI_Text {x=safeZoneX+safeZoneW*0.052; y=safeZoneY+safeZoneH*0.27; w=safeZoneW*0.24; h=safeZoneH*0.03; text="FACTION RESOURCES"; sizeEx=0.027; colorText[]={0.851,0.5647,0.0863,1};};
        class Steel: TYR_UI_Text {idc=20; x=safeZoneX+safeZoneW*0.052; y=safeZoneY+safeZoneH*0.31; w=safeZoneW*0.12; h=safeZoneH*0.03; text="Steel: --";};
        class Ammo: TYR_UI_Text {idc=21; x=safeZoneX+safeZoneW*0.18; y=safeZoneY+safeZoneH*0.31; w=safeZoneW*0.12; h=safeZoneH*0.03; text="Ammo: --";};
        class Fuel: TYR_UI_Text {idc=22; x=safeZoneX+safeZoneW*0.052; y=safeZoneY+safeZoneH*0.355; w=safeZoneW*0.12; h=safeZoneH*0.03; text="Fuel: --";};
        class Manpower: TYR_UI_Text {idc=23; x=safeZoneX+safeZoneW*0.18; y=safeZoneY+safeZoneH*0.355; w=safeZoneW*0.12; h=safeZoneH*0.03; text="Manpower: --";};
        class Context: TYR_UI_Text {idc=24; x=safeZoneX+safeZoneW*0.052; y=safeZoneY+safeZoneH*0.397; w=safeZoneW*0.24; h=safeZoneH*0.025; sizeEx=0.024; colorText[]={0.60,0.64,0.68,1}; text="";};

        class CollectResources: TYR_UI_ButtonAccent {idc=4; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.46; w=safeZoneW*0.27; h=safeZoneH*0.047; text="COLLECT FACTORY STOCKPILE"; onButtonClick="[] spawn TYR_fnc_GetFactoryResource; closeDialog 0;";};
        class BuyVehicle: TYR_UI_ButtonAccent {idc=5; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.515; w=safeZoneW*0.27; h=safeZoneH*0.047; text="VEHICLE PROCUREMENT"; onButtonClick="closeDialog 0; createDialog 'TyrVehicleBuyMenu';";};
        class Research: TYR_UI_Button {idc=8; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.57; w=safeZoneW*0.13; h=safeZoneH*0.047; text="RESEARCH"; onButtonClick="closeDialog 0; [] spawn TYR_fnc_OpenResearchMenu;";};
        class BuyEmplacement: TYR_UI_Button {idc=7; x=safeZoneX+safeZoneW*0.18; y=safeZoneY+safeZoneH*0.57; w=safeZoneW*0.13; h=safeZoneH*0.047; text="EMPLACEMENTS"; onButtonClick="closeDialog 0; [] call TYR_fnc_OpenEmplacementMenu;";};
        class HireSquads: TYR_UI_Button {idc=6; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.625; w=safeZoneW*0.27; h=safeZoneH*0.047; text="SQUAD COMMAND"; onButtonClick="closeDialog 0; createDialog 'TyrAIHireMenu';";};
        class Debug: TYR_UI_ButtonDanger {idc=9; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.705; w=safeZoneW*0.27; h=safeZoneH*0.047; text="DEVELOPER DEBUG"; onButtonClick="closeDialog 0; createDialog 'TyrDebugMenu';";};
        class Footer: TYR_UI_Text {x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.805; w=safeZoneW*0.27; h=safeZoneH*0.04; style=2; sizeEx=0.023; colorText[]={0.45,0.48,0.52,1}; text="Y // OPEN COMMAND PANEL";};
        class Close: TYR_UI_Button {x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.855; w=safeZoneW*0.27; h=safeZoneH*0.042; text="CLOSE"; onButtonClick="closeDialog 0;";};
    };
};
