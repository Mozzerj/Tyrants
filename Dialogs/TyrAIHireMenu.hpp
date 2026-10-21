
class TyrAIHireMenu
{
    idd = 1202;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = "[] call TYR_fnc_CommanderMenuRefresh;";
    class ControlsBackground
    {
        class Backdrop: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW; h=safeZoneH; colorBackground[]={0.015,0.02,0.025,0.98};};
        class Header: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW; h=safeZoneH*0.065; text="TYRANTS V4 // FORCE COMMAND"; sizeEx=0.042; colorBackground[]={0.055,0.065,0.075,1};};
        class Accent: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW*0.007; h=safeZoneH; colorBackground[]={0.851,0.5647,0.0863,1};};
        class Panel: TYR_UI_Text {x=safeZoneX+safeZoneW*0.20; y=safeZoneY+safeZoneH*0.15; w=safeZoneW*0.60; h=safeZoneH*0.65; colorBackground[]={0.035,0.043,0.052,0.98};};
    };
    class Controls
    {
        class Title: TYR_UI_Text {idc=2; x=safeZoneX+safeZoneW*0.24; y=safeZoneY+safeZoneH*0.20; w=safeZoneW*0.52; h=safeZoneH*0.045; style=2; sizeEx=0.034; colorText[]={0.851,0.5647,0.0863,1}; text="FORCE COMMAND";};
        class Status: TYR_UI_TextMulti {idc=30; x=safeZoneX+safeZoneW*0.26; y=safeZoneY+safeZoneH*0.29; w=safeZoneW*0.48; h=safeZoneH*0.24; style=0; text="Loading commander state...";};
        class Deploy: TYR_UI_ButtonAccent {x=safeZoneX+safeZoneW*0.30; y=safeZoneY+safeZoneH*0.58; w=safeZoneW*0.40; h=safeZoneH*0.055; text="DEPLOY INFANTRY FORCE"; onButtonClick="['infantry'] remoteExecCall ['TYR_fnc_ServerRequestForce',2];";};
        class Hint: TYR_UI_TextMulti {x=safeZoneX+safeZoneW*0.27; y=safeZoneY+safeZoneH*0.65; w=safeZoneW*0.46; h=safeZoneH*0.07; style=2; colorText[]={0.55,0.58,0.62,1}; text="Forces cost faction resources and manpower. AI-controlled factions use the same deployment service automatically.";};
        class Close: TYR_UI_Button {x=safeZoneX+safeZoneW*0.36; y=safeZoneY+safeZoneH*0.74; w=safeZoneW*0.28; h=safeZoneH*0.045; text="RETURN TO COMMAND"; onButtonClick="closeDialog 0; createDialog 'TyrPlayerMenu';";};
    };
};
