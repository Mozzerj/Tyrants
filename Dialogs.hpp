//Exported via Arma Dialog Creator (https://github.com/kayler-renslow/arma-dialog-creator)

#include "DialogCtrls.h"

class ServerGameModeSelect
{
	idd = 1000;
	
	class ControlsBackground
	{
		class Background
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * -0.00625;
			y = safeZoneY + safeZoneH * -0.02;
			w = safeZoneW * 1.0125;
			h = safeZoneH * 1.03888889;
			style = 0;
			text = "";
			colorBackground[] = {0,0,0,0.7};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class TitleBar
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * -0.00625;
			y = safeZoneY + safeZoneH * -0.01;
			w = safeZoneW * 1.0125;
			h = safeZoneH * 0.06555556;
			style = 0;
			text = "   Tyrants";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2.5);
			
		};
		class PlayerListTitleBar
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.57875;
			y = safeZoneY + safeZoneH * 0.38111112;
			w = safeZoneW * 0.4275;
			h = safeZoneH * 0.06;
			style = 0+2;
			text = "Players";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2);
			
		};
		class EastPlebBar
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.77875;
			y = safeZoneY + safeZoneH * 0.60111112;
			w = safeZoneW * 0.2375;
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
			x = safeZoneX + safeZoneW * 0.56875;
			y = safeZoneY + safeZoneH * 0.60111112;
			w = safeZoneW * 0.2175;
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
			x = safeZoneX + safeZoneW * 0.55875;
			y = safeZoneY + safeZoneH * 0.45111112;
			w = safeZoneW * 0.2375;
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
			x = safeZoneX + safeZoneW * 0.78875;
			y = safeZoneY + safeZoneH * 0.45111112;
			w = safeZoneW * 0.2175;
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
			x = safeZoneX + safeZoneW * 0.59875;
			y = safeZoneY + safeZoneH * 0.52111112;
			w = safeZoneW * 0.1625;
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
			x = safeZoneX + safeZoneW * 0.81875;
			y = safeZoneY + safeZoneH * 0.52111112;
			w = safeZoneW * 0.1625;
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
			x = safeZoneX + safeZoneW * 0.79875;
			y = safeZoneY + safeZoneH * 0.06111112;
			w = safeZoneW * 0.1975;
			h = safeZoneH * 0.3;
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
			x = safeZoneX + safeZoneW * 0.80875;
			y = safeZoneY + safeZoneH * 0.08111112;
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
			x = safeZoneX + safeZoneW * 0.80875;
			y = safeZoneY + safeZoneH * 0.26111112;
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
			x = safeZoneX + safeZoneW * 0.89875;
			y = safeZoneY + safeZoneH * 0.26111112;
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
		class PlayerList
		{
			type = 5;
			idc = 43;
			x = safeZoneX + safeZoneW * 0.59875;
			y = safeZoneY + safeZoneH * 0.66777778;
			w = safeZoneW * 0.1625;
			h = safeZoneH * 0.29555556;
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
		class GameModeListBox
		{
			type = 5;
			idc = 1;
			x = safeZoneX + safeZoneW * 0.01875;
			y = safeZoneY + safeZoneH * 0.08222223;
			w = safeZoneW * 0.5625;
			h = safeZoneH * 0.89333334;
			style = 16;
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {1,0.6636,0.1014,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			rowHeight = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2);
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
			idc = 2;
			x = safeZoneX + safeZoneW * 0.60375;
			y = safeZoneY + safeZoneH * 0.08444445;
			w = safeZoneW * 0.1825;
			h = safeZoneH * 0.07;
			style = 0+2;
			text = "Select Gamemode";
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
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "[lbCurSel ((findDisplay 1000) displayCtrl 1)] execVM 'ServerLoading\ModeSelect.sqf'";
			
		};
		class PlayerList_copy1
		{
			type = 5;
			idc = 44;
			x = safeZoneX + safeZoneW * 0.81875;
			y = safeZoneY + safeZoneH * 0.66777778;
			w = safeZoneW * 0.1625;
			h = safeZoneH * 0.29555556;
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
			x = safeZoneX + safeZoneW * 0.80875;
			y = safeZoneY + safeZoneH * 0.31444445;
			w = safeZoneW * 0.1775;
			h = safeZoneH * 0.02555556;
			style = 0;
			colorBar[] = {0.851,0.5647,0.0863,1};
			colorFrame[] = {0,0,0,1};
			texture = "#(argb,8,8,3)color(1,1,1,1)";
			
		};
		
	};
	
};
class PlayerWaiting
{
	idd = 1001;
	
