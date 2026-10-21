
class TyrDebugMenu
{
    idd = 1700;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = "[] call TYR_fnc_DebugMenuRefresh;";
    class ControlsBackground
    {
        class Backdrop: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW; h=safeZoneH; colorBackground[]={0.015,0.02,0.025,0.98};};
        class Header: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW; h=safeZoneH*0.065; text="TYRANTS V4 // DEVELOPER CONSOLE"; sizeEx=0.042; colorBackground[]={0.055,0.065,0.075,1};};
        class Accent: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW*0.007; h=safeZoneH; colorBackground[]={0.851,0.5647,0.0863,1};};
        class TargetPanel: TYR_UI_Text {x=safeZoneX+safeZoneW*0.13; y=safeZoneY+safeZoneH*0.15; w=safeZoneW*0.74; h=safeZoneH*0.55; colorBackground[]={0.035,0.043,0.052,0.98};};
    };
    class Controls
    {
        class Status: TYR_UI_Text {idc=130; x=safeZoneX+safeZoneW*0.15; y=safeZoneY+safeZoneH*0.09; w=safeZoneW*0.70; h=safeZoneH*0.035; colorText[]={0.55,0.60,0.65,1}; text="Server state";};
        class West: TYR_UI_Button {x=safeZoneX+safeZoneW*0.15; y=safeZoneY+safeZoneH*0.17; w=safeZoneW*0.17; h=safeZoneH*0.045; text="WEST / NATO"; onButtonClick="['west'] call TYR_debugSelect;";};
        class East: TYR_UI_Button {x=safeZoneX+safeZoneW*0.415; y=safeZoneY+safeZoneH*0.17; w=safeZoneW*0.17; h=safeZoneH*0.045; text="EAST / CSAT"; onButtonClick="['east'] call TYR_debugSelect;";};
        class Independent: TYR_UI_Button {x=safeZoneX+safeZoneW*0.68; y=safeZoneY+safeZoneH*0.17; w=safeZoneW*0.17; h=safeZoneH*0.045; text="INDEPENDENT / AAF"; onButtonClick="['independent'] call TYR_debugSelect;";};

        class Target: TYR_UI_Text {idc=101; x=safeZoneX+safeZoneW*0.16; y=safeZoneY+safeZoneH*0.24; w=safeZoneW*0.68; h=safeZoneH*0.04; style=2; sizeEx=0.032; colorText[]={0.851,0.5647,0.0863,1}; text="TARGET";};
        class Steel: TYR_UI_Text {idc=110; x=safeZoneX+safeZoneW*0.16; y=safeZoneY+safeZoneH*0.30; w=safeZoneW*0.15; h=safeZoneH*0.07; style=2; text="STEEL";};
        class Ammo: TYR_UI_Text {idc=111; x=safeZoneX+safeZoneW*0.335; y=safeZoneY+safeZoneH*0.30; w=safeZoneW*0.15; h=safeZoneH*0.07; style=2; text="AMMO";};
        class Fuel: TYR_UI_Text {idc=112; x=safeZoneX+safeZoneW*0.51; y=safeZoneY+safeZoneH*0.30; w=safeZoneW*0.15; h=safeZoneH*0.07; style=2; text="FUEL";};
        class Man: TYR_UI_Text {idc=113; x=safeZoneX+safeZoneW*0.685; y=safeZoneY+safeZoneH*0.30; w=safeZoneW*0.15; h=safeZoneH*0.07; style=2; text="MANPOWER";};

        class AddSteel: TYR_UI_ButtonAccent {x=safeZoneX+safeZoneW*0.16; y=safeZoneY+safeZoneH*0.39; w=safeZoneW*0.15; h=safeZoneH*0.04; text="+10K STEEL"; onButtonClick="['resource',[TYR_debugFaction,'steel',10000]] call TYR_debugSend;";};
        class AddAmmo: TYR_UI_Button {x=safeZoneX+safeZoneW*0.335; y=safeZoneY+safeZoneH*0.39; w=safeZoneW*0.15; h=safeZoneH*0.04; text="+10K AMMO"; onButtonClick="['resource',[TYR_debugFaction,'ammo',10000]] call TYR_debugSend;";};
        class AddFuel: TYR_UI_Button {x=safeZoneX+safeZoneW*0.51; y=safeZoneY+safeZoneH*0.39; w=safeZoneW*0.15; h=safeZoneH*0.04; text="+10K FUEL"; onButtonClick="['resource',[TYR_debugFaction,'fuel',10000]] call TYR_debugSend;";};
        class AddMan: TYR_UI_Button {x=safeZoneX+safeZoneW*0.685; y=safeZoneY+safeZoneH*0.39; w=safeZoneW*0.15; h=safeZoneH*0.04; text="+100 MANPOWER"; onButtonClick="['resource',[TYR_debugFaction,'manpower',100]] call TYR_debugSend;";};

        class Boost: TYR_UI_Button {x=safeZoneX+safeZoneW*0.16; y=safeZoneY+safeZoneH*0.47; w=safeZoneW*0.15; h=safeZoneH*0.045; text="BOOST ALL"; onButtonClick="['boost',[TYR_debugFaction]] call TYR_debugSend;";};
        class Max: TYR_UI_Button {x=safeZoneX+safeZoneW*0.335; y=safeZoneY+safeZoneH*0.47; w=safeZoneW*0.15; h=safeZoneH*0.045; text="MAX RESOURCES"; onButtonClick="['max',[TYR_debugFaction]] call TYR_debugSend;";};
        class Unlock: TYR_UI_Button {x=safeZoneX+safeZoneW*0.51; y=safeZoneY+safeZoneH*0.47; w=safeZoneW*0.15; h=safeZoneH*0.045; text="UNLOCK RESEARCH"; onButtonClick="['unlockResearch',[TYR_debugFaction]] call TYR_debugSend;";};
        class Reset: TYR_UI_ButtonDanger {x=safeZoneX+safeZoneW*0.685; y=safeZoneY+safeZoneH*0.47; w=safeZoneW*0.15; h=safeZoneH*0.045; text="RESET RESEARCH"; onButtonClick="['resetResearch',[TYR_debugFaction]] call TYR_debugSend;";};

        class SpawnForce: TYR_UI_ButtonAccent {x=safeZoneX+safeZoneW*0.16; y=safeZoneY+safeZoneH*0.55; w=safeZoneW*0.15; h=safeZoneH*0.045; text="SPAWN AI FORCE"; onButtonClick="['spawnForce',[TYR_debugFaction]] call TYR_debugSend;";};
        class Think: TYR_UI_Button {x=safeZoneX+safeZoneW*0.335; y=safeZoneY+safeZoneH*0.55; w=safeZoneW*0.15; h=safeZoneH*0.045; text="COMMANDER THINK"; onButtonClick="['think',[TYR_debugFaction]] call TYR_debugSend;";};
        class Teleport: TYR_UI_Button {x=safeZoneX+safeZoneW*0.51; y=safeZoneY+safeZoneH*0.55; w=safeZoneW*0.15; h=safeZoneH*0.045; text="TP TO TARGET HQ"; onButtonClick="[TYR_debugFaction] call TYR_fnc_DebugTeleport;";};
        class Tick: TYR_UI_Button {x=safeZoneX+safeZoneW*0.685; y=safeZoneY+safeZoneH*0.55; w=safeZoneW*0.15; h=safeZoneH*0.045; text="ECONOMY TICK"; onButtonClick="['factoryTick',[]] call TYR_debugSend;";};

        class Perf: TYR_UI_Text {idc=131; x=safeZoneX+safeZoneW*0.16; y=safeZoneY+safeZoneH*0.63; w=safeZoneW*0.30; h=safeZoneH*0.03; text="Client FPS: --";};
        class Save: TYR_UI_ButtonAccent {x=safeZoneX+safeZoneW*0.48; y=safeZoneY+safeZoneH*0.62; w=safeZoneW*0.11; h=safeZoneH*0.04; text="SAVE NOW"; onButtonClick="['save',[]] call TYR_debugSend;";};
        class Sync: TYR_UI_Button {x=safeZoneX+safeZoneW*0.60; y=safeZoneY+safeZoneH*0.62; w=safeZoneW*0.11; h=safeZoneH*0.04; text="SYNC"; onButtonClick="['sync',[]] call TYR_debugSend;";};
        class Tests: TYR_UI_Button {x=safeZoneX+safeZoneW*0.72; y=safeZoneY+safeZoneH*0.62; w=safeZoneW*0.11; h=safeZoneH*0.04; text="AUTOTEST"; onButtonClick="[] remoteExecCall ['TYR_fnc_ServerRunAutomatedTests',2];";};
        class Close: TYR_UI_Button {x=safeZoneX+safeZoneW*0.40; y=safeZoneY+safeZoneH*0.76; w=safeZoneW*0.20; h=safeZoneH*0.05; text="RETURN TO GAME"; onButtonClick="closeDialog 0;";};
        class Note: TYR_UI_TextMulti {x=safeZoneX+safeZoneW*0.20; y=safeZoneY+safeZoneH*0.83; w=safeZoneW*0.60; h=safeZoneH*0.07; style=2; colorText[]={0.5,0.54,0.58,1}; text="V4 debug actions mutate server state directly and only replicate the affected faction. Persistence remains debounced unless SAVE NOW is pressed.";};
    };
};
