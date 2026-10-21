class TyrFactoryMenu
{
    idd = 1450;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = "[] call TYR_fnc_FactoryMenuRefresh;";
    class ControlsBackground
    {
        class Backdrop: TYR_UI_Text {x=safeZoneX+safeZoneW*0.16; y=safeZoneY+safeZoneH*0.10; w=safeZoneW*0.68; h=safeZoneH*0.80; colorBackground[]={0.025,0.03,0.038,0.98};};
        class Accent: TYR_UI_Text {x=safeZoneX+safeZoneW*0.16; y=safeZoneY+safeZoneH*0.10; w=safeZoneW*0.006; h=safeZoneH*0.80; colorBackground[]={0.851,0.5647,0.0863,1};};
        class Header: TYR_UI_Text {x=safeZoneX+safeZoneW*0.166; y=safeZoneY+safeZoneH*0.10; w=safeZoneW*0.674; h=safeZoneH*0.065; text="TYRANTS // FACTORY PRODUCTION"; sizeEx=0.040; colorBackground[]={0.07,0.08,0.095,1};};
    };
    class Controls
    {
        class FactoryName: TYR_UI_Text {idc=1; x=safeZoneX+safeZoneW*0.19; y=safeZoneY+safeZoneH*0.185; w=safeZoneW*0.40; h=safeZoneH*0.035; sizeEx=0.031; text="FACTORY";};
        class FactoryType: TYR_UI_TextDim {idc=2; x=safeZoneX+safeZoneW*0.19; y=safeZoneY+safeZoneH*0.222; w=safeZoneW*0.40; h=safeZoneH*0.030; text="TYPE // --";};
        class AvailableTitle: TYR_UI_Text {x=safeZoneX+safeZoneW*0.19; y=safeZoneY+safeZoneH*0.275; w=safeZoneW*0.28; h=safeZoneH*0.03; text="AVAILABLE PRODUCTION"; colorText[]={0.851,0.5647,0.0863,1};};
        class Available: TYR_UI_List {idc=10; x=safeZoneX+safeZoneW*0.19; y=safeZoneY+safeZoneH*0.315; w=safeZoneW*0.28; h=safeZoneH*0.40; onLBSelChanged="[] call TYR_fnc_FactoryMenuRefresh;";};
        class QueueTitle: TYR_UI_Text {x=safeZoneX+safeZoneW*0.50; y=safeZoneY+safeZoneH*0.275; w=safeZoneW*0.30; h=safeZoneH*0.03; text="QUEUE / LOCAL STOCK"; colorText[]={0.851,0.5647,0.0863,1};};
        class Queue: TYR_UI_List {idc=11; x=safeZoneX+safeZoneW*0.50; y=safeZoneY+safeZoneH*0.315; w=safeZoneW*0.30; h=safeZoneH*0.26;};
        class Inventory: TYR_UI_TextMulti {idc=12; x=safeZoneX+safeZoneW*0.50; y=safeZoneY+safeZoneH*0.59; w=safeZoneW*0.30; h=safeZoneH*0.125; sizeEx=0.021; colorBackground[]={0.045,0.052,0.060,1}; text="STOCK // --";};
        class ProductInfo: TYR_UI_TextMulti {idc=13; x=safeZoneX+safeZoneW*0.19; y=safeZoneY+safeZoneH*0.73; w=safeZoneW*0.42; h=safeZoneH*0.075; sizeEx=0.021; text="Select a product.";};
        class QueueButton: TYR_UI_ButtonAccent {idc=20; x=safeZoneX+safeZoneW*0.63; y=safeZoneY+safeZoneH*0.735; w=safeZoneW*0.17; h=safeZoneH*0.05; text="QUEUE PRODUCT"; onButtonClick="[] call TYR_fnc_FactoryQueueSelected;";};
        class Close: TYR_UI_Button {x=safeZoneX+safeZoneW*0.63; y=safeZoneY+safeZoneH*0.805; w=safeZoneW*0.17; h=safeZoneH*0.04; text="CLOSE"; onButtonClick="closeDialog 0;";};
    };
};
