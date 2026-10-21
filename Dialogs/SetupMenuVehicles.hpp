class SetupMenuVehicles
{
	idd = 1101;
	
	class ControlsBackground
	{
		class Background_copy1_copy1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * -0.00125;
			y = safeZoneY + safeZoneH * 0.03222223;
			w = safeZoneW * 1.0025;
			h = safeZoneH * 0.04444445;
			style = 0;
			text = "Vehicles";
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
		
	};
	class Controls
	{
		class LoadProgress
		{
			type = 8;
			idc = 1;
			x = safeZoneX + safeZoneW * 0.01875;
			y = safeZoneY + safeZoneH * 0.93333334;
			w = safeZoneW * 0.8925;
			h = safeZoneH * 0.03111112;
			style = 0;
			colorBar[] = {0.851,0.5647,0.0863,1};
			colorFrame[] = {0,0,0,1};
			texture = "#(argb,8,8,3)color(1,1,1,1)";
			
		};
		class ETA
		{
			type = 0;
			idc = 2;
			x = safeZoneX + safeZoneW * 0.92375;
			y = safeZoneY + safeZoneH * 0.93444445;
			w = safeZoneW * 0.0525;
			h = safeZoneH * 0.03111112;
			style = 0+2;
			text = "ETA";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		
	};
	
};




























































































































