class TyrDeploymentMenu
{
    idd = 1300;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = "[] call TYR_fnc_DeploymentMenuInit;";
    onUnload = "[] call TYR_fnc_DeploymentOverlayCleanup;";
    class ControlsBackground
    {
        class Backdrop: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW; h=safeZoneH; colorBackground[]={0.012,0.016,0.021,1};};
        class Header: TYR_UI_Text {x=safeZoneX+safeZoneW*0.016; y=safeZoneY; w=safeZoneW*0.984; h=safeZoneH*0.065; text="TYRANTS // STRATEGIC DEPLOYMENT // v4.0.13 DEV"; sizeEx=0.042; colorBackground[]={0.055,0.065,0.075,1};};
        class Accent: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW*0.007; h=safeZoneH; colorBackground[]={0.851,0.5647,0.0863,1};};
        class MapFrame: TYR_UI_Text {x=safeZoneX+safeZoneW*0.018; y=safeZoneY+safeZoneH*0.085; w=safeZoneW*0.70; h=safeZoneH*0.89; colorBackground[]={0.005,0.008,0.012,1};};
        class SidePanel: TYR_UI_Text {x=safeZoneX+safeZoneW*0.735; y=safeZoneY+safeZoneH*0.085; w=safeZoneW*0.245; h=safeZoneH*0.89; colorBackground[]={0.035,0.043,0.052,0.98};};
    };
    class Controls
    {
        class Map: RscMapControl {idc=1000; x=safeZoneX+safeZoneW*0.025; y=safeZoneY+safeZoneH*0.095; w=safeZoneW*0.685; h=safeZoneH*0.87; enabled=1; onMouseButtonDown="if ((_this # 1) isEqualTo 0) then { private _p = (_this # 0) ctrlMapScreenToWorld [_this # 2,_this # 3]; [_p] call TYR_fnc_DeploymentMapClick; }; false";};
        class FactionTitle: TYR_UI_Text {idc=101; x=safeZoneX+safeZoneW*0.755; y=safeZoneY+safeZoneH*0.115; w=safeZoneW*0.205; h=safeZoneH*0.045; sizeEx=0.032; colorText[]={0.851,0.5647,0.0863,1}; text="FACTION // DEPLOYMENT";};
        class IntelTitle: TYR_UI_Text {x=safeZoneX+safeZoneW*0.755; y=safeZoneY+safeZoneH*0.185; w=safeZoneW*0.205; h=safeZoneH*0.03; text="DEPLOYMENT INTELLIGENCE"; colorText[]={0.851,0.5647,0.0863,1};};
        class IntelText: TYR_UI_TextMulti {idc=102; x=safeZoneX+safeZoneW*0.755; y=safeZoneY+safeZoneH*0.225; w=safeZoneW*0.205; h=safeZoneH*0.16; sizeEx=0.024; text="The coloured regions are known starting areas. Enemy HQ coordinates are NOT shared. Left-click to place the exact HQ footprint. The map never auto-moves your choice. Red hollow boxes are hard-obstruction collisions; roads are allowed. Fine-tune the click until the HQ footprint is green. Grey corridors are reserved borders.";};
        class StatusTitle: TYR_UI_Text {x=safeZoneX+safeZoneW*0.755; y=safeZoneY+safeZoneH*0.415; w=safeZoneW*0.205; h=safeZoneH*0.03; text="YOUR HQ"; colorText[]={0.851,0.5647,0.0863,1};};
        class Status: TYR_UI_TextMulti {idc=103; x=safeZoneX+safeZoneW*0.755; y=safeZoneY+safeZoneH*0.455; w=safeZoneW*0.205; h=safeZoneH*0.09; text="CLICK INSIDE YOUR COLOURED REGION";};
        class ReadyTitle: TYR_UI_Text {x=safeZoneX+safeZoneW*0.755; y=safeZoneY+safeZoneH*0.58; w=safeZoneW*0.205; h=safeZoneH*0.03; text="FACTION READINESS"; colorText[]={0.851,0.5647,0.0863,1};};
        class Ready: TYR_UI_TextMulti {idc=105; x=safeZoneX+safeZoneW*0.755; y=safeZoneY+safeZoneH*0.62; w=safeZoneW*0.205; h=safeZoneH*0.13; text="Waiting for campaign state...";};
        class Confirm: TYR_UI_ButtonAccent {idc=10; x=safeZoneX+safeZoneW*0.755; y=safeZoneY+safeZoneH*0.79; w=safeZoneW*0.205; h=safeZoneH*0.06; text="CONFIRM HQ"; onButtonClick="[] call TYR_fnc_DeploymentConfirm;";};
        class Footer: TYR_UI_TextMulti {x=safeZoneX+safeZoneW*0.755; y=safeZoneY+safeZoneH*0.875; w=safeZoneW*0.205; h=safeZoneH*0.07; sizeEx=0.022; colorText[]={0.56,0.61,0.66,1}; text="Combat, economy, captures and AI operations remain paused until every active faction has locked an HQ.";};
    };
};