	class ControlsBackground
	{
		class Background
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * -0.00625;
			y = safeZoneY + safeZoneH * -0.02;
			w = safeZoneW * 1.0125;
			h = safeZoneH * 1.03888889;
			style = 0;
			text = "";
			colorBackground[] = {0,0,0,0.7};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class TitleBar
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * -0.00625;
			y = safeZoneY + safeZoneH * -0.01;
			w = safeZoneW * 1.0125;
			h = safeZoneH * 0.06555556;
			style = 0;
			text = "   Tyrants";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2.5);
			
		};
		class PlayerListTitleBar
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.56875;
			y = safeZoneY + safeZoneH * 0.06111112;
			w = safeZoneW * 0.4375;
			h = safeZoneH * 0.06;
			style = 0+2;
			text = "Players";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2);
			
		};
		class EastPlebBar
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.77875;
			y = safeZoneY + safeZoneH * 0.26111112;
			w = safeZoneW * 0.2375;
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
			x = safeZoneX + safeZoneW * 0.56875;
			y = safeZoneY + safeZoneH * 0.26111112;
			w = safeZoneW * 0.2175;
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
			x = safeZoneX + safeZoneW * 0.56875;
			y = safeZoneY + safeZoneH * 0.13111112;
			w = safeZoneW * 0.2275;
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
			x = safeZoneX + safeZoneW * 0.78875;
			y = safeZoneY + safeZoneH * 0.13111112;
			w = safeZoneW * 0.2175;
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
			x = safeZoneX + safeZoneW * 0.59875;
			y = safeZoneY + safeZoneH * 0.20111112;
			w = safeZoneW * 0.1625;
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
			x = safeZoneX + safeZoneW * 0.81875;
			y = safeZoneY + safeZoneH * 0.20111112;
			w = safeZoneW * 0.1625;
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
			x = safeZoneX + safeZoneW * 0.00875;
			y = safeZoneY + safeZoneH * 0.07111112;
			w = safeZoneW * 0.5475;
			h = safeZoneH * 0.89;
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
			x = safeZoneX + safeZoneW * 0.02875;
			y = safeZoneY + safeZoneH * 0.08111112;
			w = safeZoneW * 0.5075;
			h = safeZoneH * 0.06555556;
			style = 0+2;
			text = "Name";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2.5);
			
		};
		class PFPRank
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.02875;
			y = safeZoneY + safeZoneH * 0.78111112;
			w = safeZoneW * 0.2475;
			h = safeZoneH * 0.07555556;
			style = 0+2;
			text = "Rank";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2.5);
			
		};
		class PFPRankDisplay
		{
			type = 0;
			idc = 32;
			x = safeZoneX + safeZoneW * 0.28875;
			y = safeZoneY + safeZoneH * 0.78111112;
			w = safeZoneW * 0.2475;
			h = safeZoneH * 0.07555556;
			style = 0+2;
			text = "";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2);
			
		};
		
	};
	class Controls
	{
		class PlayerList
		{
			type = 5;
			idc = 43;
			x = safeZoneX + safeZoneW * 0.59875;
			y = safeZoneY + safeZoneH * 0.32777778;
			w = safeZoneW * 0.1625;
			h = safeZoneH * 0.64555556;
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
		class PlayerList_copy1
		{
			type = 5;
			idc = 44;
			x = safeZoneX + safeZoneW * 0.81875;
			y = safeZoneY + safeZoneH * 0.32777778;
			w = safeZoneW * 0.1625;
			h = safeZoneH * 0.64555556;
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
			x = safeZoneX + safeZoneW * 0.02875;
			y = safeZoneY + safeZoneH * 0.87444445;
			w = safeZoneW * 0.5075;
			h = safeZoneH * 0.04555556;
			style = 0;
			colorBar[] = {0.851,0.5647,0.0863,1};
			colorFrame[] = {0,0,0,1};
			texture = "#(argb,8,8,3)color(1,1,1,1)";
			
		};
		
	};
	
};
class SniperShootoutSetup
{
	idd = 1002;
	
