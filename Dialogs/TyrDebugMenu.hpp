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
        class AIThink: TYR_UI_Button {idc=262; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="RUN COMMANDER THINK"; onButtonClick="['think',[TYR_debugFaction]] call TYR_debugSend;";};
        class AIFlow: TYR_UI_Button {idc=263; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="SHOW AI DECISION FLOW"; onButtonClick="['flow'] call TYR_debugSetView; ['debugMap',[]] call TYR_debugSend;";};

        class SectionViews: TYR_UI_Button {idc=280; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.042; text="VIEWS / MOVEMENT"; onButtonClick="['views'] call TYR_debugToggleSection;";};
        class ViewMap: TYR_UI_ButtonAccent {idc=281; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="OMNISCIENT MAP"; onButtonClick="['map'] call TYR_debugSetView; ['debugMap',[]] call TYR_debugSend;";};
        class Teleport: TYR_UI_Button {idc=282; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="TP TO TARGET HQ"; onButtonClick="[TYR_debugFaction] call TYR_fnc_DebugTeleport;";};
        class SpectatorState: TYR_UI_TextMulti {idc=283; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.06; sizeEx=0.021; colorText[]={0.55,0.70,0.82,1}; text="SPECTATOR ENABLED // On death: friendly units only, no free camera. Debug map remains omniscient.";};

        class SectionTesting: TYR_UI_Button {idc=290; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.042; text="TESTING"; onButtonClick="['testing'] call TYR_debugToggleSection;";};
        class TestAuto: TYR_UI_ButtonAccent {idc=291; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="RUN FULL AUTOTEST"; onButtonClick="[] remoteExecCall ['TYR_fnc_ServerRunAutomatedTests',2];";};
        class TestTasks: TYR_UI_Button {idc=292; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="MANUAL TEST TASKS"; onButtonClick="['tasks'] call TYR_debugSetView;";};
        class TestIntelMap: TYR_UI_Button {idc=293; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="FACTION INTEL MAP"; onButtonClick="['intel'] call TYR_debugSetView;";};
        class TestIntelLog: TYR_UI_Button {idc=294; x=safeZoneX+safeZoneW*0.04; y=0; w=safeZoneW*0.25; h=safeZoneH*0.04; text="INTELLIGENCE LOG"; onButtonClick="['log'] call TYR_debugSetView;";};

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

        // AI decision-flow view. This exposes explicit game-AI decisions/scores, not hidden model reasoning.
        class FlowBackdrop: TYR_UI_Text {idc=2099; x=safeZoneX+safeZoneW*0.34; y=safeZoneY+safeZoneH*0.10; w=safeZoneW*0.63; h=safeZoneH*0.84; colorBackground[]={0.018,0.023,0.029,1};};
        class FlowTitle: TYR_UI_Text {idc=2100; x=safeZoneX+safeZoneW*0.37; y=safeZoneY+safeZoneH*0.12; w=safeZoneW*0.57; h=safeZoneH*0.042; style=2; sizeEx=0.032; colorText[]={0.851,0.5647,0.0863,1}; text="AI COMMANDER DECISION FLOW";};
        class FlowNode1: TYR_UI_TextMulti {idc=2101; x=safeZoneX+safeZoneW*0.45; y=safeZoneY+safeZoneH*0.18; w=safeZoneW*0.41; h=safeZoneH*0.085; style=18; colorBackground[]={0.055,0.065,0.075,1}; text="1 // INPUT";};
        class FlowArrow1: TYR_UI_Text {idc=2111; x=safeZoneX+safeZoneW*0.62; y=safeZoneY+safeZoneH*0.266; w=safeZoneW*0.07; h=safeZoneH*0.03; style=2; text="v"; sizeEx=0.035; colorText[]={0.851,0.5647,0.0863,1};};
        class FlowNode2: TYR_UI_TextMulti {idc=2102; x=safeZoneX+safeZoneW*0.45; y=safeZoneY+safeZoneH*0.295; w=safeZoneW*0.41; h=safeZoneH*0.085; style=18; colorBackground[]={0.055,0.065,0.075,1}; text="2 // FORCE STATE";};
        class FlowArrow2: TYR_UI_Text {idc=2112; x=safeZoneX+safeZoneW*0.62; y=safeZoneY+safeZoneH*0.381; w=safeZoneW*0.07; h=safeZoneH*0.03; style=2; text="v"; sizeEx=0.035; colorText[]={0.851,0.5647,0.0863,1};};
        class FlowNode3: TYR_UI_TextMulti {idc=2103; x=safeZoneX+safeZoneW*0.45; y=safeZoneY+safeZoneH*0.41; w=safeZoneW*0.41; h=safeZoneH*0.085; style=18; colorBackground[]={0.055,0.065,0.075,1}; text="3 // RESEARCH";};
        class FlowArrow3: TYR_UI_Text {idc=2113; x=safeZoneX+safeZoneW*0.62; y=safeZoneY+safeZoneH*0.496; w=safeZoneW*0.07; h=safeZoneH*0.03; style=2; text="v"; sizeEx=0.035; colorText[]={0.851,0.5647,0.0863,1};};
        class FlowNode4: TYR_UI_TextMulti {idc=2104; x=safeZoneX+safeZoneW*0.45; y=safeZoneY+safeZoneH*0.525; w=safeZoneW*0.41; h=safeZoneH*0.085; style=18; colorBackground[]={0.055,0.065,0.075,1}; text="4 // OPERATION CHECK";};
        class FlowArrow4: TYR_UI_Text {idc=2114; x=safeZoneX+safeZoneW*0.62; y=safeZoneY+safeZoneH*0.611; w=safeZoneW*0.07; h=safeZoneH*0.03; style=2; text="v"; sizeEx=0.035; colorText[]={0.851,0.5647,0.0863,1};};
        class FlowNode5: TYR_UI_TextMulti {idc=2105; x=safeZoneX+safeZoneW*0.45; y=safeZoneY+safeZoneH*0.64; w=safeZoneW*0.41; h=safeZoneH*0.085; style=18; colorBackground[]={0.055,0.065,0.075,1}; text="5 // OBJECTIVE";};
        class FlowArrow5: TYR_UI_Text {idc=2115; x=safeZoneX+safeZoneW*0.62; y=safeZoneY+safeZoneH*0.726; w=safeZoneW*0.07; h=safeZoneH*0.03; style=2; text="v"; sizeEx=0.035; colorText[]={0.851,0.5647,0.0863,1};};
        class FlowNode6: TYR_UI_TextMulti {idc=2106; x=safeZoneX+safeZoneW*0.45; y=safeZoneY+safeZoneH*0.755; w=safeZoneW*0.41; h=safeZoneH*0.085; style=18; colorBackground[]={0.08,0.075,0.045,1}; text="6 // DECISION";};
        class FlowCandidates: TYR_UI_TextMulti {idc=2120; x=safeZoneX+safeZoneW*0.365; y=safeZoneY+safeZoneH*0.855; w=safeZoneW*0.58; h=safeZoneH*0.055; style=2; sizeEx=0.020; colorText[]={0.58,0.65,0.72,1}; text="OBJECTIVE SCORES // waiting for AI think";};
    };
};
