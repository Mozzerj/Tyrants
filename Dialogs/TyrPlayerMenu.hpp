class TYR_PM_Text
{
    type = 0;
    idc = -1;
    style = 0;
    font = "PuristaMedium";
    sizeEx = 0.03;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0,0,0,0};
    text = "";
};

class TYR_PM_Button
{
    type = 1;
    idc = -1;
    style = 2;
    font = "PuristaMedium";
    sizeEx = 0.03;
    text = "";
    borderSize = 0;
    colorText[] = {0.05,0.05,0.05,1};
    colorDisabled[] = {0.45,0.45,0.45,1};
    colorBackground[] = {0.851,0.5647,0.0863,1};
    colorBackgroundDisabled[] = {0.16,0.17,0.18,1};
    colorBackgroundActive[] = {1,0.68,0.12,1};
    colorFocused[] = {0.851,0.5647,0.0863,1};
    colorShadow[] = {0,0,0,0};
    colorBorder[] = {0,0,0,0};
    offsetX = 0;
    offsetY = 0;
    offsetPressedX = 0.002;
    offsetPressedY = 0.002;
    soundEnter[] = {"",0,1};
    soundPush[] = {"",0,1};
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
    soundEscape[] = {"",0,1};
};

class TYR_PM_Progress
{
    type = 8;
    idc = -1;
    style = 0;
    colorBar[] = {0.851,0.5647,0.0863,1};
    colorFrame[] = {0.08,0.08,0.08,1};
    texture = "#(argb,8,8,3)color(1,1,1,1)";
};

class TyrPlayerMenu
{
    idd = 1200;
    movingEnable = 0;
    enableSimulation = 1;

    class ControlsBackground
    {
        class Backdrop: TYR_PM_Text
        {
            x = safeZoneX + safeZoneW * 0.02;
            y = safeZoneY + safeZoneH * 0.08;
            w = safeZoneW * 0.31;
            h = safeZoneH * 0.84;
            colorBackground[] = {0.035,0.04,0.045,0.96};
        };
        class Header: TYR_PM_Text
        {
            x = safeZoneX + safeZoneW * 0.02;
            y = safeZoneY + safeZoneH * 0.08;
            w = safeZoneW * 0.31;
            h = safeZoneH * 0.055;
            style = 2;
            sizeEx = 0.043;
            text = "TYRANTS // COMMAND";
            colorText[] = {0.05,0.05,0.05,1};
            colorBackground[] = {0.851,0.5647,0.0863,1};
        };
        class ProfilePanel: TYR_PM_Text
        {
            x = safeZoneX + safeZoneW * 0.035;
            y = safeZoneY + safeZoneH * 0.155;
            w = safeZoneW * 0.28;
            h = safeZoneH * 0.13;
            colorBackground[] = {0.08,0.085,0.09,1};
        };
        class ResourcePanel: TYR_PM_Text
        {
            x = safeZoneX + safeZoneW * 0.035;
            y = safeZoneY + safeZoneH * 0.305;
            w = safeZoneW * 0.28;
            h = safeZoneH * 0.12;
            colorBackground[] = {0.08,0.085,0.09,1};
        };
    };

    class Controls
    {
        class PlayerName: TYR_PM_Text
        {
            idc = 1;
            x = safeZoneX + safeZoneW * 0.05;
            y = safeZoneY + safeZoneH * 0.17;
            w = safeZoneW * 0.19;
            h = safeZoneH * 0.035;
            sizeEx = 0.034;
        };
        class PlayerRankLabel: TYR_PM_Text
        {
            x = safeZoneX + safeZoneW * 0.05;
            y = safeZoneY + safeZoneH * 0.215;
            w = safeZoneW * 0.07;
            h = safeZoneH * 0.03;
            text = "RANK";
            colorText[] = {0.65,0.65,0.65,1};
            sizeEx = 0.026;
        };
        class PlayerRank: TYR_PM_Text
        {
            idc = 2;
            x = safeZoneX + safeZoneW * 0.12;
            y = safeZoneY + safeZoneH * 0.215;
            w = safeZoneW * 0.17;
            h = safeZoneH * 0.03;
            style = 1;
            sizeEx = 0.028;
        };
        class RankProgress: TYR_PM_Progress
        {
            idc = 3;
            x = safeZoneX + safeZoneW * 0.05;
            y = safeZoneY + safeZoneH * 0.255;
            w = safeZoneW * 0.24;
            h = safeZoneH * 0.012;
        };

