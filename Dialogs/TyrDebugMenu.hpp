class TyrDebugMenu
{
    idd = 1700;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = "missionNamespace setVariable ['TYR_debugOpenSection','views']; missionNamespace setVariable ['TYR_debugView','map']; [] call TYR_fnc_DebugMenuRefresh;";
    onUnload = "missionNamespace setVariable ['TYR_debugOpenSection',''];";

    class ControlsBackground
    {
        class Backdrop: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW; h=safeZoneH; colorBackground[]={0.015,0.02,0.025,0.98};};
        class Header: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW; h=safeZoneH*0.065; text="TYRANTS V4 // DEVELOPER OPERATIONS CONSOLE"; sizeEx=0.042; colorBackground[]={0.055,0.065,0.075,1};};
        class Accent: TYR_UI_Text {x=safeZoneX; y=safeZoneY; w=safeZoneW*0.007; h=safeZoneH; colorBackground[]={0.851,0.5647,0.0863,1};};
        class SidePanel: TYR_UI_Text {x=safeZoneX+safeZoneW*0.02; y=safeZoneY+safeZoneH*0.09; w=safeZoneW*0.29; h=safeZoneH*0.86; colorBackground[]={0.035,0.043,0.052,0.98};};
        class RightFrame: TYR_UI_Text {x=safeZoneX+safeZoneW*0.33; y=safeZoneY+safeZoneH*0.09; w=safeZoneW*0.65; h=safeZoneH*0.86; colorBackground[]={0.01,0.012,0.015,1};};
    };

    class Controls
    {
        class Status: TYR_UI_Text {idc=130; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.095; w=safeZoneW*0.25; h=safeZoneH*0.028; sizeEx=0.023; colorText[]={0.55,0.60,0.65,1}; text="SERVER // waiting";};

        // Accordion section headers. Their Y positions are reflowed at runtime.
        class SectionFaction: TYR_UI_Button {idc=201; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.13; w=safeZoneW*0.25; h=safeZoneH*0.042; text="FACTION TARGET"; onButtonClick="['faction'] call TYR_debugToggleSection;";};
        class FactionWest: TYR_UI_Button {idc=202; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="WEST / NATO"; onButtonClick="['west'] call TYR_debugSelect;";};
        class FactionEast: TYR_UI_Button {idc=203; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="EAST / CSAT"; onButtonClick="['east'] call TYR_debugSelect;";};
        class FactionIndependent: TYR_UI_Button {idc=204; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="INDEPENDENT / AAF"; onButtonClick="['independent'] call TYR_debugSelect;";};
        class FactionTarget: TYR_UI_Text {idc=205; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.045; style=2; sizeEx=0.026; colorText[]={0.851,0.5647,0.0863,1}; text="TARGET";};

        class SectionEconomy: TYR_UI_Button {idc=220; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.042; text="ECONOMY"; onButtonClick="['economy'] call TYR_debugToggleSection;";};
        class EconomyReadout: TYR_UI_TextMulti {idc=221; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.065; sizeEx=0.022; text="STEEL -- // AMMO -- // FUEL -- // MANPOWER --";};
        class AddSteel: TYR_UI_ButtonAccent {idc=222; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="+10K STEEL"; onButtonClick="['resource',[TYR_debugFaction,'steel',10000]] call TYR_debugSend;";};
        class AddAmmo: TYR_UI_Button {idc=223; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="+10K AMMO"; onButtonClick="['resource',[TYR_debugFaction,'ammo',10000]] call TYR_debugSend;";};
        class AddFuel: TYR_UI_Button {idc=224; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="+10K FUEL"; onButtonClick="['resource',[TYR_debugFaction,'fuel',10000]] call TYR_debugSend;";};
        class AddManpower: TYR_UI_Button {idc=225; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="+100 MANPOWER"; onButtonClick="['resource',[TYR_debugFaction,'manpower',100]] call TYR_debugSend;";};
        class EconomyMax: TYR_UI_Button {idc=226; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="MAX ALL RESOURCES"; onButtonClick="['max',[TYR_debugFaction]] call TYR_debugSend;";};
        class EconomyTick: TYR_UI_Button {idc=227; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="RUN ECONOMY TICK"; onButtonClick="['factoryTick',[]] call TYR_debugSend;";};

        class SectionResearch: TYR_UI_Button {idc=240; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.042; text="RESEARCH"; onButtonClick="['research'] call TYR_debugToggleSection;";};
        class ResearchUnlock: TYR_UI_ButtonAccent {idc=241; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="UNLOCK ALL RESEARCH"; onButtonClick="['unlockResearch',[TYR_debugFaction]] call TYR_debugSend;";};
        class ResearchReset: TYR_UI_ButtonDanger {idc=242; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="RESET RESEARCH"; onButtonClick="['resetResearch',[TYR_debugFaction]] call TYR_debugSend;";};

        class SectionAI: TYR_UI_Button {idc=260; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.042; text="AI COMMAND"; onButtonClick="['ai'] call TYR_debugToggleSection;";};
        class AISpawn: TYR_UI_ButtonAccent {idc=261; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="SPAWN AI FORCE"; onButtonClick="['spawnForce',[TYR_debugFaction]] call TYR_debugSend;";};
        class AIThink: TYR_UI_Button {idc=262; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="RUN THINK + TRACE"; onButtonClick="['flow'] call TYR_debugSetView; ['thinkTrace',[TYR_debugFaction]] call TYR_debugSend;";};
        class AIFlow: TYR_UI_Button {idc=263; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="SHOW AI DECISION FLOW"; onButtonClick="['flow'] call TYR_debugSetView; ['debugMap',[]] call TYR_debugSend;";};
        class AIOrderMap: TYR_UI_Button {idc=264; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="SHOW AI ORDER MAP"; onButtonClick="missionNamespace setVariable ['TYR_DebugOrderFocus',true]; ['map'] call TYR_debugSetView; ['debugMap',[]] call TYR_debugSend;";};

        class SectionCommand: TYR_UI_Button {idc=270; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.042; text="COMMAND NETWORK"; onButtonClick="['commandnet'] call TYR_debugToggleSection;";};
        class CommandStatus: TYR_UI_TextMulti {idc=271; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.065; sizeEx=0.021; text="STATUS -- // COMMANDER -- // OFFICERS --";};
        class CommandTeleport: TYR_UI_ButtonAccent {idc=272; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="TP TO MAIN COMMANDER"; onButtonClick="['commandTp',[TYR_debugFaction]] call TYR_debugSend;";};
        class CommandKillMain: TYR_UI_ButtonDanger {idc=273; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="KILL MAIN COMMANDER"; onButtonClick="['commandKillMain',[TYR_debugFaction]] call TYR_debugSend;";};
        class CommandKillOfficer: TYR_UI_ButtonDanger {idc=274; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="KILL ONE OFFICER"; onButtonClick="['commandKillOfficer',[TYR_debugFaction]] call TYR_debugSend;";};
        class CommandKillAll: TYR_UI_ButtonDanger {idc=276; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="KILL ALL COMMAND"; onButtonClick="['commandKillAll',[TYR_debugFaction]] call TYR_debugSend;";};
        class CommandFastTimer: TYR_UI_ButtonAccent {idc=277; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="FAST-FORWARD COMMAND TIMER"; onButtonClick="['commandFastTimer',[TYR_debugFaction]] call TYR_debugSend;";};
        class CommandTick: TYR_UI_Button {idc=275; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="RUN COMMAND TICK"; onButtonClick="['commandTick',[]] call TYR_debugSend; ['debugMap',[]] call TYR_debugSend;";};

        class SectionViews: TYR_UI_Button {idc=280; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.042; text="VIEWS / MOVEMENT"; onButtonClick="['views'] call TYR_debugToggleSection;";};
        class ViewMap: TYR_UI_ButtonAccent {idc=281; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="OMNISCIENT MAP"; onButtonClick="missionNamespace setVariable ['TYR_DebugOrderFocus',false]; ['map'] call TYR_debugSetView; ['debugMap',[]] call TYR_debugSend;";};
        class Teleport: TYR_UI_Button {idc=282; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="TP TO TARGET HQ"; onButtonClick="[TYR_debugFaction] call TYR_fnc_DebugTeleport;";};
        class DebugCamera: TYR_UI_ButtonAccent {idc=284; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="OPEN SPLENDID CAMERA"; onButtonClick="[] call TYR_fnc_DebugCamera;";};
        class MapTeleport: TYR_UI_Button {idc=285; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="MAP CLICK TELEPORT"; onButtonClick="[] call TYR_debugToggleMapTeleport;";};
        class MapTeleportState: TYR_UI_Text {idc=286; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; style=2; sizeEx=0.021; colorText[]={0.55,0.70,0.82,1}; text="LEFT-CLICK TP // OFF";};
        class SpectatorState: TYR_UI_TextMulti {idc=283; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.06; sizeEx=0.021; colorText[]={0.55,0.70,0.82,1}; text="SPECTATOR // friendly-only on death. SPLENDID CAMERA is developer-only and does not feed faction intelligence.";};

        class SectionTesting: TYR_UI_Button {idc=290; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.042; text="TESTING"; onButtonClick="['testing'] call TYR_debugToggleSection;";};
        class TestAuto: TYR_UI_ButtonAccent {idc=291; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="RUN FULL AUTOTEST"; onButtonClick="[] remoteExecCall ['TYR_fnc_ServerRunAutomatedTests',2];";};
        class TestTasks: TYR_UI_Button {idc=292; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="MANUAL TEST TASKS"; onButtonClick="['tasks'] call TYR_debugSetView;";};
        class TestIntelMap: TYR_UI_Button {idc=293; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="FACTION INTEL MAP"; onButtonClick="['intel'] call TYR_debugSetView;";};
        class TestIntelLog: TYR_UI_Button {idc=294; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="INTELLIGENCE LOG"; onButtonClick="['log'] call TYR_debugSetView;";};
        class TestCommands: TYR_UI_ButtonAccent {idc=295; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="COMMAND CONSOLE"; onButtonClick="['commands'] call TYR_debugSetView;";};

        class SectionSystem: TYR_UI_Button {idc=300; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.042; text="SYSTEM"; onButtonClick="['system'] call TYR_debugToggleSection;";};
        class SystemBoost: TYR_UI_Button {idc=301; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="BOOST TARGET"; onButtonClick="['boost',[TYR_debugFaction]] call TYR_debugSend;";};
        class SystemSave: TYR_UI_ButtonAccent {idc=302; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="SAVE NOW"; onButtonClick="['save',[]] call TYR_debugSend;";};
        class SystemSync: TYR_UI_Button {idc=303; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="SYNC STATE"; onButtonClick="['sync',[]] call TYR_debugSend;";};
        class SystemTests: TYR_UI_Button {idc=304; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="RUN AUTOTEST"; onButtonClick="[] remoteExecCall ['TYR_fnc_ServerRunAutomatedTests',2];";};
        class SystemPerf: TYR_UI_TextMulti {idc=131; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.05; sizeEx=0.021; text="CLIENT FPS -- // SERVER FPS --";};

        class Close: TYR_UI_Button {idc=399; x=safeZoneX+safeZoneW*0.04; y=safeZoneY+safeZoneH*0.902; w=safeZoneW*0.25; h=safeZoneH*0.034; text="RETURN TO GAME"; onButtonClick="closeDialog 0;";};

        // Omniscient map view. It is embedded in this console like the emplacement placer.
        class DebugMap: RscMapControl {idc=1000; x=safeZoneX+safeZoneW*0.34; y=safeZoneY+safeZoneH*0.10; w=safeZoneW*0.63; h=safeZoneH*0.84;};
        class MapInstruction: TYR_UI_Text {idc=1001; x=safeZoneX+safeZoneW*0.355; y=safeZoneY+safeZoneH*0.112; w=safeZoneW*0.58; h=safeZoneH*0.034; colorBackground[]={0.02,0.025,0.03,0.86}; text="OMNISCIENT SERVER TRUTH // refresh 3s // intelligence restrictions intentionally bypassed"; sizeEx=0.023;};

        // Manual runtime verification task list for engine behaviours that static/server tests cannot prove.
        class TestBackdrop: TYR_UI_Text {idc=2199; x=safeZoneX+safeZoneW*0.34; y=safeZoneY+safeZoneH*0.10; w=safeZoneW*0.63; h=safeZoneH*0.84; colorBackground[]={0.018,0.023,0.029,1};};
        class TestTitle: TYR_UI_Text {idc=2200; x=safeZoneX+safeZoneW*0.37; y=safeZoneY+safeZoneH*0.12; w=safeZoneW*0.57; h=safeZoneH*0.042; style=2; sizeEx=0.032; colorText[]={0.851,0.5647,0.0863,1}; text="MANUAL RUNTIME TEST TASKS";};
        class TestList: TYR_UI_List {idc=2201; x=safeZoneX+safeZoneW*0.37; y=safeZoneY+safeZoneH*0.18; w=safeZoneW*0.57; h=safeZoneH*0.40; onLBSelChanged="[] call TYR_debugTaskSelectionChanged;";};
        class TestDetail: TYR_UI_TextMulti {idc=2202; x=safeZoneX+safeZoneW*0.37; y=safeZoneY+safeZoneH*0.60; w=safeZoneW*0.57; h=safeZoneH*0.18; sizeEx=0.024; colorBackground[]={0.035,0.043,0.052,0.98}; text="Select a task.";};
        class TestPass: TYR_UI_ButtonAccent {idc=2203; x=safeZoneX+safeZoneW*0.37; y=safeZoneY+safeZoneH*0.80; w=safeZoneW*0.17; h=safeZoneH*0.05; text="MARK PASS"; onButtonClick="['PASS'] call TYR_debugTaskMark;";};
        class TestFail: TYR_UI_ButtonDanger {idc=2204; x=safeZoneX+safeZoneW*0.57; y=safeZoneY+safeZoneH*0.80; w=safeZoneW*0.17; h=safeZoneH*0.05; text="MARK FAIL"; onButtonClick="['FAIL'] call TYR_debugTaskMark;";};
        class TestReset: TYR_UI_Button {idc=2205; x=safeZoneX+safeZoneW*0.77; y=safeZoneY+safeZoneH*0.80; w=safeZoneW*0.17; h=safeZoneH*0.05; text="RESET TASKS"; onButtonClick="[] call TYR_debugTaskReset;";};

        // Raw faction intelligence event log. This is faction knowledge, not omniscient server truth.
        class IntelLogBackdrop: TYR_UI_Text {idc=2299; x=safeZoneX+safeZoneW*0.34; y=safeZoneY+safeZoneH*0.10; w=safeZoneW*0.63; h=safeZoneH*0.84; colorBackground[]={0.018,0.023,0.029,1};};
        class IntelLogTitle: TYR_UI_Text {idc=2300; x=safeZoneX+safeZoneW*0.37; y=safeZoneY+safeZoneH*0.12; w=safeZoneW*0.57; h=safeZoneH*0.042; style=2; sizeEx=0.032; colorText[]={0.851,0.5647,0.0863,1}; text="FACTION INTELLIGENCE LOG";};
        class IntelLogList: TYR_UI_List {idc=2301; x=safeZoneX+safeZoneW*0.37; y=safeZoneY+safeZoneH*0.18; w=safeZoneW*0.57; h=safeZoneH*0.64;};

        // Developer command runner. LOCAL executes on this client; SERVER is routed through
        // the existing debug-mode-gated server endpoint. This is intentionally DEV-only.
        class CommandBackdrop: TYR_UI_Text {idc=2399; x=safeZoneX+safeZoneW*0.34; y=safeZoneY+safeZoneH*0.10; w=safeZoneW*0.63; h=safeZoneH*0.84; colorBackground[]={0.018,0.023,0.029,1};};
        class CommandTitle: TYR_UI_Text {idc=2400; x=safeZoneX+safeZoneW*0.37; y=safeZoneY+safeZoneH*0.12; w=safeZoneW*0.57; h=safeZoneH*0.042; style=2; sizeEx=0.032; colorText[]={0.851,0.5647,0.0863,1}; text="DEVELOPER COMMAND CONSOLE";};
        class CommandHelp: TYR_UI_TextMulti {idc=2406; x=safeZoneX+safeZoneW*0.37; y=safeZoneY+safeZoneH*0.17; w=safeZoneW*0.57; h=safeZoneH*0.085; sizeEx=0.022; colorText[]={0.58,0.65,0.72,1}; text="LOCAL runs on your client. SERVER runs on the authoritative server. Standard Arma Debug Console is also enabled for the host/logged-in admin in this DEV build.";};
        class CommandEdit: TYR_UI_EditMulti {idc=2401; x=safeZoneX+safeZoneW*0.37; y=safeZoneY+safeZoneH*0.27; w=safeZoneW*0.57; h=safeZoneH*0.32; text="";};
        class CommandRunLocal: TYR_UI_ButtonAccent {idc=2402; x=safeZoneX+safeZoneW*0.37; y=safeZoneY+safeZoneH*0.61; w=safeZoneW*0.18; h=safeZoneH*0.045; text="RUN LOCAL"; onButtonClick="[false] call TYR_fnc_DebugRunCommand;";};
        class CommandRunServer: TYR_UI_Button {idc=2403; x=safeZoneX+safeZoneW*0.565; y=safeZoneY+safeZoneH*0.61; w=safeZoneW*0.18; h=safeZoneH*0.045; text="RUN SERVER"; onButtonClick="[true] call TYR_fnc_DebugRunCommand;";};
        class CommandClear: TYR_UI_Button {idc=2405; x=safeZoneX+safeZoneW*0.76; y=safeZoneY+safeZoneH*0.61; w=safeZoneW*0.18; h=safeZoneH*0.045; text="CLEAR"; onButtonClick="((findDisplay 1700) displayCtrl 2401) ctrlSetText ''; ((findDisplay 1700) displayCtrl 2404) ctrlSetText '';";};
        class CommandResult: TYR_UI_TextMulti {idc=2404; x=safeZoneX+safeZoneW*0.37; y=safeZoneY+safeZoneH*0.68; w=safeZoneW*0.57; h=safeZoneH*0.19; sizeEx=0.023; colorBackground[]={0.025,0.03,0.036,1}; text="Result appears here. Script errors still appear in the Arma RPT.";};

        // AI strategic decision-flow view. Twelve real stages are shown in a snake
        // layout so the latest path, branch outcome and current thought point are visible.
        class FlowBackdrop: TYR_UI_Text {idc=2099; x=safeZoneX+safeZoneW*0.34; y=safeZoneY+safeZoneH*0.10; w=safeZoneW*0.63; h=safeZoneH*0.84; colorBackground[]={0.018,0.023,0.029,1};};
        class FlowTitle: TYR_UI_Text {idc=2100; x=safeZoneX+safeZoneW*0.36; y=safeZoneY+safeZoneH*0.112; w=safeZoneW*0.59; h=safeZoneH*0.040; style=2; sizeEx=0.029; colorText[]={0.851,0.5647,0.0863,1}; text="AI STRATEGIC DECISION PATH";};

        class FlowNode1: TYR_UI_TextMulti {idc=2101; x=safeZoneX+safeZoneW*0.36; y=safeZoneY+safeZoneH*0.165; w=safeZoneW*0.275; h=safeZoneH*0.080; style=18; sizeEx=0.020; colorBackground[]={0.045,0.052,0.060,1}; text="1 // COMMAND STATE";};
        class FlowNode2: TYR_UI_TextMulti {idc=2102; x=safeZoneX+safeZoneW*0.36; y=safeZoneY+safeZoneH*0.270; w=safeZoneW*0.275; h=safeZoneH*0.080; style=18; sizeEx=0.020; colorBackground[]={0.045,0.052,0.060,1}; text="2 // EMERGENCY";};
        class FlowNode3: TYR_UI_TextMulti {idc=2103; x=safeZoneX+safeZoneW*0.36; y=safeZoneY+safeZoneH*0.375; w=safeZoneW*0.275; h=safeZoneH*0.080; style=18; sizeEx=0.020; colorBackground[]={0.045,0.052,0.060,1}; text="3 // STRATEGIC PICTURE";};
        class FlowNode4: TYR_UI_TextMulti {idc=2104; x=safeZoneX+safeZoneW*0.36; y=safeZoneY+safeZoneH*0.480; w=safeZoneW*0.275; h=safeZoneH*0.080; style=18; sizeEx=0.020; colorBackground[]={0.045,0.052,0.060,1}; text="4 // OP REVIEW";};
        class FlowNode5: TYR_UI_TextMulti {idc=2105; x=safeZoneX+safeZoneW*0.36; y=safeZoneY+safeZoneH*0.585; w=safeZoneW*0.275; h=safeZoneH*0.080; style=18; sizeEx=0.020; colorBackground[]={0.045,0.052,0.060,1}; text="5 // POSTURE";};
        class FlowNode6: TYR_UI_TextMulti {idc=2106; x=safeZoneX+safeZoneW*0.36; y=safeZoneY+safeZoneH*0.690; w=safeZoneW*0.275; h=safeZoneH*0.080; style=18; sizeEx=0.020; colorBackground[]={0.045,0.052,0.060,1}; text="6 // GENERATE";};

        class FlowNode7: TYR_UI_TextMulti {idc=2107; x=safeZoneX+safeZoneW*0.675; y=safeZoneY+safeZoneH*0.690; w=safeZoneW*0.275; h=safeZoneH*0.080; style=18; sizeEx=0.020; colorBackground[]={0.045,0.052,0.060,1}; text="7 // SCORE";};
        class FlowNode8: TYR_UI_TextMulti {idc=2108; x=safeZoneX+safeZoneW*0.675; y=safeZoneY+safeZoneH*0.585; w=safeZoneW*0.275; h=safeZoneH*0.080; style=18; sizeEx=0.020; colorBackground[]={0.045,0.052,0.060,1}; text="8 // VALIDATE";};
        class FlowNode9: TYR_UI_TextMulti {idc=2109; x=safeZoneX+safeZoneW*0.675; y=safeZoneY+safeZoneH*0.480; w=safeZoneW*0.275; h=safeZoneH*0.080; style=18; sizeEx=0.020; colorBackground[]={0.045,0.052,0.060,1}; text="9 // CREATE ORDER";};
        class FlowNode10: TYR_UI_TextMulti {idc=2110; x=safeZoneX+safeZoneW*0.675; y=safeZoneY+safeZoneH*0.375; w=safeZoneW*0.275; h=safeZoneH*0.080; style=18; sizeEx=0.020; colorBackground[]={0.045,0.052,0.060,1}; text="10 // COMMAND ROUTE";};
        class FlowNode11: TYR_UI_TextMulti {idc=2111; x=safeZoneX+safeZoneW*0.675; y=safeZoneY+safeZoneH*0.270; w=safeZoneW*0.275; h=safeZoneH*0.080; style=18; sizeEx=0.020; colorBackground[]={0.045,0.052,0.060,1}; text="11 // FORCE EXECUTION";};
        class FlowNode12: TYR_UI_TextMulti {idc=2112; x=safeZoneX+safeZoneW*0.675; y=safeZoneY+safeZoneH*0.165; w=safeZoneW*0.275; h=safeZoneH*0.080; style=18; sizeEx=0.020; colorBackground[]={0.045,0.052,0.060,1}; text="12 // OUTCOME";};

        class FlowArrow1: TYR_UI_Text {idc=2131; x=safeZoneX+safeZoneW*0.475; y=safeZoneY+safeZoneH*0.245; w=safeZoneW*0.045; h=safeZoneH*0.025; style=2; text="v"; colorText[]={0.55,0.60,0.65,1};};
        class FlowArrow2: TYR_UI_Text {idc=2132; x=safeZoneX+safeZoneW*0.475; y=safeZoneY+safeZoneH*0.350; w=safeZoneW*0.045; h=safeZoneH*0.025; style=2; text="v"; colorText[]={0.55,0.60,0.65,1};};
        class FlowArrow3: TYR_UI_Text {idc=2133; x=safeZoneX+safeZoneW*0.475; y=safeZoneY+safeZoneH*0.455; w=safeZoneW*0.045; h=safeZoneH*0.025; style=2; text="v"; colorText[]={0.55,0.60,0.65,1};};
        class FlowArrow4: TYR_UI_Text {idc=2134; x=safeZoneX+safeZoneW*0.475; y=safeZoneY+safeZoneH*0.560; w=safeZoneW*0.045; h=safeZoneH*0.025; style=2; text="v"; colorText[]={0.55,0.60,0.65,1};};
        class FlowArrow5: TYR_UI_Text {idc=2135; x=safeZoneX+safeZoneW*0.475; y=safeZoneY+safeZoneH*0.665; w=safeZoneW*0.045; h=safeZoneH*0.025; style=2; text="v"; colorText[]={0.55,0.60,0.65,1};};
        class FlowArrow6: TYR_UI_Text {idc=2136; x=safeZoneX+safeZoneW*0.635; y=safeZoneY+safeZoneH*0.712; w=safeZoneW*0.040; h=safeZoneH*0.030; style=2; text=">"; colorText[]={0.851,0.5647,0.0863,1};};
        class FlowArrow7: TYR_UI_Text {idc=2137; x=safeZoneX+safeZoneW*0.790; y=safeZoneY+safeZoneH*0.665; w=safeZoneW*0.045; h=safeZoneH*0.025; style=2; text="^"; colorText[]={0.55,0.60,0.65,1};};
        class FlowArrow8: TYR_UI_Text {idc=2138; x=safeZoneX+safeZoneW*0.790; y=safeZoneY+safeZoneH*0.560; w=safeZoneW*0.045; h=safeZoneH*0.025; style=2; text="^"; colorText[]={0.55,0.60,0.65,1};};
        class FlowArrow9: TYR_UI_Text {idc=2139; x=safeZoneX+safeZoneW*0.790; y=safeZoneY+safeZoneH*0.455; w=safeZoneW*0.045; h=safeZoneH*0.025; style=2; text="^"; colorText[]={0.55,0.60,0.65,1};};
        class FlowArrow10: TYR_UI_Text {idc=2140; x=safeZoneX+safeZoneW*0.790; y=safeZoneY+safeZoneH*0.350; w=safeZoneW*0.045; h=safeZoneH*0.025; style=2; text="^"; colorText[]={0.55,0.60,0.65,1};};
        class FlowArrow11: TYR_UI_Text {idc=2141; x=safeZoneX+safeZoneW*0.790; y=safeZoneY+safeZoneH*0.245; w=safeZoneW*0.045; h=safeZoneH*0.025; style=2; text="^"; colorText[]={0.55,0.60,0.65,1};};

        class FlowCandidates: TYR_UI_TextMulti {idc=2150; x=safeZoneX+safeZoneW*0.36; y=safeZoneY+safeZoneH*0.790; w=safeZoneW*0.39; h=safeZoneH*0.125; sizeEx=0.018; colorBackground[]={0.025,0.03,0.036,1}; colorText[]={0.62,0.68,0.74,1}; text="CANDIDATES // waiting for AI think";};
        class FlowOutcome: TYR_UI_TextMulti {idc=2151; x=safeZoneX+safeZoneW*0.765; y=safeZoneY+safeZoneH*0.790; w=safeZoneW*0.185; h=safeZoneH*0.125; style=18; sizeEx=0.020; colorBackground[]={0.055,0.050,0.030,1}; colorText[]={0.92,0.80,0.45,1}; text="DECISION // waiting";};
    };
};
