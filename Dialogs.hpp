//Exported via Arma Dialog Creator (https://github.com/kayler-renslow/arma-dialog-creator)

#include "CustomControlClasses.h"
class SetupMenu
{
	idd = 1000;
	
	class ControlsBackground
	{
		class Background
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.06875;
			y = safeZoneY + safeZoneH * 0.10222223;
			w = safeZoneW * 0.8125;
			h = safeZoneH * 0.77;
			style = 0;
			text = "";
			colorBackground[] = {0.2,0.2,0.2,0.7};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class Background_copy1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.51875;
			y = safeZoneY + safeZoneH * 0.39111112;
			w = safeZoneW * 0.3475;
			h = safeZoneH * 0.45;
			style = 0;
			text = "";
			colorBackground[] = {0.2,0.2,0.2,0.6};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class Background_copy1_copy1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.06875;
			y = safeZoneY + safeZoneH * 0.10222223;
			w = safeZoneW * 0.8125;
			h = safeZoneH * 0.04444445;
			style = 0;
			text = "Settings";
			colorBackground[] = {0.2,0.2,0.2,0.6};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5);
			
		};
		class TitleBar
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.06875;
			y = safeZoneY + safeZoneH * 0.06333334;
			w = safeZoneW * 0.8125;
			h = safeZoneH * 0.04555556;
			style = 0;
			text = " Tyrants";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2);
			
		};
		class PlayerListTitleBar
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.51875;
			y = safeZoneY + safeZoneH * 0.40111112;
			w = safeZoneW * 0.3475;
			h = safeZoneH * 0.03555556;
			style = 0+2;
			text = "Players";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5);
			
		};
		class EastPlebBar
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.69875;
			y = safeZoneY + safeZoneH * 0.60111112;
			w = safeZoneW * 0.1675;
			h = safeZoneH * 0.04555556;
			style = 0+2;
			text = "East Plebs";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class WestPlebBar
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.51875;
			y = safeZoneY + safeZoneH * 0.60111112;
			w = safeZoneW * 0.1675;
			h = safeZoneH * 0.04555556;
			style = 0+2;
			text = "West Plebs";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class WestCommanderBar
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.51875;
			y = safeZoneY + safeZoneH * 0.45111112;
			w = safeZoneW * 0.1675;
			h = safeZoneH * 0.04555556;
			style = 0+2;
			text = "West Commander";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class EastCommanderBar
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.69875;
			y = safeZoneY + safeZoneH * 0.45111112;
			w = safeZoneW * 0.1675;
			h = safeZoneH * 0.04555556;
			style = 0+2;
			text = "East Commander";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class WestCommanderDisplay
		{
			type = 0;
			idc = 41;
			x = safeZoneX + safeZoneW * 0.51875;
			y = safeZoneY + safeZoneH * 0.52111112;
			w = safeZoneW * 0.1675;
			h = safeZoneH * 0.03555556;
			style = 0+2;
			text = "";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class EastCommanderDisplay
		{
			type = 0;
			idc = 42;
			x = safeZoneX + safeZoneW * 0.69875;
			y = safeZoneY + safeZoneH * 0.52111112;
			w = safeZoneW * 0.1675;
			h = safeZoneH * 0.03555556;
			style = 0+2;
			text = "";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class PFPbackground
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.66375;
			y = safeZoneY + safeZoneH * 0.15777778;
			w = safeZoneW * 0.1975;
			h = safeZoneH * 0.22666667;
			style = 0+2;
			text = "";
			colorBackground[] = {0.2,0.2,0.2,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2);
			
		};
		class PFPName
		{
			type = 0;
			idc = 31;
			x = safeZoneX + safeZoneW * 0.67375;
			y = safeZoneY + safeZoneH * 0.17444445;
			w = safeZoneW * 0.1775;
			h = safeZoneH * 0.03555556;
			style = 0+2;
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
			x = safeZoneX + safeZoneW * 0.67375;
			y = safeZoneY + safeZoneH * 0.28111112;
			w = safeZoneW * 0.0775;
			h = safeZoneH * 0.03555556;
			style = 0+2;
			text = "Rank";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5);
			
		};
		class PFPRankDisplay
		{
			type = 0;
			idc = 32;
			x = safeZoneX + safeZoneW * 0.76375;
			y = safeZoneY + safeZoneH * 0.28111112;
			w = safeZoneW * 0.0875;
			h = safeZoneH * 0.03555556;
			style = 0+2;
			text = "";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class CaptureControls
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.08375;
			y = safeZoneY + safeZoneH * 0.16777778;
			w = safeZoneW * 0.2925;
			h = safeZoneH * 0.03;
			style = 0+2;
			text = "Capture Options";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class _cb1d
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.08375;
			y = safeZoneY + safeZoneH * 0.20333334;
			w = safeZoneW * 0.1425;
			h = safeZoneH * 0.02555556;
			style = 0+2;
			text = "Capture Time";
			colorBackground[] = {0,0,0,0.65};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class _cb1d_copy1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.08375;
			y = safeZoneY + safeZoneH * 0.23333334;
			w = safeZoneW * 0.1425;
			h = safeZoneH * 0.02555556;
			style = 0+2;
			text = "Capture Range";
			colorBackground[] = {0,0,0,0.65};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class _cb1d_copy1_copy1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.08375;
			y = safeZoneY + safeZoneH * 0.31333334;
			w = safeZoneW * 0.1425;
			h = safeZoneH * 0.02555556;
			style = 0+2;
			text = "Starting Steel";
			colorBackground[] = {0,0,0,0.65};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class _cb1d_copy1_copy1_copy1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.08375;
			y = safeZoneY + safeZoneH * 0.34333334;
			w = safeZoneW * 0.1425;
			h = safeZoneH * 0.02555556;
			style = 0+2;
			text = "Starting Ammo";
			colorBackground[] = {0,0,0,0.65};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class _cb1d_copy1_copy1_copy1_copy1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.08375;
			y = safeZoneY + safeZoneH * 0.37333334;
			w = safeZoneW * 0.1425;
			h = safeZoneH * 0.02555556;
			style = 0+2;
			text = "Starting Fuel";
			colorBackground[] = {0,0,0,0.65};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class CaptureControls_copy1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.08375;
			y = safeZoneY + safeZoneH * 0.27777778;
			w = safeZoneW * 0.2925;
			h = safeZoneH * 0.03;
			style = 0+2;
			text = "Starting Resources";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class CaptureControls_copy1_copy1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.08375;
			y = safeZoneY + safeZoneH * 0.41777778;
			w = safeZoneW * 0.2925;
			h = safeZoneH * 0.03;
			style = 0+2;
			text = "Multiplier";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class _cb1d_copy1_copy1_copy2
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.08375;
			y = safeZoneY + safeZoneH * 0.45333334;
			w = safeZoneW * 0.1425;
			h = safeZoneH * 0.02555556;
			style = 0+2;
			text = "Factory Production";
			colorBackground[] = {0,0,0,0.65};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class _cb1d_copy1_copy1_copy2_copy1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.08375;
			y = safeZoneY + safeZoneH * 0.48333334;
			w = safeZoneW * 0.1425;
			h = safeZoneH * 0.02555556;
			style = 0+2;
			text = "Vehicle Costs";
			colorBackground[] = {0,0,0,0.65};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		
	};
	class Controls
	{
		class PlayerList
		{
			type = 5;
			idc = 43;
			x = safeZoneX + safeZoneW * 0.51875;
			y = safeZoneY + safeZoneH * 0.66777778;
			w = safeZoneW * 0.1675;
			h = safeZoneH * 0.17333334;
			style = 16;
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {0,0,0,1};
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
		class StartGamemode
		{
			type = 1;
			idc = 20;
			x = safeZoneX + safeZoneW * 0.51875;
			y = safeZoneY + safeZoneH * 0.15777778;
			w = safeZoneW * 0.1325;
			h = safeZoneH * 0.05;
			style = 0+2;
			text = "Start";
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
			onButtonClick = "[lbCurSel 1,lbCurSel 2,lbCurSel 3,lbCurSel 4,lbCurSel 5,lbCurSel 6,lbCurSel 7]execVM 'Setup\settingsSetup.sqf'";
			
		};
		class PlayerList_copy1
		{
			type = 5;
			idc = 44;
			x = safeZoneX + safeZoneW * 0.69875;
			y = safeZoneY + safeZoneH * 0.66777778;
			w = safeZoneW * 0.1675;
			h = safeZoneH * 0.17333334;
			style = 16;
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {0,0,0,1};
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
		class PFPToNextRank
		{
			type = 8;
			idc = 33;
			x = safeZoneX + safeZoneW * 0.67375;
			y = safeZoneY + safeZoneH * 0.33444445;
			w = safeZoneW * 0.1775;
			h = safeZoneH * 0.02555556;
			style = 0;
			colorBar[] = {0.851,0.5647,0.0863,1};
			colorFrame[] = {0,0,0,1};
			texture = "#(argb,8,8,3)color(1,1,1,1)";
			
		};
		class ResourceSteel
		{
			type = 4;
			idc = 1;
			x = safeZoneX + safeZoneW * 0.23375;
			y = safeZoneY + safeZoneH * 0.20333334;
			w = safeZoneW * 0.1425;
			h = safeZoneH * 0.02555556;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {1,1,1,1};
			colorSelectBackground[] = {1,0.6636,0.1014,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1.0};
			soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1.0};
			soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1.0};
			wholeHeight = 0.3;
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		class ResourceFuel
		{
			type = 4;
			idc = 2;
			x = safeZoneX + safeZoneW * 0.23375;
			y = safeZoneY + safeZoneH * 0.23333334;
			w = safeZoneW * 0.1425;
			h = safeZoneH * 0.02555556;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {1,1,1,1};
			colorSelectBackground[] = {1,0.6636,0.1014,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1.0};
			soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1.0};
			soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1.0};
			wholeHeight = 0.3;
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		class ResourceAmmo
		{
			type = 4;
			idc = 3;
			x = safeZoneX + safeZoneW * 0.23375;
			y = safeZoneY + safeZoneH * 0.31333334;
			w = safeZoneW * 0.1425;
			h = safeZoneH * 0.02555556;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {1,1,1,1};
			colorSelectBackground[] = {1,0.6636,0.1014,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1.0};
			soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1.0};
			soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1.0};
			wholeHeight = 0.3;
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		class FactoryLimit
		{
			type = 4;
			idc = 4;
			x = safeZoneX + safeZoneW * 0.23375;
			y = safeZoneY + safeZoneH * 0.34333334;
			w = safeZoneW * 0.1425;
			h = safeZoneH * 0.02555556;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {1,1,1,1};
			colorSelectBackground[] = {1,0.6636,0.1014,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1.0};
			soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1.0};
			soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1.0};
			wholeHeight = 0.3;
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		class FactoryMulti
		{
			type = 4;
			idc = 5;
			x = safeZoneX + safeZoneW * 0.23375;
			y = safeZoneY + safeZoneH * 0.37333334;
			w = safeZoneW * 0.1425;
			h = safeZoneH * 0.02555556;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {1,1,1,1};
			colorSelectBackground[] = {1,0.6636,0.1014,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1.0};
			soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1.0};
			soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1.0};
			wholeHeight = 0.3;
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		class ResourceAmmo_copy1
		{
			type = 4;
			idc = 6;
			x = safeZoneX + safeZoneW * 0.23375;
			y = safeZoneY + safeZoneH * 0.45333334;
			w = safeZoneW * 0.1425;
			h = safeZoneH * 0.02555556;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorDisabled[] = {0.851,0.5647,0.0863,1};
			colorSelect[] = {1, 0.6636, 0.1014, 1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1.0};
			soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1.0};
			soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1.0};
			wholeHeight = 0.3;
			class ComboScrollBar
			{
				color[] = {0.851,0.5647,0.0863,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		class ResourceAmmo_copy1_copy1
		{
			type = 4;
			idc = 7;
			x = safeZoneX + safeZoneW * 0.23375;
			y = safeZoneY + safeZoneH * 0.48333334;
			w = safeZoneW * 0.1425;
			h = safeZoneH * 0.02555556;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {1,1,1,1};
			colorSelectBackground[] = {1,0.6636,0.1014,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1.0};
			soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1.0};
			soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1.0};
			wholeHeight = 0.3;
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		
	};
	
};
class TyrPlayerMenu
{
	idd = 1001;
	
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
			style = 0+2;
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
			style = 0+2;
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
			style = 0+2;
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
			style = 0+2;
			text = "";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		
	};
	class Controls
	{
		class StartGamemode
		{
			type = 1;
			idc = 4;
			x = safeZoneX + safeZoneW * -1;
			y = safeZoneY + safeZoneH * -1;
			w = safeZoneW * 0.1975;
			h = safeZoneH * 0.04;
			style = 0+2;
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
			onButtonClick = "execVM 'functions\GetFactoryResource.sqf';";
			
		};
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
		class StartGamemode_copy1
		{
			type = 1;
			idc = 5;
			x = safeZoneX + safeZoneW * 0.01367188;
			y = safeZoneY + safeZoneH * 0.34722223;
			w = safeZoneW * 0.19726563;
			h = safeZoneH * 0.03993056;
			style = 0+2;
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
		
	};
	
};
class TyrVehicleBuyMenu
{
	idd = 1002;
	
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
			onLoad = "execVM 'Functions\fn_VehicleBuyMenu.sqf'";
			
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
			onButtonClick = "[lbData[4, lbCurSel 4]] execVM 'Functions\fn_VehicleBuy.sqf'";
			
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
			idc = 2;
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
			onButtonClick = "selection = selection - 1";
			
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
			onButtonClick = "selection = selection + 1";
			
		};
		
	};
	
};

