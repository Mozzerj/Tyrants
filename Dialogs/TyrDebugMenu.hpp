class TYR_DBG_Text
{
    type = 0;
    idc = -1;
    style = 0;
    font = "PuristaMedium";
    sizeEx = 0.03;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0,0,0,0};
    text = "";
};

class TYR_DBG_Button
{
    type = 1;
    idc = -1;
    style = 2;
    font = "PuristaMedium";
    sizeEx = 0.028;
    text = "";
    borderSize = 0;
    colorText[] = {0.05,0.05,0.05,1};
    colorDisabled[] = {0.4,0.4,0.4,1};
    colorBackground[] = {0.851,0.5647,0.0863,1};
    colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
    colorBackgroundActive[] = {1,0.68,0.12,1};
    colorFocused[] = {0.851,0.5647,0.0863,1};
    colorShadow[] = {0,0,0,0};
    colorBorder[] = {0,0,0,0};
    offsetX = 0;
    offsetY = 0;
    offsetPressedX = 0.002;
    offsetPressedY = 0.002;
    soundEnter[] = {"",0,1};
    soundPush[] = {"",0,1};
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
    soundEscape[] = {"",0,1};
};

class TyrDebugMenu
{
    idd = 1700;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = "[] call TYR_fnc_DebugMenuRefresh;";

    class ControlsBackground
    {
        class Backdrop: TYR_DBG_Text
        {
            x = safeZoneX + safeZoneW * 0.19;
            y = safeZoneY + safeZoneH * 0.12;
            w = safeZoneW * 0.62;
            h = safeZoneH * 0.76;
            colorBackground[] = {0.035,0.04,0.045,0.97};
        };
        class Header: TYR_DBG_Text
        {
            idc = 100;
            x = safeZoneX + safeZoneW * 0.19;
            y = safeZoneY + safeZoneH * 0.12;
            w = safeZoneW * 0.62;
            h = safeZoneH * 0.055;
            style = 2;
            sizeEx = 0.045;
            text = "DEBUG";
            colorText[] = {0.05,0.05,0.05,1};
            colorBackground[] = {0.851,0.5647,0.0863,1};
        };
    };

    class Controls
    {
        class FriendlyTitle: TYR_DBG_Text {idc=101; x=safeZoneX+safeZoneW*0.215; y=safeZoneY+safeZoneH*0.195; w=safeZoneW*0.27; h=safeZoneH*0.035; sizeEx=0.032; text="FRIENDLY";};
        class EnemyTitle: TYR_DBG_Text {idc=102; x=safeZoneX+safeZoneW*0.515; y=safeZoneY+safeZoneH*0.195; w=safeZoneW*0.27; h=safeZoneH*0.035; sizeEx=0.032; text="OPPONENT";};

        class FSteel: TYR_DBG_Text {idc=110; x=safeZoneX+safeZoneW*0.215; y=safeZoneY+safeZoneH*0.24; w=safeZoneW*0.13; h=safeZoneH*0.03;};
        class FAmmo: TYR_DBG_Text {idc=111; x=safeZoneX+safeZoneW*0.215; y=safeZoneY+safeZoneH*0.275; w=safeZoneW*0.13; h=safeZoneH*0.03;};
        class FFuel: TYR_DBG_Text {idc=112; x=safeZoneX+safeZoneW*0.215; y=safeZoneY+safeZoneH*0.31; w=safeZoneW*0.13; h=safeZoneH*0.03;};
        class FMan: TYR_DBG_Text {idc=113; x=safeZoneX+safeZoneW*0.215; y=safeZoneY+safeZoneH*0.345; w=safeZoneW*0.13; h=safeZoneH*0.03;};

        class ESteel: TYR_DBG_Text {idc=120; x=safeZoneX+safeZoneW*0.515; y=safeZoneY+safeZoneH*0.24; w=safeZoneW*0.13; h=safeZoneH*0.03;};
        class EAmmo: TYR_DBG_Text {idc=121; x=safeZoneX+safeZoneW*0.515; y=safeZoneY+safeZoneH*0.275; w=safeZoneW*0.13; h=safeZoneH*0.03;};
        class EFuel: TYR_DBG_Text {idc=122; x=safeZoneX+safeZoneW*0.515; y=safeZoneY+safeZoneH*0.31; w=safeZoneW*0.13; h=safeZoneH*0.03;};
        class EMan: TYR_DBG_Text {idc=123; x=safeZoneX+safeZoneW*0.515; y=safeZoneY+safeZoneH*0.345; w=safeZoneW*0.13; h=safeZoneH*0.03;};

