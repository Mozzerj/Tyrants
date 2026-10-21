class TyrDebugMenu
{
    idd = 1700;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = "[] call TYR_fnc_DebugMenuInit;";
    onUnload = "missionNamespace setVariable ['TYR_debugMenuOpen',false];";

    class ControlsBackground
    {
        class Backdrop: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW; h=safeZoneH; colorBackground[]={0.012,0.016,0.020,0.985};};
        class Header: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW; h=safeZoneH*0.062; text="TYRANTS // DEVELOPER CONSOLE // v4.0.14"; sizeEx=0.038; colorBackground[]={0.045,0.052,0.060,1};};
        class Accent: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW*0.006; h=safeZoneH; colorBackground[]={0.851,0.5647,0.0863,1};};
        class NavPanel: TYR_UI_Text {x=safeZoneX+safeZoneW*0.018; y=safeZoneY+safeZoneH*0.082; w=safeZoneW*0.115; h=safeZoneH*0.865; colorBackground[]={0.026,0.032,0.038,0.98};};
        class ActionPanel: TYR_UI_Text {x=safeZoneX+safeZoneW*0.142; y=safeZoneY+safeZoneH*0.082; w=safeZoneW*0.178; h=safeZoneH*0.865; colorBackground[]={0.032,0.039,0.046,0.98};};
        class WorkspacePanel: TYR_UI_Text {x=safeZoneX+safeZoneW*0.329; y=safeZoneY+safeZoneH*0.082; w=safeZoneW*0.653; h=safeZoneH*0.865; colorBackground[]={0.008,0.011,0.014,1};};
    };

    class Controls
    {
        class HeaderStatus: TYR_UI_Text {idc=130; x=safeZoneX+safeZoneW*0.61; y=safeZoneY+safeZoneH*0.017; w=safeZoneW*0.35; h=safeZoneH*0.030; style=1; sizeEx=0.021; colorText[]={0.58,0.64,0.70,1}; text="SERVER -- // CLIENT -- // SAVE --";};

        // Persistent navigation. Nothing reflows: changing page only toggles a small fixed set of controls.
        class NavMovement: TYR_UI_Button {idc=401; x=safeZoneX+safeZoneW*0.030; y=safeZoneY+safeZoneH*0.130; w=safeZoneW*0.091; h=safeZoneH*0.048; text="MOVEMENT"; onButtonClick="['movement'] call TYR_fnc_DebugMenuSetPage;";};
        class NavAI: TYR_UI_Button {idc=402; x=safeZoneX+safeZoneW*0.030; y=safeZoneY+safeZoneH*0.188; w=safeZoneW*0.091; h=safeZoneH*0.048; text="AI"; onButtonClick="['ai'] call TYR_fnc_DebugMenuSetPage;";};
        class NavCommand: TYR_UI_Button {idc=403; x=safeZoneX+safeZoneW*0.030; y=safeZoneY+safeZoneH*0.246; w=safeZoneW*0.091; h=safeZoneH*0.048; text="COMMAND"; onButtonClick="['command'] call TYR_fnc_DebugMenuSetPage;";};
        class NavEconomy: TYR_UI_Button {idc=404; x=safeZoneX+safeZoneW*0.030; y=safeZoneY+safeZoneH*0.304; w=safeZoneW*0.091; h=safeZoneH*0.048; text="ECONOMY"; onButtonClick="['economy'] call TYR_fnc_DebugMenuSetPage;";};
        class NavSystem: TYR_UI_Button {idc=405; x=safeZoneX+safeZoneW*0.030; y=safeZoneY+safeZoneH*0.362; w=safeZoneW*0.091; h=safeZoneH*0.048; text="SYSTEM"; onButtonClick="['system'] call TYR_fnc_DebugMenuSetPage;";};
        class Close: TYR_UI_Button {idc=399; x=safeZoneX+safeZoneW*0.030; y=safeZoneY+safeZoneH*0.887; w=safeZoneW*0.091; h=safeZoneH*0.040; text="RETURN"; onButtonClick="closeDialog 0;";};

        // Faction target is always visible and independent of the selected tool page.
        class FactionTarget: TYR_UI_TextMulti {idc=205; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.105; w=safeZoneW*0.148; h=safeZoneH*0.054; style=18; sizeEx=0.022; colorText[]={0.851,0.5647,0.0863,1}; text="TARGET // --";};
        class FactionWest: TYR_UI_Button {idc=202; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.166; w=safeZoneW*0.045; h=safeZoneH*0.038; text="WEST"; onButtonClick="['west'] call TYR_debugSelect;";};
        class FactionEast: TYR_UI_Button {idc=203; x=safeZoneX+safeZoneW*0.209; y=safeZoneY+safeZoneH*0.166; w=safeZoneW*0.045; h=safeZoneH*0.038; text="EAST"; onButtonClick="['east'] call TYR_debugSelect;";};
        class FactionIndependent: TYR_UI_Button {idc=204; x=safeZoneX+safeZoneW*0.261; y=safeZoneY+safeZoneH*0.166; w=safeZoneW*0.044; h=safeZoneH*0.038; text="IND"; onButtonClick="['independent'] call TYR_debugSelect;";};
        class PageTitle: TYR_UI_Text {idc=430; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.222; w=safeZoneW*0.148; h=safeZoneH*0.034; sizeEx=0.026; colorText[]={0.80,0.84,0.88,1}; text="MOVEMENT";};
        class PageHint: TYR_UI_TextMulti {idc=431; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.258; w=safeZoneW*0.148; h=safeZoneH*0.060; sizeEx=0.019; colorText[]={0.46,0.53,0.60,1}; text="Fast navigation and camera tools.";};

        // MOVEMENT PAGE
        class ViewMap: TYR_UI_ButtonAccent {idc=281; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.335; w=safeZoneW*0.148; h=safeZoneH*0.043; text="SHOW TRUTH MAP"; onButtonClick="missionNamespace setVariable ['TYR_DebugOrderFocus',false]; ['map'] call TYR_fnc_DebugMenuSetView;";};
        class DebugCamera: TYR_UI_ButtonAccent {idc=284; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.386; w=safeZoneW*0.148; h=safeZoneH*0.043; text="SPLENDID CAMERA"; onButtonClick="[] call TYR_fnc_DebugCamera;";};
        class MapTeleport: TYR_UI_Button {idc=285; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.437; w=safeZoneW*0.148; h=safeZoneH*0.043; text="MAP TELEPORT"; onButtonClick="[] call TYR_debugToggleMapTeleport;";};
        class MapTeleportState: TYR_UI_Text {idc=286; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.485; w=safeZoneW*0.148; h=safeZoneH*0.031; style=2; sizeEx=0.019; colorText[]={0.55,0.70,0.82,1}; text="LEFT CLICK TP // OFF";};
        class Teleport: TYR_UI_Button {idc=282; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.530; w=safeZoneW*0.148; h=safeZoneH*0.043; text="TP TO TARGET HQ"; onButtonClick="[TYR_debugFaction] call TYR_fnc_DebugTeleport;";};
        class SpectatorState: TYR_UI_TextMulti {idc=283; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.590; w=safeZoneW*0.148; h=safeZoneH*0.095; sizeEx=0.019; colorText[]={0.48,0.59,0.68,1}; text="SPECTATOR // friendly only on death. Developer camera does not feed faction intelligence.";};

        // AI PAGE
        class AIThink: TYR_UI_ButtonAccent {idc=262; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.335; w=safeZoneW*0.148; h=safeZoneH*0.043; text="RUN THINK + TRACE"; onButtonClick="['flow'] call TYR_fnc_DebugMenuSetView; ['thinkTrace',[TYR_debugFaction]] call TYR_debugSend;";};
        class AIFlow: TYR_UI_Button {idc=263; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.386; w=safeZoneW*0.148; h=safeZoneH*0.043; text="DECISION FLOW"; onButtonClick="['flow'] call TYR_fnc_DebugMenuSetView;";};
        class AIOrderMap: TYR_UI_Button {idc=264; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.437; w=safeZoneW*0.148; h=safeZoneH*0.043; text="ORDER MAP"; onButtonClick="missionNamespace setVariable ['TYR_DebugOrderFocus',true]; ['map'] call TYR_fnc_DebugMenuSetView;";};
        class AISpawn: TYR_UI_Button {idc=261; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.488; w=safeZoneW*0.148; h=safeZoneH*0.043; text="SPAWN AI FORCE"; onButtonClick="['spawnForce',[TYR_debugFaction]] call TYR_debugSend;";};

        // COMMAND PAGE
        class CommandStatus: TYR_UI_TextMulti {idc=271; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.328; w=safeZoneW*0.148; h=safeZoneH*0.074; sizeEx=0.019; colorBackground[]={0.022,0.028,0.033,1}; text="STATUS --";};
        class CommandTeleport: TYR_UI_ButtonAccent {idc=272; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.414; w=safeZoneW*0.148; h=safeZoneH*0.041; text="TP TO COMMANDER"; onButtonClick="['commandTp',[TYR_debugFaction]] call TYR_debugSend;";};
        class CommandTick: TYR_UI_Button {idc=275; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.463; w=safeZoneW*0.148; h=safeZoneH*0.041; text="RUN COMMAND TICK"; onButtonClick="['commandTick',[]] call TYR_debugSend;";};
        class CommandFastTimer: TYR_UI_ButtonAccent {idc=277; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.512; w=safeZoneW*0.148; h=safeZoneH*0.041; text="FAST-FORWARD TIMER"; onButtonClick="['commandFastTimer',[TYR_debugFaction]] call TYR_debugSend;";};
        class CommandKillMain: TYR_UI_ButtonDanger {idc=273; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.579; w=safeZoneW*0.148; h=safeZoneH*0.041; text="KILL MAIN COMMANDER"; onButtonClick="['commandKillMain',[TYR_debugFaction]] call TYR_debugSend;";};
        class CommandKillOfficer: TYR_UI_ButtonDanger {idc=274; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.628; w=safeZoneW*0.148; h=safeZoneH*0.041; text="KILL ONE OFFICER"; onButtonClick="['commandKillOfficer',[TYR_debugFaction]] call TYR_debugSend;";};
        class CommandKillAll: TYR_UI_ButtonDanger {idc=276; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.677; w=safeZoneW*0.148; h=safeZoneH*0.041; text="KILL ALL COMMAND"; onButtonClick="['commandKillAll',[TYR_debugFaction]] call TYR_debugSend;";};

        // ECONOMY PAGE - compact two-column actions.
        class EconomyReadout: TYR_UI_TextMulti {idc=221; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.328; w=safeZoneW*0.148; h=safeZoneH*0.073; sizeEx=0.019; colorBackground[]={0.022,0.028,0.033,1}; text="STEEL -- // AMMO -- // FUEL -- // MANPOWER --";};
        class AddSteel: TYR_UI_ButtonAccent {idc=222; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.414; w=safeZoneW*0.071; h=safeZoneH*0.041; text="+STEEL"; onButtonClick="['resource',[TYR_debugFaction,'steel',10000]] call TYR_debugSend;";};
        class AddAmmo: TYR_UI_Button {idc=223; x=safeZoneX+safeZoneW*0.234; y=safeZoneY+safeZoneH*0.414; w=safeZoneW*0.071; h=safeZoneH*0.041; text="+AMMO"; onButtonClick="['resource',[TYR_debugFaction,'ammo',10000]] call TYR_debugSend;";};
        class AddFuel: TYR_UI_Button {idc=224; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.463; w=safeZoneW*0.071; h=safeZoneH*0.041; text="+FUEL"; onButtonClick="['resource',[TYR_debugFaction,'fuel',10000]] call TYR_debugSend;";};
        class AddManpower: TYR_UI_Button {idc=225; x=safeZoneX+safeZoneW*0.234; y=safeZoneY+safeZoneH*0.463; w=safeZoneW*0.071; h=safeZoneH*0.041; text="+100 MP"; onButtonClick="['resource',[TYR_debugFaction,'manpower',100]] call TYR_debugSend;";};
        class EconomyMax: TYR_UI_ButtonAccent {idc=226; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.520; w=safeZoneW*0.148; h=safeZoneH*0.041; text="MAX RESOURCES"; onButtonClick="['max',[TYR_debugFaction]] call TYR_debugSend;";};
        class EconomyTick: TYR_UI_Button {idc=227; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.569; w=safeZoneW*0.148; h=safeZoneH*0.041; text="RUN ECONOMY TICK"; onButtonClick="['factoryTick',[]] call TYR_debugSend;";};
        class ResearchUnlock: TYR_UI_Button {idc=241; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.626; w=safeZoneW*0.148; h=safeZoneH*0.041; text="UNLOCK RESEARCH"; onButtonClick="['unlockResearch',[TYR_debugFaction]] call TYR_debugSend;";};
        class ResearchReset: TYR_UI_ButtonDanger {idc=242; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.675; w=safeZoneW*0.148; h=safeZoneH*0.041; text="RESET RESEARCH"; onButtonClick="['resetResearch',[TYR_debugFaction]] call TYR_debugSend;";};

        // SYSTEM PAGE
        class SystemPerf: TYR_UI_TextMulti {idc=131; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.328; w=safeZoneW*0.148; h=safeZoneH*0.068; sizeEx=0.019; colorBackground[]={0.022,0.028,0.033,1}; text="CLIENT FPS -- // SERVER FPS --";};
        class SystemSync: TYR_UI_ButtonAccent {idc=303; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.414; w=safeZoneW*0.148; h=safeZoneH*0.041; text="SYNC STATE"; onButtonClick="['sync',[]] call TYR_debugSend;";};
        class SystemSave: TYR_UI_Button {idc=302; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.463; w=safeZoneW*0.148; h=safeZoneH*0.041; text="SAVE NOW"; onButtonClick="['save',[]] call TYR_debugSend;";};
        class SystemBoost: TYR_UI_Button {idc=301; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.512; w=safeZoneW*0.148; h=safeZoneH*0.041; text="BOOST TARGET"; onButtonClick="['boost',[TYR_debugFaction]] call TYR_debugSend;";};
        class SystemTests: TYR_UI_ButtonAccent {idc=304; x=safeZoneX+safeZoneW*0.157; y=safeZoneY+safeZoneH*0.561; w=safeZoneW*0.148; h=safeZoneH*0.041; text="RUN AUTOTEST"; onButtonClick="[] remoteExecCall ['TYR_fnc_ServerRunAutomatedTests',2];";};

        // Workspace tabs are always visible; they replace several left-side accordion sections.
        class TabMap: TYR_UI_Button {idc=411; x=safeZoneX+safeZoneW*0.347; y=safeZoneY+safeZoneH*0.096; w=safeZoneW*0.092; h=safeZoneH*0.036; text="TRUTH MAP"; onButtonClick="missionNamespace setVariable ['TYR_DebugOrderFocus',false]; ['map'] call TYR_fnc_DebugMenuSetView;";};
        class TabFlow: TYR_UI_Button {idc=412; x=safeZoneX+safeZoneW*0.444; y=safeZoneY+safeZoneH*0.096; w=safeZoneW*0.092; h=safeZoneH*0.036; text="AI FLOW"; onButtonClick="['flow'] call TYR_fnc_DebugMenuSetView;";};
        class TabIntel: TYR_UI_Button {idc=413; x=safeZoneX+safeZoneW*0.541; y=safeZoneY+safeZoneH*0.096; w=safeZoneW*0.092; h=safeZoneH*0.036; text="INTEL MAP"; onButtonClick="['intel'] call TYR_fnc_DebugMenuSetView;";};
        class TabTests: TYR_UI_Button {idc=414; x=safeZoneX+safeZoneW*0.638; y=safeZoneY+safeZoneH*0.096; w=safeZoneW*0.092; h=safeZoneH*0.036; text="TESTS"; onButtonClick="['tasks'] call TYR_fnc_DebugMenuSetView;";};
        class TabLog: TYR_UI_Button {idc=415; x=safeZoneX+safeZoneW*0.735; y=safeZoneY+safeZoneH*0.096; w=safeZoneW*0.092; h=safeZoneH*0.036; text="INTEL LOG"; onButtonClick="['log'] call TYR_fnc_DebugMenuSetView;";};
        class TabConsole: TYR_UI_Button {idc=416; x=safeZoneX+safeZoneW*0.832; y=safeZoneY+safeZoneH*0.096; w=safeZoneW*0.122; h=safeZoneH*0.036; text="COMMANDS"; onButtonClick="['commands'] call TYR_fnc_DebugMenuSetView;";};

        class DebugMap: RscMapControl {idc=1000; x=safeZoneX+safeZoneW*0.344; y=safeZoneY+safeZoneH*0.145; w=safeZoneW*0.622; h=safeZoneH*0.782;};
        class MapInstruction: TYR_UI_Text {idc=1001; x=safeZoneX+safeZoneW*0.355; y=safeZoneY+safeZoneH*0.157; w=safeZoneW*0.596; h=safeZoneH*0.032; colorBackground[]={0.02,0.025,0.03,0.86}; text="OMNISCIENT SERVER TRUTH"; sizeEx=0.020;};

        class TestBackdrop: TYR_UI_Text {idc=2199; x=safeZoneX+safeZoneW*0.344; y=safeZoneY+safeZoneH*0.145; w=safeZoneW*0.622; h=safeZoneH*0.782; colorBackground[]={0.018,0.023,0.029,1};};
        class TestTitle: TYR_UI_Text {idc=2200; x=safeZoneX+safeZoneW*0.365; y=safeZoneY+safeZoneH*0.170; w=safeZoneW*0.58; h=safeZoneH*0.040; style=2; sizeEx=0.028; colorText[]={0.851,0.5647,0.0863,1}; text="MANUAL RUNTIME TEST TASKS";};
        class TestList: TYR_UI_List {idc=2201; x=safeZoneX+safeZoneW*0.365; y=safeZoneY+safeZoneH*0.225; w=safeZoneW*0.58; h=safeZoneH*0.38; onLBSelChanged="[] call TYR_debugTaskSelectionChanged;";};
        class TestDetail: TYR_UI_TextMulti {idc=2202; x=safeZoneX+safeZoneW*0.365; y=safeZoneY+safeZoneH*0.620; w=safeZoneW*0.58; h=safeZoneH*0.17; sizeEx=0.022; colorBackground[]={0.035,0.043,0.052,0.98}; text="Select a task.";};
        class TestPass: TYR_UI_ButtonAccent {idc=2203; x=safeZoneX+safeZoneW*0.365; y=safeZoneY+safeZoneH*0.810; w=safeZoneW*0.18; h=safeZoneH*0.048; text="MARK PASS"; onButtonClick="['PASS'] call TYR_debugTaskMark;";};
        class TestFail: TYR_UI_ButtonDanger {idc=2204; x=safeZoneX+safeZoneW*0.565; y=safeZoneY+safeZoneH*0.810; w=safeZoneW*0.18; h=safeZoneH*0.048; text="MARK FAIL"; onButtonClick="['FAIL'] call TYR_debugTaskMark;";};
        class TestReset: TYR_UI_Button {idc=2205; x=safeZoneX+safeZoneW*0.765; y=safeZoneY+safeZoneH*0.810; w=safeZoneW*0.18; h=safeZoneH*0.048; text="RESET TASKS"; onButtonClick="[] call TYR_debugTaskReset;";};

        class IntelLogBackdrop: TYR_UI_Text {idc=2299; x=safeZoneX+safeZoneW*0.344; y=safeZoneY+safeZoneH*0.145; w=safeZoneW*0.622; h=safeZoneH*0.782; colorBackground[]={0.018,0.023,0.029,1};};
        class IntelLogTitle: TYR_UI_Text {idc=2300; x=safeZoneX+safeZoneW*0.365; y=safeZoneY+safeZoneH*0.170; w=safeZoneW*0.58; h=safeZoneH*0.040; style=2; sizeEx=0.028; colorText[]={0.851,0.5647,0.0863,1}; text="FACTION INTELLIGENCE LOG";};
        class IntelLogList: TYR_UI_List {idc=2301; x=safeZoneX+safeZoneW*0.365; y=safeZoneY+safeZoneH*0.225; w=safeZoneW*0.58; h=safeZoneH*0.62;};

        class CommandBackdrop: TYR_UI_Text {idc=2399; x=safeZoneX+safeZoneW*0.344; y=safeZoneY+safeZoneH*0.145; w=safeZoneW*0.622; h=safeZoneH*0.782; colorBackground[]={0.018,0.023,0.029,1};};
        class CommandTitle: TYR_UI_Text {idc=2400; x=safeZoneX+safeZoneW*0.365; y=safeZoneY+safeZoneH*0.170; w=safeZoneW*0.58; h=safeZoneH*0.040; style=2; sizeEx=0.028; colorText[]={0.851,0.5647,0.0863,1}; text="DEVELOPER COMMAND CONSOLE";};
        class CommandHelp: TYR_UI_TextMulti {idc=2406; x=safeZoneX+safeZoneW*0.365; y=safeZoneY+safeZoneH*0.220; w=safeZoneW*0.58; h=safeZoneH*0.072; sizeEx=0.020; colorText[]={0.58,0.65,0.72,1}; text="LOCAL executes on this client. SERVER executes on the authoritative server. DEV mode only.";};
        class CommandEdit: TYR_UI_EditMulti {idc=2401; x=safeZoneX+safeZoneW*0.365; y=safeZoneY+safeZoneH*0.305; w=safeZoneW*0.58; h=safeZoneH*0.29; text="";};
        class CommandRunLocal: TYR_UI_ButtonAccent {idc=2402; x=safeZoneX+safeZoneW*0.365; y=safeZoneY+safeZoneH*0.615; w=safeZoneW*0.18; h=safeZoneH*0.045; text="RUN LOCAL"; onButtonClick="[false] call TYR_fnc_DebugRunCommand;";};
        class CommandRunServer: TYR_UI_Button {idc=2403; x=safeZoneX+safeZoneW*0.565; y=safeZoneY+safeZoneH*0.615; w=safeZoneW*0.18; h=safeZoneH*0.045; text="RUN SERVER"; onButtonClick="[true] call TYR_fnc_DebugRunCommand;";};
        class CommandClear: TYR_UI_Button {idc=2405; x=safeZoneX+safeZoneW*0.765; y=safeZoneY+safeZoneH*0.615; w=safeZoneW*0.18; h=safeZoneH*0.045; text="CLEAR"; onButtonClick="((findDisplay 1700) displayCtrl 2401) ctrlSetText ''; ((findDisplay 1700) displayCtrl 2404) ctrlSetText '';";};
        class CommandResult: TYR_UI_TextMulti {idc=2404; x=safeZoneX+safeZoneW*0.365; y=safeZoneY+safeZoneH*0.680; w=safeZoneW*0.58; h=safeZoneH*0.165; sizeEx=0.021; colorBackground[]={0.025,0.03,0.036,1}; text="Result appears here.";};

        // AI flowchart remains an actual diagram; only this view receives rapid trace updates.
        class FlowBackdrop: TYR_UI_Text {idc=2099; x=safeZoneX+safeZoneW*0.344; y=safeZoneY+safeZoneH*0.145; w=safeZoneW*0.622; h=safeZoneH*0.782; colorBackground[]={0.018,0.023,0.029,1};};
        class FlowTitle: TYR_UI_Text {idc=2100; x=safeZoneX+safeZoneW*0.355; y=safeZoneY+safeZoneH*0.158; w=safeZoneW*0.598; h=safeZoneH*0.034; style=2; sizeEx=0.024; colorText[]={0.851,0.5647,0.0863,1}; text="AI STRATEGIC DECISION PATH";};
        class FlowNode1: TYR_UI_TextMulti {idc=2101; x=safeZoneX+safeZoneW*0.360; y=safeZoneY+safeZoneH*0.208; w=safeZoneW*0.270; h=safeZoneH*0.068; style=18; sizeEx=0.018; colorBackground[]={0.045,0.052,0.060,1}; text="1 // COMMAND STATE";};
        class FlowNode2: TYR_UI_TextMulti {idc=2102; x=safeZoneX+safeZoneW*0.360; y=safeZoneY+safeZoneH*0.300; w=safeZoneW*0.270; h=safeZoneH*0.068; style=18; sizeEx=0.018; colorBackground[]={0.045,0.052,0.060,1}; text="2 // EMERGENCY";};
        class FlowNode3: TYR_UI_TextMulti {idc=2103; x=safeZoneX+safeZoneW*0.360; y=safeZoneY+safeZoneH*0.392; w=safeZoneW*0.270; h=safeZoneH*0.068; style=18; sizeEx=0.018; colorBackground[]={0.045,0.052,0.060,1}; text="3 // STRATEGIC PICTURE";};
        class FlowNode4: TYR_UI_TextMulti {idc=2104; x=safeZoneX+safeZoneW*0.360; y=safeZoneY+safeZoneH*0.484; w=safeZoneW*0.270; h=safeZoneH*0.068; style=18; sizeEx=0.018; colorBackground[]={0.045,0.052,0.060,1}; text="4 // OP REVIEW";};
        class FlowNode5: TYR_UI_TextMulti {idc=2105; x=safeZoneX+safeZoneW*0.360; y=safeZoneY+safeZoneH*0.576; w=safeZoneW*0.270; h=safeZoneH*0.068; style=18; sizeEx=0.018; colorBackground[]={0.045,0.052,0.060,1}; text="5 // POSTURE";};
        class FlowNode6: TYR_UI_TextMulti {idc=2106; x=safeZoneX+safeZoneW*0.360; y=safeZoneY+safeZoneH*0.668; w=safeZoneW*0.270; h=safeZoneH*0.068; style=18; sizeEx=0.018; colorBackground[]={0.045,0.052,0.060,1}; text="6 // GENERATE";};
        class FlowNode7: TYR_UI_TextMulti {idc=2107; x=safeZoneX+safeZoneW*0.675; y=safeZoneY+safeZoneH*0.668; w=safeZoneW*0.270; h=safeZoneH*0.068; style=18; sizeEx=0.018; colorBackground[]={0.045,0.052,0.060,1}; text="7 // SCORE";};
        class FlowNode8: TYR_UI_TextMulti {idc=2108; x=safeZoneX+safeZoneW*0.675; y=safeZoneY+safeZoneH*0.576; w=safeZoneW*0.270; h=safeZoneH*0.068; style=18; sizeEx=0.018; colorBackground[]={0.045,0.052,0.060,1}; text="8 // VALIDATE";};
        class FlowNode9: TYR_UI_TextMulti {idc=2109; x=safeZoneX+safeZoneW*0.675; y=safeZoneY+safeZoneH*0.484; w=safeZoneW*0.270; h=safeZoneH*0.068; style=18; sizeEx=0.018; colorBackground[]={0.045,0.052,0.060,1}; text="9 // CREATE ORDER";};
        class FlowNode10: TYR_UI_TextMulti {idc=2110; x=safeZoneX+safeZoneW*0.675; y=safeZoneY+safeZoneH*0.392; w=safeZoneW*0.270; h=safeZoneH*0.068; style=18; sizeEx=0.018; colorBackground[]={0.045,0.052,0.060,1}; text="10 // COMMAND ROUTE";};
        class FlowNode11: TYR_UI_TextMulti {idc=2111; x=safeZoneX+safeZoneW*0.675; y=safeZoneY+safeZoneH*0.300; w=safeZoneW*0.270; h=safeZoneH*0.068; style=18; sizeEx=0.018; colorBackground[]={0.045,0.052,0.060,1}; text="11 // FORCE EXECUTION";};
        class FlowNode12: TYR_UI_TextMulti {idc=2112; x=safeZoneX+safeZoneW*0.675; y=safeZoneY+safeZoneH*0.208; w=safeZoneW*0.270; h=safeZoneH*0.068; style=18; sizeEx=0.018; colorBackground[]={0.045,0.052,0.060,1}; text="12 // REVIEW / OUTCOME";};
        class FlowArrow1: TYR_UI_Text {idc=2131; x=safeZoneX+safeZoneW*0.472; y=safeZoneY+safeZoneH*0.277; w=safeZoneW*0.045; h=safeZoneH*0.022; style=2; text="v";};
        class FlowArrow2: TYR_UI_Text {idc=2132; x=safeZoneX+safeZoneW*0.472; y=safeZoneY+safeZoneH*0.369; w=safeZoneW*0.045; h=safeZoneH*0.022; style=2; text="v";};
        class FlowArrow3: TYR_UI_Text {idc=2133; x=safeZoneX+safeZoneW*0.472; y=safeZoneY+safeZoneH*0.461; w=safeZoneW*0.045; h=safeZoneH*0.022; style=2; text="v";};
        class FlowArrow4: TYR_UI_Text {idc=2134; x=safeZoneX+safeZoneW*0.472; y=safeZoneY+safeZoneH*0.553; w=safeZoneW*0.045; h=safeZoneH*0.022; style=2; text="v";};
        class FlowArrow5: TYR_UI_Text {idc=2135; x=safeZoneX+safeZoneW*0.472; y=safeZoneY+safeZoneH*0.645; w=safeZoneW*0.045; h=safeZoneH*0.022; style=2; text="v";};
        class FlowArrow6: TYR_UI_Text {idc=2136; x=safeZoneX+safeZoneW*0.635; y=safeZoneY+safeZoneH*0.685; w=safeZoneW*0.040; h=safeZoneH*0.022; style=2; text=">";};
        class FlowArrow7: TYR_UI_Text {idc=2137; x=safeZoneX+safeZoneW*0.787; y=safeZoneY+safeZoneH*0.645; w=safeZoneW*0.045; h=safeZoneH*0.022; style=2; text="^";};
        class FlowArrow8: TYR_UI_Text {idc=2138; x=safeZoneX+safeZoneW*0.787; y=safeZoneY+safeZoneH*0.553; w=safeZoneW*0.045; h=safeZoneH*0.022; style=2; text="^";};
        class FlowArrow9: TYR_UI_Text {idc=2139; x=safeZoneX+safeZoneW*0.787; y=safeZoneY+safeZoneH*0.461; w=safeZoneW*0.045; h=safeZoneH*0.022; style=2; text="^";};
        class FlowArrow10: TYR_UI_Text {idc=2140; x=safeZoneX+safeZoneW*0.787; y=safeZoneY+safeZoneH*0.369; w=safeZoneW*0.045; h=safeZoneH*0.022; style=2; text="^";};
        class FlowArrow11: TYR_UI_Text {idc=2141; x=safeZoneX+safeZoneW*0.787; y=safeZoneY+safeZoneH*0.277; w=safeZoneW*0.045; h=safeZoneH*0.022; style=2; text="^";};
        class FlowCandidates: TYR_UI_TextMulti {idc=2150; x=safeZoneX+safeZoneW*0.360; y=safeZoneY+safeZoneH*0.755; w=safeZoneW*0.385; h=safeZoneH*0.145; sizeEx=0.017; colorBackground[]={0.025,0.03,0.036,1}; colorText[]={0.62,0.68,0.74,1}; text="CANDIDATES // waiting";};
        class FlowOutcome: TYR_UI_TextMulti {idc=2151; x=safeZoneX+safeZoneW*0.760; y=safeZoneY+safeZoneH*0.755; w=safeZoneW*0.185; h=safeZoneH*0.145; style=18; sizeEx=0.019; colorBackground[]={0.055,0.050,0.030,1}; colorText[]={0.92,0.80,0.45,1}; text="DECISION // waiting";};
    };
};
