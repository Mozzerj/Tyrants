class TyrPlayerMenu
{
	idd = 1200;
	
	class ControlsBackground
	{
		class Background
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0;
			y = safeZoneY + safeZoneH * 0;
			w = safeZoneW * 0.2225;
			h = safeZoneH * 1.01;
			style = 0;
			text = "";
			colorBackground[] = {0.2,0.2,0.2,0.7};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class TitleBar
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0;
			y = safeZoneY + safeZoneH * 0;
			w = safeZoneW * 0.2225;
			h = safeZoneH * 0.04555556;
			style = 0;
			text = "Tyrants";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5);
		};
		class PFPbackground
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.01375;
			y = safeZoneY + safeZoneH * 0.05777778;
			w = safeZoneW * 0.1975;
			h = safeZoneH * 0.22666667;
			style = 0 + 2;
			text = "";
			colorBackground[] = {0.2,0.2,0.2,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2);
		};
		class PFPName
		{
			type = 0;
			idc = 1;
			x = safeZoneX + safeZoneW * 0.02375;
			y = safeZoneY + safeZoneH * 0.07444445;
			w = safeZoneW * 0.1775;
			h = safeZoneH * 0.03555556;
			style = 0 + 2;
			text = "";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class PFPRank
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.02375;
			y = safeZoneY + safeZoneH * 0.18111112;
			w = safeZoneW * 0.0775;
			h = safeZoneH * 0.03555556;
			style = 0 + 2;
			text = "Rank";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5);
		};
		class PFPRankDisplay
		{
			type = 0;
			idc = 2;
			x = safeZoneX + safeZoneW * 0.11375;
			y = safeZoneY + safeZoneH * 0.18111112;
			w = safeZoneW * 0.0875;
			h = safeZoneH * 0.03555556;
			style = 0 + 2;
			text = "";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
	};

	class Controls
	{
		class PFPToNextRank
		{
			type = 8;
			idc = 3;
			x = safeZoneX + safeZoneW * 0.02375;
			y = safeZoneY + safeZoneH * 0.23444445;
			w = safeZoneW * 0.1775;
			h = safeZoneH * 0.02555556;
			style = 0;
			colorBar[] = {0.851,0.5647,0.0863,1};
			colorFrame[] = {0,0,0,1};
			texture = "#(argb,8,8,3)color(1,1,1,1)";
		};
		class CollectResources
		{
			type = 1;
			idc = 4;
			x = safeZoneX + safeZoneW * 0.01375;
			y = safeZoneY + safeZoneH * 0.29777778;
			w = safeZoneW * 0.1975;
			h = safeZoneH * 0.04;
			style = 0 + 2;
			text = "Collect Resources";
			borderSize = 0;
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorBackgroundActive[] = {1,0.6531,0.0918,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.851,0.5647,0.0863,1};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "[] spawn TYR_fnc_GetFactoryResource;";
		};
		class BuyVehicle
		{
			type = 1;
			idc = 5;
			x = safeZoneX + safeZoneW * 0.01367188;
			y = safeZoneY + safeZoneH * 0.34722223;
			w = safeZoneW * 0.19726563;
			h = safeZoneH * 0.03993056;
			style = 0 + 2;
			text = "Buy Vehicle";
			borderSize = 0;
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorBackgroundActive[] = {1,0.6531,0.0918,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.851,0.5647,0.0863,1};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "createDialog 'TyrVehicleBuyMenu';";
		};
		class HireSquads
		{
			type = 1;
			idc = 6;
			x = safeZoneX + safeZoneW * 0.01367188;
			y = safeZoneY + safeZoneH * 0.39666668;
			w = safeZoneW * 0.19726563;
			h = safeZoneH * 0.03993056;
			style = 0 + 2;
			text = "Hire Squads";
			borderSize = 0;
			colorBackground[] = {0.851, 0.5647, 0.0863, 1};
			colorBackgroundActive[] = {1, 0.6531, 0.0918, 1};
			colorBackgroundDisabled[] = {0.2, 0.2, 0.2, 1};
			colorBorder[] = {0, 0, 0, 0};
			colorDisabled[] = {0.2, 0.2, 0.2, 1};
			colorFocused[] = {0.851, 0.5647, 0.0863, 1};
			colorShadow[] = {0, 0, 0, 0};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1.0};
			onButtonClick = "createDialog 'TyrAIHireMenu';";
		};
		class BuyEmplacement
		{
			type = 1;
			idc = 7;
			x = safeZoneX + safeZoneW * 0.01367188;
			y = safeZoneY + safeZoneH * 0.44611113;
			w = safeZoneW * 0.19726563;
			h = safeZoneH * 0.03993056;
			style = 0 + 2;
			text = "Buy Emplacement";
			borderSize = 0;
			colorBackground[] = {0.851, 0.5647, 0.0863, 1};
			colorBackgroundActive[] = {1, 0.6531, 0.0918, 1};
			colorBackgroundDisabled[] = {0.2, 0.2, 0.2, 1};
			colorBorder[] = {0, 0, 0, 0};
			colorDisabled[] = {0.2, 0.2, 0.2, 1};
			colorFocused[] = {0.851, 0.5647, 0.0863, 1};
			colorShadow[] = {0, 0, 0, 0};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1.0};
			onButtonClick = "closeDialog 0; [] execVM 'Emplacements\EmplacementsLoad.sqf';";
		};
		class Research
		{
			type = 1;
			idc = 8;
			x = safeZoneX + safeZoneW * 0.01367188;
			y = safeZoneY + safeZoneH * 0.49555558;
			w = safeZoneW * 0.19726563;
			h = safeZoneH * 0.03993056;
			style = 0 + 2;
			text = "Research";
			borderSize = 0;
			colorBackground[] = {0.851, 0.5647, 0.0863, 1};
			colorBackgroundActive[] = {1, 0.6531, 0.0918, 1};
			colorBackgroundDisabled[] = {0.2, 0.2, 0.2, 1};
			colorBorder[] = {0, 0, 0, 0};
			colorDisabled[] = {0.2, 0.2, 0.2, 1};
			colorFocused[] = {0.851, 0.5647, 0.0863, 1};
			colorShadow[] = {0, 0, 0, 0};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1.0};
			onButtonClick = "closeDialog 0; [] execVM 'Research\ResearchLoad.sqf';";
		};
	};
};





























































































































































































































