        class FSteelAdd: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.35; y=safeZoneY+safeZoneH*0.24; w=safeZoneW*0.12; h=safeZoneH*0.03; text="+10K STEEL"; onButtonClick="['resource',[Pside,1,10000]] remoteExecCall ['TYR_fnc_ServerDebugAction',2];";};
        class FAmmoAdd: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.35; y=safeZoneY+safeZoneH*0.275; w=safeZoneW*0.12; h=safeZoneH*0.03; text="+10K AMMO"; onButtonClick="['resource',[Pside,2,10000]] remoteExecCall ['TYR_fnc_ServerDebugAction',2];";};
        class FFuelAdd: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.35; y=safeZoneY+safeZoneH*0.31; w=safeZoneW*0.12; h=safeZoneH*0.03; text="+10K FUEL"; onButtonClick="['resource',[Pside,3,10000]] remoteExecCall ['TYR_fnc_ServerDebugAction',2];";};
        class FManAdd: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.35; y=safeZoneY+safeZoneH*0.345; w=safeZoneW*0.12; h=safeZoneH*0.03; text="+100 MANPOWER"; onButtonClick="['resource',[Pside,4,100]] remoteExecCall ['TYR_fnc_ServerDebugAction',2];";};

        class ESteelAdd: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.65; y=safeZoneY+safeZoneH*0.24; w=safeZoneW*0.12; h=safeZoneH*0.03; text="+10K STEEL"; onButtonClick="['resource',[1-Pside,1,10000]] remoteExecCall ['TYR_fnc_ServerDebugAction',2];";};
        class EAmmoAdd: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.65; y=safeZoneY+safeZoneH*0.275; w=safeZoneW*0.12; h=safeZoneH*0.03; text="+10K AMMO"; onButtonClick="['resource',[1-Pside,2,10000]] remoteExecCall ['TYR_fnc_ServerDebugAction',2];";};
        class EFuelAdd: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.65; y=safeZoneY+safeZoneH*0.31; w=safeZoneW*0.12; h=safeZoneH*0.03; text="+10K FUEL"; onButtonClick="['resource',[1-Pside,3,10000]] remoteExecCall ['TYR_fnc_ServerDebugAction',2];";};
        class EManAdd: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.65; y=safeZoneY+safeZoneH*0.345; w=safeZoneW*0.12; h=safeZoneH*0.03; text="+100 MANPOWER"; onButtonClick="['resource',[1-Pside,4,100]] remoteExecCall ['TYR_fnc_ServerDebugAction',2];";};

        class FBoost: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.215; y=safeZoneY+safeZoneH*0.39; w=safeZoneW*0.125; h=safeZoneH*0.038; text="BOOST ALL"; onButtonClick="['boostResources',[Pside]] remoteExecCall ['TYR_fnc_ServerDebugAction',2];";};
        class FMax: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.345; y=safeZoneY+safeZoneH*0.39; w=safeZoneW*0.125; h=safeZoneH*0.038; text="MAX ALL"; onButtonClick="['maxResources',[Pside]] remoteExecCall ['TYR_fnc_ServerDebugAction',2];";};
        class EBoost: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.515; y=safeZoneY+safeZoneH*0.39; w=safeZoneW*0.125; h=safeZoneH*0.038; text="BOOST ALL"; onButtonClick="['boostResources',[1-Pside]] remoteExecCall ['TYR_fnc_ServerDebugAction',2];";};
        class EMax: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.645; y=safeZoneY+safeZoneH*0.39; w=safeZoneW*0.125; h=safeZoneH*0.038; text="MAX ALL"; onButtonClick="['maxResources',[1-Pside]] remoteExecCall ['TYR_fnc_ServerDebugAction',2];";};

        class ProgressTitle: TYR_DBG_Text {x=safeZoneX+safeZoneW*0.215; y=safeZoneY+safeZoneH*0.455; w=safeZoneW*0.555; h=safeZoneH*0.03; text="PROGRESSION / WORLD"; colorText[]={0.851,0.5647,0.0863,1};};
        class FUnlock: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.215; y=safeZoneY+safeZoneH*0.495; w=safeZoneW*0.125; h=safeZoneH*0.038; text="UNLOCK FRIENDLY"; onButtonClick="['unlockResearch',[Pside]] remoteExecCall ['TYR_fnc_ServerDebugAction',2];";};
        class FReset: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.345; y=safeZoneY+safeZoneH*0.495; w=safeZoneW*0.125; h=safeZoneH*0.038; text="RESET FRIENDLY"; onButtonClick="['resetResearch',[Pside]] remoteExecCall ['TYR_fnc_ServerDebugAction',2];";};
        class EUnlock: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.515; y=safeZoneY+safeZoneH*0.495; w=safeZoneW*0.125; h=safeZoneH*0.038; text="UNLOCK ENEMY"; onButtonClick="['unlockResearch',[1-Pside]] remoteExecCall ['TYR_fnc_ServerDebugAction',2];";};
        class EReset: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.645; y=safeZoneY+safeZoneH*0.495; w=safeZoneW*0.125; h=safeZoneH*0.038; text="RESET ENEMY"; onButtonClick="['resetResearch',[1-Pside]] remoteExecCall ['TYR_fnc_ServerDebugAction',2];";};

        class FillFactories: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.215; y=safeZoneY+safeZoneH*0.545; w=safeZoneW*0.125; h=safeZoneH*0.038; text="FILL FACTORIES"; onButtonClick="['fillFactories',[]] remoteExecCall ['TYR_fnc_ServerDebugAction',2];";};
        class FactoryTick: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.345; y=safeZoneY+safeZoneH*0.545; w=safeZoneW*0.125; h=safeZoneH*0.038; text="FACTORY TICK"; onButtonClick="['factoryTick',[]] remoteExecCall ['TYR_fnc_ServerDebugAction',2];";};
        class RefillVLS: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.515; y=safeZoneY+safeZoneH*0.545; w=safeZoneW*0.125; h=safeZoneH*0.038; text="REFILL VLS"; onButtonClick="['refillVLS',[Pside]] remoteExecCall ['TYR_fnc_ServerDebugAction',2];";};
        class SaveNow: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.645; y=safeZoneY+safeZoneH*0.545; w=safeZoneW*0.125; h=safeZoneH*0.038; text="SAVE NOW"; onButtonClick="['save',[]] remoteExecCall ['TYR_fnc_ServerDebugAction',2];";};

        class PlayerTitle: TYR_DBG_Text {x=safeZoneX+safeZoneW*0.215; y=safeZoneY+safeZoneH*0.61; w=safeZoneW*0.555; h=safeZoneH*0.03; text="PLAYER / TEST"; colorText[]={0.851,0.5647,0.0863,1};};
        class Heal: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.215; y=safeZoneY+safeZoneH*0.65; w=safeZoneW*0.125; h=safeZoneH*0.038; text="HEAL PLAYER"; onButtonClick="player setDamage 0;";};
        class TpHome: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.345; y=safeZoneY+safeZoneH*0.65; w=safeZoneW*0.125; h=safeZoneH*0.038; text="TP FRIENDLY BASE"; onButtonClick="player setPosATL ((GameData # 0 # (Pside + 1) # 0) vectorAdd [5,5,0]);";};
        class TpEnemy: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.515; y=safeZoneY+safeZoneH*0.65; w=safeZoneW*0.125; h=safeZoneH*0.038; text="TP ENEMY BASE"; onButtonClick="player setPosATL ((GameData # 0 # ((1-Pside) + 1) # 0) vectorAdd [5,5,0]);";};
        class RunTests: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.645; y=safeZoneY+safeZoneH*0.65; w=safeZoneW*0.125; h=safeZoneH*0.038; text="RUN AUTOTEST"; onButtonClick="[] remoteExecCall ['TYR_fnc_ServerRunAutomatedTests',2];";};

        class Close: TYR_DBG_Button {x=safeZoneX+safeZoneW*0.345; y=safeZoneY+safeZoneH*0.79; w=safeZoneW*0.31; h=safeZoneH*0.045; text="CLOSE DEBUG MENU"; onButtonClick="closeDialog 0;";};
    };
};
