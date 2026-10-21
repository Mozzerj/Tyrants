class SetupMenu
{
	idd = 1100;
	
	class ControlsBackground
	{
		class Background
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * -0.00125;
			y = safeZoneY + safeZoneH * 0.125;
			w = safeZoneW * 1.0025;
			h = safeZoneH * 0.75;
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
			x = safeZoneX + safeZoneW * 0.63875;
			y = safeZoneY + safeZoneH * 0.16111112;
			w = safeZoneW * 0.3475;
			h = safeZoneH * 0.33;
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
			x = safeZoneX + safeZoneW * -0.00125;
			y = safeZoneY + safeZoneH * 0.03222223;
			w = safeZoneW * 1.0025;
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
		class EastPlebBar
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.81875;
			y = safeZoneY + safeZoneH * 0.25111112;
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
			x = safeZoneX + safeZoneW * 0.63875;
			y = safeZoneY + safeZoneH * 0.25111112;
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
			x = safeZoneX + safeZoneW * 0.63875;
			y = safeZoneY + safeZoneH * 0.16111112;
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
			x = safeZoneX + safeZoneW * 0.81875;
			y = safeZoneY + safeZoneH * 0.16111112;
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
			x = safeZoneX + safeZoneW * 0.63875;
			y = safeZoneY + safeZoneH * 0.20111112;
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
			x = safeZoneX + safeZoneW * 0.81875;
			y = safeZoneY + safeZoneH * 0.20111112;
			w = safeZoneW * 0.1675;
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
			x = safeZoneX + safeZoneW * 0.01375;
			y = safeZoneY + safeZoneH * 0.14777778;
			w = safeZoneW * 0.2925;
			h = safeZoneH * 0.03;
			style = 0+2;
			text = "Capture Options";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class CaptureTime
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.01375;
			y = safeZoneY + safeZoneH * 0.18333334;
			w = safeZoneW * 0.1425;
			h = safeZoneH * 0.02555556;
			style = 0+2;
			text = "Capture Time";
			colorBackground[] = {0,0,0,0.65};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class CaptureRange
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.01375;
