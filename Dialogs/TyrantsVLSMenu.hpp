class TyrantsVLSMenu
{
    idd = 1204;
    movingEnable = 0;
    enableSimulation = 1;
    onUnload = "[] call TYR_fnc_VLSMenuCleanup;";

    class ControlsBackground
    {
        class Backdrop: TYR_UI_Text
        {
            x = safeZoneX;
            y = safeZoneY;
            w = safeZoneW;
            h = safeZoneH;
            colorBackground[] = {0.015,0.02,0.025,0.97};
        };
        class Header: TYR_UI_Text
        {
            x = safeZoneX;
            y = safeZoneY;
            w = safeZoneW;
            h = safeZoneH * 0.065;
            text = "TYRANTS // STRATEGIC LAUNCH CONTROL";
            sizeEx = 0.042;
            colorBackground[] = {0.055,0.065,0.075,1};
        };
        class Accent: TYR_UI_Text
        {
            x = safeZoneX;
            y = safeZoneY;
            w = safeZoneW * 0.007;
            h = safeZoneH;
            colorBackground[] = {0.851,0.5647,0.0863,1};
        };
        class SidePanel: TYR_UI_Text
        {
            x = safeZoneX + safeZoneW * 0.02;
            y = safeZoneY + safeZoneH * 0.085;
            w = safeZoneW * 0.29;
            h = safeZoneH * 0.875;
            colorBackground[] = {0.035,0.043,0.052,0.98};
        };
        class MapFrame: TYR_UI_Text
        {
            x = safeZoneX + safeZoneW * 0.325;
            y = safeZoneY + safeZoneH * 0.085;
            w = safeZoneW * 0.655;
            h = safeZoneH * 0.875;
            colorBackground[] = {0.01,0.012,0.015,1};
        };
    };

    class Controls
    {
        class SystemTitle: TYR_UI_Text {x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.105; w=safeZoneW*0.25; h=safeZoneH*0.035; sizeEx=0.032; colorText[]={0.851,0.5647,0.0863,1}; text="VLS BATTERY";};
        class Ammo: TYR_UI_Text {idc=12; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.145; w=safeZoneW*0.12; h=safeZoneH*0.03; text="MISSILES: --";};
        class TargetCount: TYR_UI_Text {idc=13; x=safeZoneX+safeZoneW*0.17; y=safeZoneY+safeZoneH*0.145; w=safeZoneW*0.12; h=safeZoneH*0.03; text="TARGETS: -- / 18";};
        class Status: TYR_UI_Text {idc=2; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.182; w=safeZoneW*0.25; h=safeZoneH*0.05; sizeEx=0.024; colorText[]={0.58,0.63,0.68,1}; text="Synchronising launch state...";};

        class Targets: TYR_UI_List
        {
            idc = 1;
            x = safeZoneX + safeZoneW * 0.04;
            y = safeZoneY + safeZoneH * 0.245;
            w = safeZoneW * 0.25;
            h = safeZoneH * 0.30;
            onLBSelChanged = "_this call TYR_fnc_VLSFocusTarget;";
        };
        class AddTarget: TYR_UI_ButtonAccent {idc=4; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.56; w=safeZoneW*0.12; h=safeZoneH*0.045; text="ADD TARGET"; onButtonClick="[] call TYR_fnc_VLSAddTargetMode;";};
        class RemoveTarget: TYR_UI_Button {idc=3; x=safeZoneX+safeZoneW*0.17; y=safeZoneY+safeZoneH*0.56; w=safeZoneW*0.12; h=safeZoneH*0.045; text="REMOVE"; onButtonClick="[lbCurSel 1] call TYR_fnc_VLSRemoveTargetAction;";};

        class LaunchLabel: TYR_UI_Text {x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.635; w=safeZoneW*0.25; h=safeZoneH*0.03; text="LAUNCH AUTHORISATION"; colorText[]={0.851,0.5647,0.0863,1};};
        class LaunchButton: TYR_UI_ButtonDanger {idc=10; x=safeZoneX+safeZoneW*0.065; y=safeZoneY+safeZoneH*0.705; w=safeZoneW*0.20; h=safeZoneH*0.12; sizeEx=0.04; text="LAUNCH"; onButtonClick="[1] call TYR_fnc_VLSLaunchControl;";};
        class ButtonCover: TYR_UI_Button
        {
            idc = 11;
            x = safeZoneX + safeZoneW * 0.055;
            y = safeZoneY + safeZoneH * 0.685;
            w = safeZoneW * 0.22;
            h = safeZoneH * 0.16;
            text = "OPEN SAFETY COVER";
            sizeEx = 0.03;
            colorBackground[] = {0.22,0.24,0.27,1};
            colorBackgroundActive[] = {0.30,0.32,0.35,1};
            onButtonClick = "[0] call TYR_fnc_VLSLaunchControl;";
        };
        class LaunchHint: TYR_UI_Text {idc=14; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.865; w=safeZoneW*0.25; h=safeZoneH*0.05; style=2; sizeEx=0.023; colorText[]={0.55,0.58,0.62,1}; text="Safety closed. Select targets before arming.";};
        class Close: TYR_UI_Button {x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.92; w=safeZoneW*0.25; h=safeZoneH*0.035; text="EXIT LAUNCH CONTROL"; onButtonClick="closeDialog 0;";};

        class Map: RscMapControl
        {
            idc = 1000;
            x = safeZoneX + safeZoneW * 0.335;
            y = safeZoneY + safeZoneH * 0.095;
            w = safeZoneW * 0.635;
            h = safeZoneH * 0.855;
        };
        class MapInstruction: TYR_UI_Text
        {
            idc = 15;
            x = safeZoneX + safeZoneW * 0.355;
            y = safeZoneY + safeZoneH * 0.11;
            w = safeZoneW * 0.40;
            h = safeZoneH * 0.035;
            colorBackground[] = {0.02,0.025,0.03,0.80};
            colorText[] = {0.90,0.92,0.94,1};
            text = "MAP READY // press ADD TARGET, then click directly on this map";
            sizeEx = 0.025;
        };
    };
};
