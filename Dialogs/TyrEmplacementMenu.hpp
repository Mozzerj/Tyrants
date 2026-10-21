class TyrEmplacementMenu
{
    idd = 1203;
    movingEnable = 0;
    enableSimulation = 1;
    onUnload = "deleteMarkerLocal 'TYR_emplacementPreview'; missionNamespace setVariable ['TYR_emplacementTargeting', false]; missionNamespace setVariable ['TYR_emplacementPendingPos', []];";
    class ControlsBackground
    {
        class Backdrop: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW; h=safeZoneH; colorBackground[]={0.015,0.02,0.025,0.98};};
        class Header: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW; h=safeZoneH*0.065; text="TYRANTS // STRATEGIC EMPLACEMENT CONTROL"; sizeEx=0.042; colorBackground[]={0.055,0.065,0.075,1};};
        class Accent: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW*0.007; h=safeZoneH; colorBackground[]={0.851,0.5647,0.0863,1};};
        class SidePanel: TYR_UI_Text {x=safeZoneX+safeZoneW*0.02; y=safeZoneY+safeZoneH*0.09; w=safeZoneW*0.29; h=safeZoneH*0.86; colorBackground[]={0.035,0.043,0.052,0.98};};
        class MapFrame: TYR_UI_Text {x=safeZoneX+safeZoneW*0.33; y=safeZoneY+safeZoneH*0.09; w=safeZoneW*0.65; h=safeZoneH*0.86; colorBackground[]={0.01,0.012,0.015,1};};
    };
    class Controls
    {
        class AvailableTitle: TYR_UI_Text {x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.115; w=safeZoneW*0.25; h=safeZoneH*0.03; text="AVAILABLE SYSTEMS"; colorText[]={0.851,0.5647,0.0863,1}; sizeEx=0.029;};
        class Available: TYR_UI_List {idc=1; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.16; w=safeZoneW*0.25; h=safeZoneH*0.24;};
        class ExistingTitle: TYR_UI_Text {x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.435; w=safeZoneW*0.25; h=safeZoneH*0.03; text="DEPLOYED SYSTEMS"; colorText[]={0.851,0.5647,0.0863,1}; sizeEx=0.029;};
        class Existing: TYR_UI_List {idc=2; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.48; w=safeZoneW*0.25; h=safeZoneH*0.18;};
        class PlacementHint: TYR_UI_TextMulti {idc=4; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.69; w=safeZoneW*0.25; h=safeZoneH*0.07; text="Select a system, press DESIGNATE POSITION, then click directly on the tactical map.";};
        class Designate: TYR_UI_Button {idc=5; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.775; w=safeZoneW*0.25; h=safeZoneH*0.042; text="DESIGNATE POSITION"; onButtonClick="missionNamespace setVariable ['TYR_emplacementTargeting', true]; (findDisplay 1203 displayCtrl 4) ctrlSetText 'DESIGNATION MODE // click a valid friendly-area position on the map';";};
        class CreateEmplacement: TYR_UI_ButtonAccent {idc=3; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.83; w=safeZoneW*0.25; h=safeZoneH*0.052; text="DEPLOY EMPLACEMENT"; onButtonClick="[lbCurSel 1] call TYR_fnc_DeployEmplacement";};
        class Close: TYR_UI_Button {x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.895; w=safeZoneW*0.25; h=safeZoneH*0.035; text="RETURN TO COMMAND"; onButtonClick="closeDialog 0; createDialog 'TyrPlayerMenu';";};
        class Map: RscMapControl {idc=1000; x=safeZoneX+safeZoneW*0.34; y=safeZoneY+safeZoneH*0.10; w=safeZoneW*0.63; h=safeZoneH*0.84;};
        class MapInstruction: TYR_UI_Text {idc=6; x=safeZoneX+safeZoneW*0.36; y=safeZoneY+safeZoneH*0.115; w=safeZoneW*0.43; h=safeZoneH*0.035; colorBackground[]={0.02,0.025,0.03,0.80}; text="TACTICAL MAP // placement must be within 500m of friendly captured territory"; sizeEx=0.024;};
    };
};
