class TYR_UI_Text
{
    type = 0;
    idc = -1;
    style = 0;
    font = "PuristaMedium";
    sizeEx = 0.03;
    colorText[] = {0.92,0.94,0.96,1};
    colorBackground[] = {0,0,0,0};
    text = "";
    shadow = 0;
};

class TYR_UI_TextDim: TYR_UI_Text
{
    colorText[] = {0.56,0.61,0.66,1};
    sizeEx = 0.025;
};


class TYR_UI_TextMulti: TYR_UI_Text
{
    style = 16;
    lineSpacing = 1;
};

class TYR_UI_Button
{
    type = 1;
    idc = -1;
    style = 2;
    font = "PuristaMedium";
    sizeEx = 0.029;
    text = "";
    borderSize = 0;
    colorText[] = {0.96,0.97,0.98,1};
    colorDisabled[] = {0.42,0.44,0.47,1};
    colorBackground[] = {0.13,0.15,0.18,1};
    colorBackgroundDisabled[] = {0.08,0.09,0.11,0.8};
    colorBackgroundActive[] = {0.20,0.23,0.27,1};
    colorFocused[] = {0.16,0.18,0.21,1};
    colorShadow[] = {0,0,0,0};
    colorBorder[] = {0,0,0,0};
    offsetX = 0;
    offsetY = 0;
    offsetPressedX = 0.001;
    offsetPressedY = 0.001;
    soundEnter[] = {"",0,1};
    soundPush[] = {"",0,1};
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.08,1};
    soundEscape[] = {"",0,1};
};

class TYR_UI_ButtonAccent: TYR_UI_Button
{
    colorText[] = {0.06,0.06,0.06,1};
    colorBackground[] = {0.851,0.5647,0.0863,1};
    colorBackgroundActive[] = {1,0.68,0.12,1};
    colorFocused[] = {0.851,0.5647,0.0863,1};
};

class TYR_UI_ButtonDanger: TYR_UI_Button
{
    colorBackground[] = {0.48,0.08,0.08,1};
    colorBackgroundActive[] = {0.72,0.10,0.10,1};
    colorFocused[] = {0.56,0.09,0.09,1};
};

class TYR_UI_List
{
    type = 5;
    idc = -1;
    style = 16;
    font = "PuristaMedium";
    sizeEx = 0.029;
    rowHeight = 0.036;
    colorText[] = {0.90,0.92,0.94,1};
    colorDisabled[] = {0.4,0.4,0.4,1};
    colorSelect[] = {0.05,0.05,0.05,1};
    colorSelect2[] = {0.05,0.05,0.05,1};
    colorSelectBackground[] = {0.851,0.5647,0.0863,1};
    colorSelectBackground2[] = {0.851,0.5647,0.0863,1};
    colorBackground[] = {0.055,0.065,0.075,0.96};
    colorScrollbar[] = {1,1,1,0.4};
    period = 1;
    maxHistoryDelay = 0;
    soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.06,1};
    class ListScrollBar
    {
        color[] = {0.85,0.57,0.09,0.75};
        thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
        arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
        border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
    };
};

class TYR_UI_Combo
{
    type = 4;
    idc = -1;
    style = 16;
    font = "PuristaMedium";
    sizeEx = 0.028;
    arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
    arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
    colorBackground[] = {0.055,0.065,0.075,1};
    colorDisabled[] = {0.3,0.32,0.35,1};
    colorSelect[] = {0.05,0.05,0.05,1};
    colorSelectBackground[] = {0.851,0.5647,0.0863,1};
    colorText[] = {0.92,0.94,0.96,1};
    maxHistoryDelay = 0;
    soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.08,1};
    soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.08,1};
    soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.08,1};
    wholeHeight = 0.30;
    class ComboScrollBar
    {
        color[] = {0.85,0.57,0.09,0.75};
        thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
        arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
        border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
    };
};

class TYR_UI_Picture: TYR_UI_Text
{
    style = 48;
    colorText[] = {1,1,1,1};
};

class TYR_UI_Progress
{
    type = 8;
    idc = -1;
    style = 0;
    colorBar[] = {0.851,0.5647,0.0863,1};
    colorFrame[] = {0.13,0.15,0.18,1};
    texture = "#(argb,8,8,3)color(1,1,1,1)";
};

class TYR_UI_EditMulti
{
    type = 2;
    idc = -1;
    style = 16;
    font = "EtelkaMonospacePro";
    sizeEx = 0.027;
    text = "";
    autocomplete = "";
    canModify = 1;
    colorText[] = {0.92,0.94,0.96,1};
    colorDisabled[] = {0.42,0.44,0.47,1};
    colorSelection[] = {0.851,0.5647,0.0863,1};
    colorBackground[] = {0.025,0.03,0.036,1};
    soundSelect[] = {"",0,1};
    shadow = 0;
};
