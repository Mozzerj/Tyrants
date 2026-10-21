class TyrAIHireMenu
{
	idd = 1202;
	
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
			onLoad = "";
			
		};
		class BackGroundBar
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0;
			y = safeZoneY + safeZoneH * 0.04444445;
			w = safeZoneW * 0.2225;
			h = safeZoneH * 0.06;
			style = 0;
			text = "";
			colorBackground[] = {0.2,0.2,0.2,0.65};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5);
			
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
		class Background_copy1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.785;
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
		class VehicleSelectedBar
		{
			type = 0;
			idc = 2;
			x = safeZoneX + safeZoneW * 0.07;
			y = safeZoneY + safeZoneH * 0.05555556;
			w = safeZoneW * 0.0825;
			h = safeZoneH * 0.04;
			style = 2;
			text = "";
			colorBackground[] = {0.2,0.2,0.2,0.65};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5);
			
		};
		
	};
	class Controls
	{
		class BuyVehicle
		{
			type = 1;
			idc = 7;
			x = safeZoneX + safeZoneW * 0.79375;
			y = safeZoneY + safeZoneH * 0.93555556;
			w = safeZoneW * 0.1975;
			h = safeZoneH * 0.04;
			style = 0+2;
			text = "Hire";
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
			onButtonClick = "";
			
		};
		class VehiclePictureDisplay
		{
			type = 0;
			idc = 5;
			x = safeZoneX + safeZoneW * 0.7925;
			y = safeZoneY + safeZoneH * 0.01444445;
			w = safeZoneW * 0.20;
			h = safeZoneH * 0.22;
			style = 48;
			text = "";
			colorBackground[] = {0.1804,0.0902,0.1725,1};
			colorText[] = {0.8196,0.9098,0.8275,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class VehiclePropertiesListBox
		{
			type = 5;
			idc = 6;
			x = safeZoneX + safeZoneW * 0.7925;
			y = safeZoneY + safeZoneH * 0.25444445;
			w = safeZoneW * 0.2;
			h = safeZoneH * 0.65555556;
			style = 16;
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorDisabled[] = {0.851,0.5647,0.0863,1};
			colorSelect[] = {1,1,1,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			rowHeight = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1.0};
			class ListScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		class VehicleListBox
		{
			type = 5;
			idc = 4;
			x = safeZoneX + safeZoneW * 0.0125;
			y = safeZoneY + safeZoneH * 0.12222223;
			w = safeZoneW * 0.2;
			h = safeZoneH * 0.85777778;
			style = 16;
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorDisabled[] = {0.851,0.5647,0.0863,1};
			colorSelect[] = {1, 0.6636, 0.1014, 1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			rowHeight = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1.0};
			class ListScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		class ButtonLeft
		{
			type = 1;
			idc = 20;
			x = safeZoneX + safeZoneW * 0.0125;
			y = safeZoneY + safeZoneH * 0.05555556;
			w = safeZoneW * 0.0475;
			h = safeZoneH * 0.04;
			style = 0+2;
			text = "<<";
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
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "TYR_aiHireSelection = TYR_aiHireSelection - 1";
			
		};
		class ButtonRight
		{
			type = 1;
			idc = 3;
			x = safeZoneX + safeZoneW * 0.1625;
			y = safeZoneY + safeZoneH * 0.05555556;
			w = safeZoneW * 0.0475;
			h = safeZoneH * 0.04;
			style = 0+2;
			text = ">>";
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
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "TYR_aiHireSelection = TYR_aiHireSelection + 1";
			
		};
		
	};
	
};

// --- 18/10/2024 feature merge dialogs ---

