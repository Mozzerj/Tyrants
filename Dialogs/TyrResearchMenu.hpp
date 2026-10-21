class TyrResearchMenu
{
    idd = 1205;
    movingEnable = 0;
    enableSimulation = 1;
    class ControlsBackground
    {
        class Backdrop: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW; h=safeZoneH; colorBackground[]={0.015,0.02,0.025,0.98};};
        class Header: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW; h=safeZoneH*0.065; text="TYRANTS // RESEARCH & DEVELOPMENT"; sizeEx=0.042; colorBackground[]={0.055,0.065,0.075,1};};
        class Accent: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW*0.007; h=safeZoneH; colorBackground[]={0.851,0.5647,0.0863,1};};
        class IntelPanel: TYR_UI_Text {x=safeZoneX+safeZoneW*0.02; y=safeZoneY+safeZoneH*0.09; w=safeZoneW*0.75; h=safeZoneH*0.235; colorBackground[]={0.035,0.043,0.052,0.98};};
        class InfraPanel: TYR_UI_Text {x=safeZoneX+safeZoneW*0.02; y=safeZoneY+safeZoneH*0.345; w=safeZoneW*0.75; h=safeZoneH*0.28; colorBackground[]={0.035,0.043,0.052,0.98};};
        class ProcPanel: TYR_UI_Text {x=safeZoneX+safeZoneW*0.02; y=safeZoneY+safeZoneH*0.645; w=safeZoneW*0.75; h=safeZoneH*0.30; colorBackground[]={0.035,0.043,0.052,0.98};};
        class InfoPanel: TYR_UI_Text {x=safeZoneX+safeZoneW*0.79; y=safeZoneY+safeZoneH*0.09; w=safeZoneW*0.19; h=safeZoneH*0.855; colorBackground[]={0.035,0.043,0.052,0.98};};
    };
    class Controls
    {
        class SteelDisplay: TYR_UI_Text {idc=2; x=safeZoneX+safeZoneW*0.81; y=safeZoneY+safeZoneH*0.115; w=safeZoneW*0.15; h=safeZoneH*0.04; text="Steel: --"; style=2; colorText[]={0.851,0.5647,0.0863,1}; sizeEx=0.031;};
        class InfoTitle: TYR_UI_TextDim {x=safeZoneX+safeZoneW*0.81; y=safeZoneY+safeZoneH*0.165; w=safeZoneW*0.15; h=safeZoneH*0.025; text="PROJECT BRIEF";};
        class ResearchLB: TYR_UI_List {idc=1; x=safeZoneX+safeZoneW*0.81; y=safeZoneY+safeZoneH*0.20; w=safeZoneW*0.15; h=safeZoneH*0.55;};
        class UnlockResearch: TYR_UI_ButtonAccent {idc=5; x=safeZoneX+safeZoneW*0.81; y=safeZoneY+safeZoneH*0.78; w=safeZoneW*0.15; h=safeZoneH*0.05; text="RESEARCH SELECTED"; onButtonClick="[5] call TYR_fnc_ResearchMenuUpdate";};
        class Close: TYR_UI_Button {x=safeZoneX+safeZoneW*0.81; y=safeZoneY+safeZoneH*0.85; w=safeZoneW*0.15; h=safeZoneH*0.045; text="RETURN TO COMMAND"; onButtonClick="closeDialog 0; createDialog 'TyrPlayerMenu';";};

        class IntelTitle: TYR_UI_Text {x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.11; w=safeZoneW*0.70; h=safeZoneH*0.03; text="INTELLIGENCE"; sizeEx=0.028; colorText[]={0.851,0.5647,0.0863,1};};
        class IntelHint: TYR_UI_TextDim {x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.145; w=safeZoneW*0.68; h=safeZoneH*0.025; text="Surveillance, interception and battlefield information systems";};
        class BasicIntelligence: TYR_UI_Button {idc=1000; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.20; w=safeZoneW*0.12; h=safeZoneH*0.055; text="Basic Intelligence"; onButtonClick="[1000] call TYR_fnc_ResearchMenuUpdate";};
        class CommunicationsIntercept: TYR_UI_Button {idc=1100; x=safeZoneX+safeZoneW*0.18; y=safeZoneY+safeZoneH*0.185; w=safeZoneW*0.13; h=safeZoneH*0.055; text="Comms Intercept"; onButtonClick="[1100] call TYR_fnc_ResearchMenuUpdate";};
        class VehicleTrackers: TYR_UI_Button {idc=1200; x=safeZoneX+safeZoneW*0.18; y=safeZoneY+safeZoneH*0.255; w=safeZoneW*0.13; h=safeZoneH*0.045; text="Vehicle Trackers"; onButtonClick="[1200] call TYR_fnc_ResearchMenuUpdate";};
        class ListeningDevices: TYR_UI_Button {idc=1110; x=safeZoneX+safeZoneW*0.33; y=safeZoneY+safeZoneH*0.185; w=safeZoneW*0.13; h=safeZoneH*0.055; text="Listening Devices"; onButtonClick="[1110] call TYR_fnc_ResearchMenuUpdate";};
        class Satellite: TYR_UI_Button {idc=1300; x=safeZoneX+safeZoneW*0.49; y=safeZoneY+safeZoneH*0.215; w=safeZoneW*0.16; h=safeZoneH*0.055; text="Satellite Surveillance"; onButtonClick="[1300] call TYR_fnc_ResearchMenuUpdate";};

        class InfraTitle: TYR_UI_Text {x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.365; w=safeZoneW*0.70; h=safeZoneH*0.03; text="INFRASTRUCTURE"; sizeEx=0.028; colorText[]={0.851,0.5647,0.0863,1};};
        class InfraHint: TYR_UI_TextDim {x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.40; w=safeZoneW*0.68; h=safeZoneH*0.025; text="Industrial output, strategic systems and fixed battlefield infrastructure";};
        class BasicInfra: TYR_UI_Button {idc=2000; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.465; w=safeZoneW*0.12; h=safeZoneH*0.055; text="Basic Infrastructure"; onButtonClick="[2000] call TYR_fnc_ResearchMenuUpdate";};
        class Strategic: TYR_UI_Button {idc=2100; x=safeZoneX+safeZoneW*0.18; y=safeZoneY+safeZoneH*0.445; w=safeZoneW*0.14; h=safeZoneH*0.055; text="Strategic Emplacements"; onButtonClick="[2100] call TYR_fnc_ResearchMenuUpdate";};
        class Factory: TYR_UI_Button {idc=2200; x=safeZoneX+safeZoneW*0.18; y=safeZoneY+safeZoneH*0.525; w=safeZoneW*0.14; h=safeZoneH*0.055; text="Factory Production"; onButtonClick="[2200] call TYR_fnc_ResearchMenuUpdate";};
        class CBR: TYR_UI_Button {idc=2110; x=safeZoneX+safeZoneW*0.35; y=safeZoneY+safeZoneH*0.43; w=safeZoneW*0.14; h=safeZoneH*0.055; text="Counter Battery Radar"; onButtonClick="[2110] call TYR_fnc_ResearchMenuUpdate";};
        class Roadblock: TYR_UI_Button {idc=2120; x=safeZoneX+safeZoneW*0.35; y=safeZoneY+safeZoneH*0.505; w=safeZoneW*0.14; h=safeZoneH*0.055; text="Roadblocks"; onButtonClick="[2120] call TYR_fnc_ResearchMenuUpdate";};
        class Offensive: TYR_UI_Button {idc=2300; x=safeZoneX+safeZoneW*0.53; y=safeZoneY+safeZoneH*0.465; w=safeZoneW*0.16; h=safeZoneH*0.065; text="Offensive Emplacements"; onButtonClick="[2300] call TYR_fnc_ResearchMenuUpdate";};

        class ProcTitle: TYR_UI_Text {x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.665; w=safeZoneW*0.70; h=safeZoneH*0.03; text="PROCUREMENT"; sizeEx=0.028; colorText[]={0.851,0.5647,0.0863,1};};
        class ProcHint: TYR_UI_TextDim {x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.70; w=safeZoneW*0.68; h=safeZoneH*0.025; text="Progressive access to heavier and more specialised vehicle classes";};
        class Armoured: TYR_UI_Button {idc=3000; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.775; w=safeZoneW*0.105; h=safeZoneH*0.065; text="Armoured"; onButtonClick="[3000] call TYR_fnc_ResearchMenuUpdate";};
        class Heavy: TYR_UI_Button {idc=3001; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.775; w=safeZoneW*0.105; h=safeZoneH*0.065; text="Heavy Armour"; onButtonClick="[3001] call TYR_fnc_ResearchMenuUpdate";};
        class Rotary: TYR_UI_Button {idc=3002; x=safeZoneX+safeZoneW*0.274; y=safeZoneY+safeZoneH*0.775; w=safeZoneW*0.105; h=safeZoneH*0.065; text="Rotary Wing"; onButtonClick="[3002] call TYR_fnc_ResearchMenuUpdate";};
        class Artillery: TYR_UI_Button {idc=3003; x=safeZoneX+safeZoneW*0.391; y=safeZoneY+safeZoneH*0.775; w=safeZoneW*0.105; h=safeZoneH*0.065; text="Artillery"; onButtonClick="[3003] call TYR_fnc_ResearchMenuUpdate";};
        class Fixed: TYR_UI_Button {idc=3004; x=safeZoneX+safeZoneW*0.508; y=safeZoneY+safeZoneH*0.775; w=safeZoneW*0.105; h=safeZoneH*0.065; text="Fixed Wing"; onButtonClick="[3004] call TYR_fnc_ResearchMenuUpdate";};
        class Autonomous: TYR_UI_Button {idc=3005; x=safeZoneX+safeZoneW*0.625; y=safeZoneY+safeZoneH*0.775; w=safeZoneW*0.12; h=safeZoneH*0.065; text="Autonomous"; onButtonClick="[3005] call TYR_fnc_ResearchMenuUpdate";};
    };
};
