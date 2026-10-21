class TyrVehicleBuyMenu
{
    idd = 1201;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = "[] spawn TYR_fnc_VehicleBuyMenu";
    class ControlsBackground
    {
        class Backdrop: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW; h=safeZoneH; colorBackground[]={0.015,0.02,0.025,0.98};};
        class Header: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW; h=safeZoneH*0.065; text="TYRANTS // VEHICLE PROCUREMENT"; sizeEx=0.042; colorBackground[]={0.055,0.065,0.075,1};};
        class Accent: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW*0.007; h=safeZoneH; colorBackground[]={0.851,0.5647,0.0863,1};};
        class ListPanel: TYR_UI_Text {x=safeZoneX+safeZoneW*0.02; y=safeZoneY+safeZoneH*0.09; w=safeZoneW*0.31; h=safeZoneH*0.86; colorBackground[]={0.035,0.043,0.052,0.98};};
        class DetailPanel: TYR_UI_Text {x=safeZoneX+safeZoneW*0.35; y=safeZoneY+safeZoneH*0.09; w=safeZoneW*0.63; h=safeZoneH*0.86; colorBackground[]={0.035,0.043,0.052,0.98};};
    };
    class Controls
    {
        class CategoryLabel: TYR_UI_Text {idc=2; x=safeZoneX+safeZoneW*0.065; y=safeZoneY+safeZoneH*0.115; w=safeZoneW*0.22; h=safeZoneH*0.04; style=2; sizeEx=0.03; colorText[]={0.851,0.5647,0.0863,1}; text="CATEGORY";};
        class ButtonLeft: TYR_UI_Button {idc=20; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.115; w=safeZoneW*0.035; h=safeZoneH*0.04; text="<"; onButtonClick="TYR_vehicleCategorySelection = TYR_vehicleCategorySelection - 1";};
        class ButtonRight: TYR_UI_Button {idc=3; x=safeZoneX+safeZoneW*0.275; y=safeZoneY+safeZoneH*0.115; w=safeZoneW*0.035; h=safeZoneH*0.04; text=">"; onButtonClick="TYR_vehicleCategorySelection = TYR_vehicleCategorySelection + 1";};
        class VehicleListBox: TYR_UI_List {idc=4; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.175; w=safeZoneW*0.27; h=safeZoneH*0.66;};
        class ListHint: TYR_UI_TextDim {x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.85; w=safeZoneW*0.27; h=safeZoneH*0.055; text="Vehicles must first be completed at a controlled vehicle factory. This screen releases produced stock.";};

        class PreviewTitle: TYR_UI_Text {x=safeZoneX+safeZoneW*0.375; y=safeZoneY+safeZoneH*0.115; w=safeZoneW*0.56; h=safeZoneH*0.035; text="ASSET PREVIEW / SPECIFICATION"; sizeEx=0.03; colorText[]={0.851,0.5647,0.0863,1};};
        class VehiclePictureDisplay: TYR_UI_Picture {idc=5; x=safeZoneX+safeZoneW*0.375; y=safeZoneY+safeZoneH*0.165; w=safeZoneW*0.56; h=safeZoneH*0.34; colorBackground[]={0.01,0.012,0.015,1};};
        class VehiclePropertiesListBox: TYR_UI_List {idc=6; x=safeZoneX+safeZoneW*0.375; y=safeZoneY+safeZoneH*0.53; w=safeZoneW*0.56; h=safeZoneH*0.27;};
        class BuyVehicle: TYR_UI_ButtonAccent {idc=7; x=safeZoneX+safeZoneW*0.735; y=safeZoneY+safeZoneH*0.845; w=safeZoneW*0.20; h=safeZoneH*0.055; text="NO PRODUCED STOCK"; onButtonClick="[lbData[4, lbCurSel 4]] spawn TYR_fnc_VehicleBuy";};
        class Close: TYR_UI_Button {x=safeZoneX+safeZoneW*0.375; y=safeZoneY+safeZoneH*0.845; w=safeZoneW*0.15; h=safeZoneH*0.055; text="BACK"; onButtonClick="closeDialog 0; createDialog 'TyrPlayerMenu';";};
    };
};
