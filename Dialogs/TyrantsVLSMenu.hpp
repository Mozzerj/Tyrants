class TyrantsVLSMenu
{
	idd = 1204;
	
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
		class TitleBackground
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0;
			y = safeZoneY + safeZoneH * 0;
			w = safeZoneW * 0.2225;
			h = safeZoneH * 0.06555556;
			style = 0;
			text = "";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
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
			text = "VLS System";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5);
			
		};
		class ButtonBackground
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.2225;
			y = safeZoneY + safeZoneH * 0;
			w = safeZoneW * 0.7825;
			h = safeZoneH *  0.04555556;
			style = 0;
			text = "";
			colorBackground[] = {0.2,0.2,0.2,0.7};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class LaunchBackground
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.01875;
			y = safeZoneY + safeZoneH * 0.66444445;
			w = safeZoneW * 0.1875;
			h = safeZoneH * 0.28111112;
			style = 0;
			text = "";
			colorBackground[] = {0.102,0.102,0.102,1};
			colorText[] = {0.5098,0.3059,0.3765,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class Timer
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.01875;
			y = safeZoneY + safeZoneH * 0.88444445;
			w = safeZoneW * 0.1875;
			h = safeZoneH * 0.06111112;
			style = 0+2;
			text = "Do Not Press Unless Authorised";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.6,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)  * 1.3);
			
		};
		
	};
	class Controls
	{
		class AddTarget
		{
			type = 1;
			idc = 4;
			x = safeZoneX + safeZoneW * 0.11375;
			y = safeZoneY + safeZoneH * 0.49777778;
			w = safeZoneW * 0.0975;
			h = safeZoneH * 0.04;
			style = 0+2;
			text = "Add Target";
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
			onButtonClick = "execVM 'Emplacements\VLS\VLSAddTarget.sqf'";
			
		};
		class Targets
		{
			type = 5;
			idc = 1;
			x = safeZoneX + safeZoneW * 0.01875;
			y = safeZoneY + safeZoneH * 0.07777778;
			w = safeZoneW * 0.1875;
			h = safeZoneH * 0.39777778;
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
		class RemoveTarget
		{
			type = 1;
			idc = 3;
			x = safeZoneX + safeZoneW * 0.01375;
			y = safeZoneY + safeZoneH * 0.49777778;
			w = safeZoneW * 0.0975;
			h = safeZoneH * 0.04;
			style = 0+2;
			text = "RemoveTarget";
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
			onButtonClick = "[lbCurSel 1]execVM 'Emplacements\VLS\VLSRemoveTarget.sqf'";
			
		};
		class LaunchButton
		{
			type = 1;
			idc = 4;
			x = safeZoneX + safeZoneW * 0.03875;
			y = safeZoneY + safeZoneH * 0.69333334;
			w = safeZoneW * 0.1475;
			h = safeZoneH * 0.18666667;
			style = 0+2;
			text = "";
			borderSize = 0;
			colorBackground[] = {0.6,0,0,1};
			colorBackgroundActive[] = {0.6,0,0,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.6,0,0,1};
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
			onButtonClick = "[1]execVM 'Emplacements\VLS\VLSLaunch.sqf'";
			
		};
		class ButtonCover
		{
			type = 1;
			idc = 11;
			x = safeZoneX + safeZoneW * 0.01375;
			y = safeZoneY + safeZoneH * 0.64444445;
			w = safeZoneW * 0.1975;
			h = safeZoneH * 0.30888889;
			style = 0+2;
			text = "Initiate Launch";
			borderSize = 0;
			colorBackground[] = {0.302,0.302,0.302,0.5};
			colorBackgroundActive[] = {0.302,0.302,0.302,0.5};
			colorBackgroundDisabled[] = {0.302,0.302,0.302,0.5};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.302,0.302,0.302,0.5};
			colorShadow[] = {0.302,0.302,0.302,0.5};
			colorText[] = {0,0,0,0};
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
			onButtonClick = "[0]execVM 'Emplacements\VLS\VLSLaunch.sqf'";
			
		};
		class Timer_copy1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.01875;
			y = safeZoneY + safeZoneH * 0.56666667;
			w = safeZoneW * 0.1875;
			h = safeZoneH * 0.06111112;
			style = 0+2;
			text = "10:00";
			colorBackground[] = {0,0,0,1};
			colorText[] = {0.6,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 3);
			
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

