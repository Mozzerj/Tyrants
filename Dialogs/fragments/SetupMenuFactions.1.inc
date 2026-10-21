class SetupMenuFactions
{
	idd = 1102;
	
	class ControlsBackground
	{
		class Background
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0;
			y = safeZoneY + safeZoneH * 0.12444445;
			w = safeZoneW * 1.0025;
			h = safeZoneH * 0.75;
			style = 0;
			text = "";
			colorBackground[] = {0.2,0.2,0.2,0.7};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class Background_copy1_copy1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * -0.00125;
			y = safeZoneY + safeZoneH * 0.03222223;
			w = safeZoneW * 1.0025;
			h = safeZoneH * 0.04444445;
			style = 0;
			text = "Factions Setup";
			colorBackground[] = {0.2,0.2,0.2,0.6};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5);
			
		};
		class CaptureTime
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.01375;
			y = safeZoneY + safeZoneH * 0.15111112;
			w = safeZoneW * 0.1425;
			h = safeZoneH * 0.03666667;
			style = 0+2;
			text = "Available Factions";
			colorBackground[] = {0,0,0,0.65};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class TitleBar
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * -0.00125;
			y = safeZoneY + safeZoneH * -0.00555555;
			w = safeZoneW * 1.0025;
			h = safeZoneH * 0.04555556;
			style = 0;
			text = "Tyrants";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2);
			
		};
		class CaptureTime_copy1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.01375;
			y = safeZoneY + safeZoneH * 0.54222223;
			w = safeZoneW * 0.1425;
			h = safeZoneH * 0.03666667;
			style = 0+2;
			text = "Selected Factions";
			colorBackground[] = {0,0,0,0.65};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class CaptureTime_copy2
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.65375;
			y = safeZoneY + safeZoneH * 0.15111112;
			w = safeZoneW * 0.285;
			h = safeZoneH * 0.03666667;
			style = 0+2;
			text = "Chosen Vehicles";
			colorBackground[] = {0,0,0,0.65};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class CaptureTime_copy2_copy1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.25375;
			y = safeZoneY + safeZoneH * 0.15111112;
			w = safeZoneW * 0.285;
			h = safeZoneH * 0.03666667;
			style = 0+2;
			text = "Available Vehicles";
			colorBackground[] = {0,0,0,0.65};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		
	};
	class Controls
	{
		class FactionsLB
		{
			type = 5;
			idc = 1;
			x = safeZoneX + safeZoneW * 0.01375;
			y = safeZoneY + safeZoneH * 0.2;
			w = safeZoneW * 0.1425;
			h = safeZoneH * 0.24222223;
			style = 16;
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {0.851,0.5647,0.0863,1};
			colorText[] = {0,0,0,1};
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
		class FactionsLB_copy1
		{
			type = 5;
			idc = 2;
			x = safeZoneX + safeZoneW * 0.01375;
			y = safeZoneY + safeZoneH * 0.59111112;
			w = safeZoneW * 0.1425;
			h = safeZoneH * 0.24222223;
			style = 16;
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {0.851,0.5647,0.0863,1};
			colorText[] = {0,0,0,1};
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
		class AddFactionButton
		{
			type = 1;
			idc = 3;
			x = safeZoneX + safeZoneW * 0.09375;
			y = safeZoneY + safeZoneH * 0.46333334;
			w = safeZoneW * 0.0625;
			h = safeZoneH * 0.05;
			style = 0+2;
			text = "↑";
