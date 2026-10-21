class TyrEmplacementMenu
{
	idd = 1203;
	
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
		class Background_copy1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW *  0.2225;
			y = safeZoneY + safeZoneH * 0;
			w = safeZoneW * 0.7975;
			h = safeZoneH * 0.04555556;
			style = 0;
			text = "";
			colorBackground[] = {0.2,0.2,0.2,0.7};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		
	};
	class Controls
	{
		class VehiclesLB
		{
			type = 5;
			idc = 1;
			x = safeZoneX + safeZoneW * 0.01875;
			y = safeZoneY + safeZoneH * 0.07777778;
			w = safeZoneW * 0.1875;
			h = safeZoneH * 0.20222223;
			style = 16;
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {0.851,0.5647,0.0863,1};
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
		class CreateEmplacement
		{
			type = 1;
			idc = 3;
			x = safeZoneX + safeZoneW * 0.04375;
			y = safeZoneY + safeZoneH * 0.81111112;
			w = safeZoneW * 0.1375;
			h = safeZoneH * 0.06111112;
			style = 0+2;
			text = "Create Emplacement";
			borderSize = 0;
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorBackgroundActive[] = {0.851,0.5647,0.0863,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0.851,0.5647,0.0863,0};
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
			onButtonClick = "[lbCurSel 1]execVM 'Emplacements\CreateEmplacement.sqf'";
			
		};
		class Availalbe
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0;
			y = safeZoneY + safeZoneH * 0.04555556;
			w = safeZoneW * 0.2225;
			h = safeZoneH * 0.02222223;
			style = 0;
			text = "Available Emplacements";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class VehiclesLB_copy1
		{
			type = 5;
			idc = 2;
			x = safeZoneX + safeZoneW * 0.01875;
			y = safeZoneY + safeZoneH * 0.34666667;
			w = safeZoneW * 0.1875;
			h = safeZoneH * 0.34888889;
			style = 16;
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {0.851,0.5647,0.0863,1};
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
		class Vehicles_copy1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0;
			y = safeZoneY + safeZoneH * 0.31444445;
			w = safeZoneW * 0.2225;
			h = safeZoneH * 0.02222223;
			style = 0;
			text = "Emplacements";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class MapBackground
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.2225;
			y = safeZoneY + safeZoneH * 0.04555556;
			w = safeZoneW * 0.7775;
			h = safeZoneH * 1;
			style = 0;
			text = "";
			colorBackground[] = {0,0,0,1};
			colorText[] = {0.4118,0.5294,0.4902,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class Map : RscMapControl {
			idc = 1000;
			x = safeZoneX + safeZoneW * 0.2225;
			y = safeZoneY + safeZoneH * 0.04555556;
			w = safeZoneW * 0.7775;
			h = safeZoneH * 1;
		};
		
	};
	
};

