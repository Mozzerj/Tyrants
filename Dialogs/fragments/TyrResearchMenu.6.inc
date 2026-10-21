			font = "PuristaMedium";
			offsetPressedX = 0.005;
			offsetPressedY = 0.005;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "[3002]execVM'Research\ResearchUpdate.sqf'";
			
		};
		class FixedWing
		{
			type = 1;
			idc = 3004;
			x = safeZoneX + safeZoneW * 0.56375;
			y = safeZoneY + safeZoneH * 0.87444445;
			w = safeZoneW * 0.0825;
			h = safeZoneH * 0.05;
			style = 0+2;
			text = "Fixed Wing";
			borderSize = 0;
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorBackgroundActive[] = {1,0.6627,0.102,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.851,0.5647,0.0863,1};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			offsetPressedX = 0.005;
			offsetPressedY = 0.005;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "[3004]execVM'Research\ResearchUpdate.sqf'";
			
		};
		class AutonomousCapabilities
		{
			type = 1;
			idc = 3005;
			x = safeZoneX + safeZoneW * 0.68375;
			y = safeZoneY + safeZoneH * 0.87444445;
			w = safeZoneW * 0.1225;
			h = safeZoneH * 0.05;
			style = 0+2;
			text = "Autonomous Capabilities";
			borderSize = 0;
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorBackgroundActive[] = {1,0.6627,0.102,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.851,0.5647,0.0863,1};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			offsetPressedX = 0.005;
			offsetPressedY = 0.005;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "[3005]execVM'Research\ResearchUpdate.sqf'";
			
		};
		class ResearchLB
		{
			type = 5;
			idc = 1;
			x = safeZoneX + safeZoneW * 0.82;
			y = safeZoneY + safeZoneH * 0.20777778;
			w = safeZoneW * 0.2025;
			h = safeZoneH * 0.79333334;
			style = 16;
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
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
		class UnlockResearch
		{
			type = 1;
			idc = 5;
			x = safeZoneX + safeZoneW * 0.83875;
			y = safeZoneY + safeZoneH * 0.14555556;
			w = safeZoneW * 0.1425;
			h = safeZoneH * 0.05;
			style = 0+2;
			text = "Research Selected";
			borderSize = 0;
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorBackgroundActive[] = {1,0.6636,0.1014,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.851,0.5647,0.0863,1};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			offsetPressedX = 0.005;
			offsetPressedY = 0.005;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "[5]execVM'Research\ResearchUpdate.sqf'";
			
		};
		
	};
	
};