	class ControlsBackground
	{
		class Background
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * -0.00625;
			y = safeZoneY + safeZoneH * -0.02;
			w = safeZoneW * 1.0125;
			h = safeZoneH * 1.03888889;
			style = 0;
			text = "";
			colorBackground[] = {0,0,0,0.7};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class TitleBar
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * -0.00625;
			y = safeZoneY + safeZoneH * -0.01;
			w = safeZoneW * 1.0125;
			h = safeZoneH * 0.06555556;
			style = 0;
			text = "Tyrants";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2.5);
			
		};
		class PlayerListTitleBar
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.56875;
			y = safeZoneY + safeZoneH * 0.38111112;
			w = safeZoneW * 0.4375;
			h = safeZoneH * 0.06;
			style = 0+2;
			text = "Players";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2);
			
		};
		class EastPlebBar
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.77875;
			y = safeZoneY + safeZoneH * 0.60111112;
			w = safeZoneW * 0.2375;
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
			x = safeZoneX + safeZoneW * 0.56875;
			y = safeZoneY + safeZoneH * 0.60111112;
			w = safeZoneW * 0.2175;
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
			x = safeZoneX + safeZoneW * 0.56875;
			y = safeZoneY + safeZoneH * 0.45111112;
			w = safeZoneW * 0.2275;
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
			x = safeZoneX + safeZoneW * 0.78875;
			y = safeZoneY + safeZoneH * 0.45111112;
			w = safeZoneW * 0.2175;
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
			x = safeZoneX + safeZoneW * 0.59875;
			y = safeZoneY + safeZoneH * 0.52111112;
			w = safeZoneW * 0.1625;
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
			x = safeZoneX + safeZoneW * 0.81875;
			y = safeZoneY + safeZoneH * 0.52111112;
			w = safeZoneW * 0.1625;
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
			x = safeZoneX + safeZoneW * 0.79875;
			y = safeZoneY + safeZoneH * 0.06111112;
			w = safeZoneW * 0.1975;
			h = safeZoneH * 0.3;
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
			x = safeZoneX + safeZoneW * 0.80875;
			y = safeZoneY + safeZoneH * 0.08111112;
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
			x = safeZoneX + safeZoneW * 0.80875;
			y = safeZoneY + safeZoneH * 0.26111112;
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
			x = safeZoneX + safeZoneW * 0.89875;
			y = safeZoneY + safeZoneH * 0.26111112;
			w = safeZoneW * 0.0875;
			h = safeZoneH * 0.03555556;
			style = 0+2;
			text = "";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class WestCommanderBar_copy1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * -0.0075;
			y = safeZoneY + safeZoneH * 0.12555556;
			w = safeZoneW * 0.2275;
			h = safeZoneH * 0.04555556;
			style = 0+2;
			text = "Shootout Range";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class WestCommanderBar_copy1_copy1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * -0.0175;
			y = safeZoneY + safeZoneH * 0.05555556;
			w = safeZoneW * 0.5875;
			h = safeZoneH * 0.04555556;
			style = 0+2;
			text = "Sniper Shootout Setup";
			colorBackground[] = {0,0,0,1};
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
			x = safeZoneX + safeZoneW * 0.59875;
			y = safeZoneY + safeZoneH * 0.66777778;
			w = safeZoneW * 0.1625;
			h = safeZoneH * 0.29555556;
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
			idc = 2;
			x = safeZoneX + safeZoneW * 0.59375;
			y = safeZoneY + safeZoneH * 0.08444445;
			w = safeZoneW * 0.1825;
			h = safeZoneH * 0.07;
			style = 0+2;
			text = "Start Shootout";
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
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "[(ctrlText ((findDisplay 1002) displayCtrl 1))]execVM'SniperShootout\ShootoutStart.sqf'";
			
		};
		class PlayerList_copy1
		{
			type = 5;
			idc = 44;
			x = safeZoneX + safeZoneW * 0.81875;
			y = safeZoneY + safeZoneH * 0.66777778;
			w = safeZoneW * 0.1625;
			h = safeZoneH * 0.29555556;
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
			x = safeZoneX + safeZoneW * 0.80875;
			y = safeZoneY + safeZoneH * 0.31444445;
			w = safeZoneW * 0.1775;
			h = safeZoneH * 0.02555556;
			style = 0;
			colorBar[] = {0.851,0.5647,0.0863,1};
			colorFrame[] = {0,0,0,1};
			texture = "#(argb,8,8,3)color(1,1,1,1)";
			
		};
		class ShootOutRange
		{
			type = 2;
			idc = 1;
			x = safeZoneX + safeZoneW * 0.01375;
			y = safeZoneY + safeZoneH * 0.18444445;
			w = safeZoneW * 0.1925;
			h = safeZoneH * 0.04;
			style = 0+2;
			text = "750";
			autocomplete = "";
			colorBackground[] = {0.851,0.5647,0.0863,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelection[] = {1,0,0,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		
	};
	
};