        class ResourceTitle: TYR_PM_Text
        {
            x = safeZoneX + safeZoneW * 0.05;
            y = safeZoneY + safeZoneH * 0.315;
            w = safeZoneW * 0.24;
            h = safeZoneH * 0.025;
            text = "FACTION RESOURCES";
            colorText[] = {0.851,0.5647,0.0863,1};
            sizeEx = 0.026;
        };
        class Steel: TYR_PM_Text {idc=20; x=safeZoneX+safeZoneW*0.05; y=safeZoneY+safeZoneH*0.35; w=safeZoneW*0.115; h=safeZoneH*0.025; sizeEx=0.026;};
        class Ammo: TYR_PM_Text {idc=21; x=safeZoneX+safeZoneW*0.175; y=safeZoneY+safeZoneH*0.35; w=safeZoneW*0.115; h=safeZoneH*0.025; sizeEx=0.026;};
        class Fuel: TYR_PM_Text {idc=22; x=safeZoneX+safeZoneW*0.05; y=safeZoneY+safeZoneH*0.385; w=safeZoneW*0.115; h=safeZoneH*0.025; sizeEx=0.026;};
        class Manpower: TYR_PM_Text {idc=23; x=safeZoneX+safeZoneW*0.175; y=safeZoneY+safeZoneH*0.385; w=safeZoneW*0.115; h=safeZoneH*0.025; sizeEx=0.026;};

        class CollectResources: TYR_PM_Button
        {
            idc = 4;
            x = safeZoneX + safeZoneW * 0.035;
            y = safeZoneY + safeZoneH * 0.455;
            w = safeZoneW * 0.135;
            h = safeZoneH * 0.045;
            text = "COLLECT RESOURCES";
            onButtonClick = "[] spawn TYR_fnc_GetFactoryResource;";
        };
        class BuyVehicle: TYR_PM_Button
        {
            idc = 5;
            x = safeZoneX + safeZoneW * 0.18;
            y = safeZoneY + safeZoneH * 0.455;
            w = safeZoneW * 0.135;
            h = safeZoneH * 0.045;
            text = "BUY VEHICLE";
            onButtonClick = "createDialog 'TyrVehicleBuyMenu';";
        };
        class Research: TYR_PM_Button
        {
            idc = 8;
            x = safeZoneX + safeZoneW * 0.035;
            y = safeZoneY + safeZoneH * 0.515;
            w = safeZoneW * 0.135;
            h = safeZoneH * 0.045;
            text = "RESEARCH";
            onButtonClick = "closeDialog 0; [] execVM 'Research\ResearchLoad.sqf';";
        };
        class BuyEmplacement: TYR_PM_Button
        {
            idc = 7;
            x = safeZoneX + safeZoneW * 0.18;
            y = safeZoneY + safeZoneH * 0.515;
            w = safeZoneW * 0.135;
            h = safeZoneH * 0.045;
            text = "EMPLACEMENTS";
            onButtonClick = "closeDialog 0; [] execVM 'Emplacements\EmplacementsLoad.sqf';";
        };
        class HireSquads: TYR_PM_Button
        {
            idc = 6;
            x = safeZoneX + safeZoneW * 0.035;
            y = safeZoneY + safeZoneH * 0.575;
            w = safeZoneW * 0.28;
            h = safeZoneH * 0.045;
            text = "HIRE SQUADS";
            onButtonClick = "createDialog 'TyrAIHireMenu';";
        };
        class Debug: TYR_PM_Button
        {
            idc = 9;
            x = safeZoneX + safeZoneW * 0.035;
            y = safeZoneY + safeZoneH * 0.65;
            w = safeZoneW * 0.28;
            h = safeZoneH * 0.045;
            text = "DEVELOPER DEBUG";
            colorBackground[] = {0.72,0.20,0.12,1};
            colorBackgroundActive[] = {0.9,0.28,0.16,1};
            colorFocused[] = {0.72,0.20,0.12,1};
            colorText[] = {1,1,1,1};
            onButtonClick = "closeDialog 0; createDialog 'TyrDebugMenu'; [] call TYR_fnc_DebugMenuRefresh;";
        };
        class Help: TYR_PM_Text
        {
            x = safeZoneX + safeZoneW * 0.05;
            y = safeZoneY + safeZoneH * 0.725;
            w = safeZoneW * 0.25;
            h = safeZoneH * 0.07;
            style = 2;
            text = "Y  CLOSE / REOPEN COMMAND MENU";
            colorText[] = {0.55,0.55,0.55,1};
            sizeEx = 0.023;
        };
        class Close: TYR_PM_Button
        {
            idc = 10;
            x = safeZoneX + safeZoneW * 0.035;
            y = safeZoneY + safeZoneH * 0.83;
            w = safeZoneW * 0.28;
            h = safeZoneH * 0.045;
            text = "CLOSE";
            onButtonClick = "closeDialog 0;";
        };
    };
};
