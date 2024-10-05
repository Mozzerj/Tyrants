diag_exportConfig ["C:\Users\Ethan\Documents\Arma 3\mpmissions\TyrantMapTest.Altis/config.cpp", configFile];

class RscPicture
    {
        deletable=0;
        fade=0;
        access=0;
        type=0;
        idc=-1;
        style=48;
        colorBackground[]={0,0,0,0};
        colorText[]={1,1,1,1};
        font="TahomaB";
        sizeEx=0;
        lineSpacing=0;
        text="";
        fixedWidth=0;
        shadow=0;
        x=0;
        y=0;
        w=0.2;
        h=0.15000001;
        tooltipColorText[]={1,1,1,1};
        tooltipColorBox[]={1,1,1,1};
        tooltipColorShade[]={0,0,0,0.64999998};
    };
    class RscButton
    {
        deletable=0;
        fade=0;
        access=0;
        type=1;
        text="";
        colorText[]={1,1,1,1};
        colorDisabled[]={1,1,1,0.25};
        colorBackground[]={0,0,0,0.5};
        colorBackgroundDisabled[]={0,0,0,0.5};
        colorBackgroundActive[]={0,0,0,1};
        colorFocused[]={0,0,0,1};
        colorShadow[]={0,0,0,0};
        colorBorder[]={0,0,0,1};
        soundEnter[]=
        {
            "\A3\ui_f\data\sound\RscButton\soundEnter",
            0.090000004,
            1
        };
        soundPush[]=
        {
            "\A3\ui_f\data\sound\RscButton\soundPush",
            0.090000004,
            1
        };
        soundClick[]=
        {
            "\A3\ui_f\data\sound\RscButton\soundClick",
            0.090000004,
            1
        };
        soundEscape[]=
        {
            "\A3\ui_f\data\sound\RscButton\soundEscape",
            0.090000004,
            1
        };
        idc=-1;
        style=2;
        x=0;
        y=0;
        w=0.095588997;
        h=0.039216001;
        shadow=2;
        font="RobotoCondensed";
        sizeEx="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
        url="";
        offsetX=0;
        offsetY=0;
        offsetPressedX=0;
        offsetPressedY=0;
        borderSize=0;
    };
    class RscShortcutButton
    {
        deletable=0;
        fade=0;
        type=16;
        x=0.1;
        y=0.1;
        class HitZone
        {
            left=0;
            top=0;
            right=0;
            bottom=0;
        };
        class ShortcutPos
        {
            left=0;
            top="(			(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - 		(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
            w="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
            h="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
        };
        class TextPos
        {
            left="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
            top="(			(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - 		(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
            right=0.0049999999;
            bottom=0;
        };
        shortcuts[]={};
        textureNoShortcut="#(argb,8,8,3)color(0,0,0,0)";
        color[]={1,1,1,1};
        colorFocused[]={1,1,1,1};
        color2[]={0.94999999,0.94999999,0.94999999,1};
        colorDisabled[]={1,1,1,0.25};
        colorBackground[]=
        {
            "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
            1
        };
        colorBackgroundFocused[]=
        {
            "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
            1
        };
        colorBackground2[]={1,1,1,1};
        soundEnter[]=
        {
            "\A3\ui_f\data\sound\RscButton\soundEnter",
            0.090000004,
            1
        };
        soundPush[]=
        {
            "\A3\ui_f\data\sound\RscButton\soundPush",
            0.090000004,
            1
        };
        soundClick[]=
        {
            "\A3\ui_f\data\sound\RscButton\soundClick",
            0.090000004,
            1
        };
        soundEscape[]=
        {
            "\A3\ui_f\data\sound\RscButton\soundEscape",
            0.090000004,
            1
        };
        class Attributes
        {
            font="RobotoCondensed";
            color="#E5E5E5";
            align="left";
            shadow="true";
        };
        idc=-1;
        style=0;
        default=0;
        shadow=1;
        w=0.183825;
        h="(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20)";
        textSecondary="";
        colorSecondary[]={1,1,1,1};
        colorFocusedSecondary[]={1,1,1,1};
        color2Secondary[]={0.94999999,0.94999999,0.94999999,1};
        colorDisabledSecondary[]={1,1,1,0.25};
        sizeExSecondary="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
        fontSecondary="RobotoCondensed";
        animTextureDefault="\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
        animTextureNormal="\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
        animTextureDisabled="\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
        animTextureOver="\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
        animTextureFocused="\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
        animTexturePressed="\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";
        periodFocus=1.2;
        periodOver=0.80000001;
        period=0.40000001;
        font="RobotoCondensed";
        size="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
        sizeEx="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
        text="";
        url="";
        action="";
        class AttributesImage
        {
            font="RobotoCondensed";
            color="#E5E5E5";
            align="left";
        };
    };
    class RscButtonMenu: RscShortcutButton
    {
        idc=-1;
        type=16;
        style="0x02 + 0xC0";
        default=0;
        shadow=0;
        x=0;
        y=0;
        w=0.095588997;
        h=0.039216001;
        animTextureNormal="#(argb,8,8,3)color(1,1,1,1)";
        animTextureDisabled="#(argb,8,8,3)color(1,1,1,1)";
        animTextureOver="#(argb,8,8,3)color(1,1,1,1)";
        animTextureFocused="#(argb,8,8,3)color(1,1,1,1)";
        animTexturePressed="#(argb,8,8,3)color(1,1,1,1)";
        animTextureDefault="#(argb,8,8,3)color(1,1,1,1)";
        colorBackground[]={0,0,0,0.80000001};
        colorBackgroundFocused[]={1,1,1,1};
        colorBackground2[]={0.75,0.75,0.75,1};
        color[]={1,1,1,1};
        colorFocused[]={0,0,0,1};
        color2[]={0,0,0,1};
        colorText[]={1,1,1,1};
        colorDisabled[]={1,1,1,0.25};
        textSecondary="";
        colorSecondary[]={1,1,1,1};
        colorFocusedSecondary[]={0,0,0,1};
        color2Secondary[]={0,0,0,1};
        colorDisabledSecondary[]={1,1,1,0.25};
        sizeExSecondary="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
        fontSecondary="PuristaLight";
        period=1.2;
        periodFocus=1.2;
        periodOver=1.2;
        size="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
        sizeEx="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
        tooltipColorText[]={1,1,1,1};
        tooltipColorBox[]={1,1,1,1};
        tooltipColorShade[]={0,0,0,0.64999998};
        class TextPos
        {
            left="0.25 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
            top="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 		(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
            right=0.0049999999;
            bottom=0;
        };
        class Attributes
        {
            font="PuristaLight";
            color="#E5E5E5";
            align="left";
            shadow="false";
        };
        class ShortcutPos
        {
            left="5.25 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
            top=0;
            w="1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
            h="1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
        soundEnter[]=
        {
            "\A3\ui_f\data\sound\RscButtonMenu\soundEnter",
            0.090000004,
            1
        };
        soundPush[]=
        {
            "\A3\ui_f\data\sound\RscButtonMenu\soundPush",
            0.090000004,
            1
        };
        soundClick[]=
        {
            "\A3\ui_f\data\sound\RscButtonMenu\soundClick",
            0.090000004,
            1
        };
        soundEscape[]=
        {
            "\A3\ui_f\data\sound\RscButtonMenu\soundEscape",
            0.090000004,
            1
        };
    };
    class RscButtonArsenal: RscButton
    {
        style="0x30 + 0x800";
        colorBackground[]={0,0,0,0.80000001};
        colorDisabled[]={1,1,1,1};
    };
    class RscButtonMenuCancel: RscButtonMenu
    {
        idc=2;
        shortcuts[]=
        {
            "0x00050000 + 1"
        };
        text="$STR_DISP_CANCEL";
    };
    class RscButtonMenuOK: RscButtonMenu
    {
        idc=1;
        shortcuts[]=
        {
            "0x00050000 + 0",
            28,
            57,
            156
        };
        default=1;
        text="$STR_DISP_OK";
        soundPush[]=
        {
            "\A3\ui_f\data\sound\RscButtonMenuOK\soundPush",
            0.090000004,
            1
        };
    };
    class ScrollBar
    {
        color[]={1,1,1,0.60000002};
        colorActive[]={1,1,1,1};
        colorDisabled[]={1,1,1,0.30000001};
        thumb="\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
        arrowEmpty="\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
        arrowFull="\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
        border="\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
        shadow=0;
        scrollSpeed=0.059999999;
        width=0;
        height=0;
        autoScrollEnabled=0;
        autoScrollSpeed=-1;
        autoScrollDelay=5;
        autoScrollRewind=0;
    };
    class RscListBox
    {
        deletable=0;
        fade=0;
        access=0;
        type=5;
        rowHeight=0;
        colorText[]={1,1,1,1};
        colorDisabled[]={1,1,1,0.25};
        colorScrollbar[]={1,0,0,0};
        colorSelect[]={0,0,0,1};
        colorSelect2[]={0,0,0,1};
        colorSelectBackground[]={0.94999999,0.94999999,0.94999999,1};
        colorSelectBackground2[]={1,1,1,0.5};
        colorBackground[]={0,0,0,0.30000001};
        soundSelect[]=
        {
            "\A3\ui_f\data\sound\RscListbox\soundSelect",
            0.090000004,
            1
        };
        autoScrollSpeed=-1;
        autoScrollDelay=5;
        autoScrollRewind=0;
        arrowEmpty="#(argb,8,8,3)color(1,1,1,1)";
        arrowFull="#(argb,8,8,3)color(1,1,1,1)";
        colorPicture[]={1,1,1,1};
        colorPictureSelected[]={1,1,1,1};
        colorPictureDisabled[]={1,1,1,0.25};
        colorPictureRight[]={1,1,1,1};
        colorPictureRightSelected[]={1,1,1,1};
        colorPictureRightDisabled[]={1,1,1,0.25};
        colorTextRight[]={1,1,1,1};
        colorSelectRight[]={0,0,0,1};
        colorSelect2Right[]={0,0,0,1};
        tooltipColorText[]={1,1,1,1};
        tooltipColorBox[]={1,1,1,1};
        tooltipColorShade[]={0,0,0,0.64999998};
        class ListScrollBar: ScrollBar
        {
            color[]={1,1,1,1};
            autoScrollEnabled=1;
        };
        x=0;
        y=0;
        w=0.30000001;
        h=0.30000001;
        style=16;
        font="RobotoCondensed";
        sizeEx="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
        shadow=0;
        colorShadow[]={0,0,0,0.5};
        period=1.2;
        maxHistoryDelay=1;
    };
    class RscCombo
    {
        deletable=0;
        fade=0;
        access=0;
        type=4;
        colorSelect[]={0,0,0,1};
        colorText[]={1,1,1,1};
        colorBackground[]={0,0,0,1};
        colorScrollbar[]={1,0,0,1};
        colorDisabled[]={1,1,1,0.25};
        colorPicture[]={1,1,1,1};
        colorPictureSelected[]={1,1,1,1};
        colorPictureDisabled[]={1,1,1,0.25};
        colorPictureRight[]={1,1,1,1};
        colorPictureRightSelected[]={1,1,1,1};
        colorPictureRightDisabled[]={1,1,1,0.25};
        colorTextRight[]={1,1,1,1};
        colorSelectRight[]={0,0,0,1};
        colorSelect2Right[]={0,0,0,1};
        tooltipColorText[]={1,1,1,1};
        tooltipColorBox[]={1,1,1,1};
        tooltipColorShade[]={0,0,0,0.64999998};
        soundSelect[]=
        {
            "\A3\ui_f\data\sound\RscCombo\soundSelect",
            0.1,
            1
        };
        soundExpand[]=
        {
            "\A3\ui_f\data\sound\RscCombo\soundExpand",
            0.1,
            1
        };
        soundCollapse[]=
        {
            "\A3\ui_f\data\sound\RscCombo\soundCollapse",
            0.1,
            1
        };
        maxHistoryDelay=1;
        class ComboScrollBar: ScrollBar
        {
            color[]={1,1,1,1};
        };
        style="0x10 + 0x200";
        font="RobotoCondensed";
        sizeEx="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
        shadow=0;
        x=0;
        y=0;
        w=0.12;
        h=0.035;
        colorSelectBackground[]={1,1,1,0.69999999};
        arrowEmpty="\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
        arrowFull="\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
        wholeHeight=0.44999999;
        colorActive[]={1,0,0,1};
    };
    class RscStructuredText
    {
        deletable=0;
        fade=0;
        access=0;
        type=13;
        idc=-1;
        style=0;
        colorText[]={1,1,1,1};
        class Attributes
        {
            font="RobotoCondensed";
            color="#ffffff";
            colorLink="#D09B43";
            align="left";
            shadow=1;
        };
        x=0;
        y=0;
        h=0.035;
        w=0.1;
        text="";
        size="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
        shadow=1;
    };
    class RscText
    {
        deletable=0;
        fade=0;
        access=0;
        type=0;
        idc=-1;
        colorBackground[]={0,0,0,0};
        colorText[]={1,1,1,1};
        text="";
        fixedWidth=0;
        x=0;
        y=0;
        h=0.037;
        w=0.30000001;
        style=0;
        shadow=1;
        colorShadow[]={0,0,0,0.5};
        font="RobotoCondensed";
        SizeEx="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
        linespacing=1;
        tooltipColorText[]={1,1,1,1};
        tooltipColorBox[]={1,1,1,1};
        tooltipColorShade[]={0,0,0,0.64999998};
    };
    class RscBackgroundGUITop: RscText
    {
        colorBackground[]={0,0,0,1};
        align="top";
        moving=1;
        background=1;
    };
    class RscBackgroundGUI: RscText
    {
        colorBackground[]={0,0,0,0.5};
        colorText[]={1,1,1,1};
        background=1;
    };
    class RscControlsGroup
    {
        deletable=0;
        fade=0;
        class VScrollbar: ScrollBar
        {
            color[]={1,1,1,1};
            width=0.021;
            autoScrollEnabled=1;
        };
        class HScrollbar: ScrollBar
        {
            color[]={1,1,1,1};
            height=0.028000001;
        };
        class Controls
        {
        };
        type=15;
        idc=-1;
        x=0;
        y=0;
        w=1;
        h=1;
        shadow=0;
        style=16;
    };
    class RscControlsGroupNoScrollbars: RscControlsGroup
    {
        class VScrollbar: VScrollbar
        {
            width=0;
        };
        class HScrollbar: HScrollbar
        {
            height=0;
        };
    };
    class RscMessageBox: RscControlsGroupNoScrollbars
    {
        idc=2351;
        x=-1;
        y=-1;
        w=0;
        h=0;
        class Controls
        {
            class BcgCommonTop: RscBackgroundGUITop
            {
                idc=235100;
                x=0;
                y=0;
                w="18.8 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]=
                {
                    "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
                    "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
                    "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
                    1
                };
            };
            class BcgCommon: RscBackgroundGUI
            {
                idc=235101;
                x=0;
                y="1.1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="18.8 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.7 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,1};
            };
            class Text: RscStructuredText
            {
                idc=235102;
                x="0.7 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="1.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="17 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            };
            class BackgroundButtonOK: RscBackgroundGUI
            {
                idc=235103;
                x=0;
                y="2.9 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="6.2 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,1};
            };
            class BackgroundButtonMiddle: BackgroundButtonOK
            {
                idc=235104;
                x="6.3 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
            };
            class BackgroundButtonCancel: BackgroundButtonOK
            {
                idc=235105;
                x="12.6 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
            };
            class ButtonOK: RscButtonMenuOK
            {
                default=1;
                idc=235106;
                colorBackground[]={0,0,0,1};
                x=0;
                y="2.9 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="6.2 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            };
            class ButtonCancel: RscButtonMenuCancel
            {
                idc=235107;
                colorBackground[]={0,0,0,1};
                x="12.6 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="2.9 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="6.2 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            };
        };
    };
    class RscTitle: RscText
    {
        x=0.15000001;
        y=0.059999999;
        w=0.69999999;
        shadow=0;
        style=0;
        sizeEx="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
        colorText[]={0.94999999,0.94999999,0.94999999,1};
        font="PuristaMedium";
    };
    class RscFrame
    {
        type=0;
        idc=-1;
        deletable=0;
        style=64;
        shadow=2;
        colorBackground[]={0,0,0,0};
        colorText[]={1,1,1,1};
        font="RobotoCondensed";
        sizeEx=0.02;
        text="";
        x=0;
        y=0;
        w=0.30000001;
        h=0.30000001;
    };
    class RscListNBox
    {
        deletable=0;
        fade=0;
        access=0;
        type=102;
        rowHeight=0;
        colorText[]={1,1,1,1};
        colorScrollbar[]={0.94999999,0.94999999,0.94999999,1};
        colorSelect[]={0,0,0,1};
        colorSelect2[]={0,0,0,1};
        colorSelectBackground[]={0.94999999,0.94999999,0.94999999,1};
        colorSelectBackground2[]={1,1,1,0.5};
        colorBackground[]={0,0,0,1};
        maxHistoryDelay=1;
        soundSelect[]=
        {
            "",
            0.1,
            1
        };
        autoScrollSpeed=-1;
        autoScrollDelay=5;
        autoScrollRewind=0;
        arrowEmpty="#(argb,8,8,3)color(1,1,1,1)";
        arrowFull="#(argb,8,8,3)color(1,1,1,1)";
        drawSideArrows=0;
        columns[]={0.30000001,0.60000002,0.69999999};
        idcLeft=-1;
        idcRight=-1;
        class ListScrollBar: ScrollBar
        {
        };
        style=16;
        shadow=0;
        font="RobotoCondensed";
        sizeEx="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
        color[]={0.94999999,0.94999999,0.94999999,1};
        colorDisabled[]={1,1,1,0.25};
        colorPicture[]={1,1,1,1};
        colorPictureSelected[]={1,1,1,1};
        colorPictureDisabled[]={1,1,1,1};
        period=1.2;
        x=0;
        y=0;
        w=0.30000001;
        h=0.30000001;
        class ScrollBar: ScrollBar
        {
        };
    };
    class RscEdit
    {
        deletable=0;
        fade=0;
        access=0;
        type=2;
        x=0;
        y=0;
        h=0.039999999;
        w=0.2;
        colorBackground[]={0,0,0,0};
        colorText[]={0.94999999,0.94999999,0.94999999,1};
        colorDisabled[]={1,1,1,0.25};
        colorSelection[]=
        {
            "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
            1
        };
        autocomplete="";
        text="";
        size=0.2;
        style="0x00 + 0x40";
        font="RobotoCondensed";
        shadow=2;
        sizeEx="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
        canModify=1;
        tooltipColorText[]={1,1,1,1};
        tooltipColorBox[]={1,1,1,1};
        tooltipColorShade[]={0,0,0,0.64999998};
    };
    class RscProgress
    {
        deletable=0;
        fade=0;
        access=0;
        type=8;
        style=0;
        colorFrame[]={0,0,0,0};
        colorBar[]=
        {
            "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"
        };
        x=0.34400001;
        y=0.61900002;
        w=0.3137255;
        h=0.0261438;
        shadow=2;
        texture="#(argb,8,8,3)color(1,1,1,1)";
    };
    class RscActiveText
    {
        deletable=0;
        fade=0;
        access=0;
        type=11;
        style=2;
        color[]={0,0,0,1};
        colorActive[]={0.30000001,0.40000001,0,1};
        colorDisabled[]={1,1,1,0.25};
        soundEnter[]=
        {
            "",
            0.1,
            1
        };
        soundPush[]=
        {
            "",
            0.1,
            1
        };
        soundClick[]=
        {
            "",
            0.1,
            1
        };
        soundEscape[]=
        {
            "",
            0.1,
            1
        };
        text="";
        default=0;
        idc=-1;
        x=0;
        y=0;
        h=0.035;
        w=0.035;
        font="RobotoCondensed";
        shadow=2;
        sizeEx="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
        url="";
        tooltipColorText[]={1,1,1,1};
        tooltipColorBox[]={1,1,1,1};
        tooltipColorShade[]={0,0,0,0.64999998};
    };
    class RscActivePicture: RscActiveText
    {
        style=48;
        color[]={1,1,1,0.5};
        colorActive[]={1,1,1,1};
    }
    class RscTyrDisplayArsenal
    {
        idd= 1200;
        enableSimulation=1;
        scriptName="RscDisplayArsenal";
        scriptPath="GUI";
        onLoad="[""onLoad"",_this,""RscDisplayArsenal"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";
        onUnload="[""onUnload"",_this,""RscDisplayArsenal"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";
        icon="\A3\Ui_f\data\Logos\a_64_ca.paa";
        logo="\A3\Ui_f\data\Logos\arsenal_1024_ca.paa";
        class ControlsBackground
        {
            class BlackLeft: RscText
            {
                colorBackground[]={0,0,0,1};
                x="safezoneXAbs";
                y="safezoneY";
                w="safezoneXAbs - safezoneX";
                h="safezoneH";
            };
            class BlackRight: BlackLeft
            {
                x="safezoneX + safezoneW";
            };
            class MouseArea: RscText
            {
                idc=899;
                style=16;
                x="safezoneX";
                y="safezoneY";
                w="safezoneW";
                h="safezoneH";
            };
        };
        class Controls
        {
            class ArrowLeft: RscButton
            {
                idc=992;
                text="-";
                x=-1;
                y=-1;
                w="1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            };
            class ArrowRight: ArrowLeft
            {
                idc=993;
                text="+";
                x=-1;
                y=-1;
                w="1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            };
            class BackgroundLeft: RscText
            {
                fade=1;
                idc=994;
                x="safezoneX + (1 + 1.5 * 	1) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0.5};
            };
            class BackgroundRight: BackgroundLeft
            {
                idc=995;
                x="safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
            };
            class LineIcon: RscFrame
            {
                fade=1;
                idc=1803;
                x=-1;
                y=-1;
                w=0;
                h=0;
                colorText[]={0,0,0,1};
            };
            class LineTabLeft: RscText
            {
                fade=1;
                idc=1804;
                x=-1;
                y=-1;
                w="0.6 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,1};
            };
            class LineTabLeftSelected: RscText
            {
                idc=1805;
                x="safezoneX";
                y=-1;
                w="0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0.80000001};
            };
            class LineTabRight: LineTabLeft
            {
                idc=1806;
            };
            class Tabs: RscFrame
            {
                fade=1;
                idc=1800;
                x="safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="1.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="40 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0};
            };
            class FrameLeft: RscFrame
            {
                fade=1;
                idc=1801;
                x="safezoneX + (1 + 1.5 * 	1) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,1};
            };
            class FrameRight: FrameLeft
            {
                fade=1;
                idc=1802;
                x="safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
            };
            class Load: RscProgress
            {
                fade=1;
                idc=990;
                style=0;
                texture="#(argb,8,8,3)color(1,1,1,1)";
                colorBar[]={1,1,1,1};
                colorFrame[]={0,0,0,1};
                x="safezoneX";
                y="safezoneY + safezoneH - 0.0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="safezoneW";
                h="1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            };
            class LoadCargo: Load
            {
                fade=1;
                idc=991;
                x="safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + safezoneH - 11.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            };
            class Message: RscText
            {
                fade=1;
                idc=996;
                x="safezoneX + (0.5 * safezoneW) - (0.5 * ((safezoneW - 36 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) max 0.4))";
                y="21.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 			(safezoneY + safezoneH - 			(			((safezoneW / safezoneH) min 1.2) / 1.2))";
                w="((safezoneW - 36 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) max 0.4)";
                h="1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0.69999999};
                style=2;
                shadow=0;
                text="";
                sizeEx="0.8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            };
            class Space: RscControlsGroup
            {
                x="safezoneX + safezoneW * 0.5 - 4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY";
                show=0;
                idc=27903;
                w="8.1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class controls
                {
                    class SpaceArsenalBackground: RscText
                    {
                        idc=26603;
                        x="0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        colorBackground[]={0,0,0,0.69999999};
                    };
                    class SpaceArsenal: RscActivePicture
                    {
                        idc=26803;
                        text="\a3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\spaceArsenal_ca.paa";
                        x="1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        tooltip="$STR_A3_Arsenal";
                    };
                    class SpaceGarageBackground: SpaceArsenalBackground
                    {
                        idc=26604;
                        x="4.1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        colorBackground[]={0,0,0,0.69999999};
                    };
                    class SpaceGarage: SpaceArsenal
                    {
                        idc=26804;
                        text="\a3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\spaceGarage_ca.paa";
                        x="5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="1.99996 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        tooltip="$STR_A3_Garage";
                    };
                };
            };
            class ControlBar: RscControlsGroupNoScrollbars
            {
                w="safezoneW";
                idc=44046;
                x="0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40) + 			(safezoneX)";
                y="23.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 			(safezoneY + safezoneH - 			(			((safezoneW / safezoneH) min 1.2) / 1.2))";
                h="1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class controls
                {
                    class ButtonClose: RscButtonMenu
                    {
                        idc=44448;
                        text="$STR_DISP_CLOSE";
                        x="0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="((safezoneW - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) * 0.2) - 0.1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        shortcuts[]=
                        {
                            "0x00050000 + 1"
                        };
                        tooltip="$STR_A3_RscDisplayArsenal_ButtonClose_tooltip";
                    };
                    class ButtonInterface: ButtonClose
                    {
                        idc=44151;
                        text="$STR_CA_HIDE";
                        x="2 * 	((safezoneW - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
                        w="((safezoneW - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        tooltip="$STR_A3_RscDisplayArsenal_ButtonInterface_tooltip";
                    };
                    class ButtonRandom: ButtonInterface
                    {
                        idc=44150;
                        text="$STR_A3_RscDisplayArsenal_ButtonRandom";
                        x="3 * 	((safezoneW - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
                        tooltip="$STR_A3_RscDisplayArsenal_ButtonRandom_tooltip";
                    };
                    class ButtonSave: ButtonInterface
                    {
                        idc=44146;
                        text="$STR_DISP_INT_SAVE";
                        x="4 * 	((safezoneW - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
                        tooltip="$STR_A3_RscDisplayArsenal_ButtonSave_tooltip";
                    };
                    class ButtonLoad: ButtonInterface
                    {
                        idc=44147;
                        text="$STR_DISP_INT_LOAD";
                        x="5 * 	((safezoneW - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
                        tooltip="$STR_A3_RscDisplayArsenal_ButtonLoad_tooltip";
                    };
                    class ButtonExport: ButtonInterface
                    {
                        idc=44148;
                        text="$STR_A3_RscDisplayArsenal_ButtonExport";
                        x="6 * 	((safezoneW - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
                        tooltip="$STR_A3_RscDisplayArsenal_ButtonExport_tooltip";
                    };
                    class ButtonImport: ButtonInterface
                    {
                        idc=44149;
                        text="$STR_A3_RscDisplayArsenal_ButtonImport";
                        x="7 * 	((safezoneW - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
                        tooltip="$STR_A3_RscDisplayArsenal_ButtonImport_tooltip";
                    };
                    class ButtonOK: ButtonClose
                    {
                        idc=44346;
                        text="$STR_A3_RscDisplayArsenal_ButtonOK";
                        x="8 * 	((safezoneW - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
                        tooltip="$STR_A3_RscDisplayArsenal_ButtonOK_tooltip";
                        shortcuts[]=
                        {
                            "0x00050000 + 0",
                            28,
                            57,
                            156
                        };
                    };
                };
            };
            class Info: RscControlsGroup
            {
                x="safezoneX + safezoneW - 20.1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + safezoneH - 4.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                fade=1;
                idc=25815;
                w="17.6 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class controls
                {
                    class InfoBackground: RscText
                    {
                        idc=24515;
                        x="2.6 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        colorBackground[]={0,0,0,1};
                    };
                    class InfoName: RscText
                    {
                        idc=24516;
                        x="2.6 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        sizeEx="1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    };
                    class InfoAuthor: RscText
                    {
                        idc=24517;
                        x="2.6 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        colorText[]={1,1,1,0.5};
                        sizeEx="0.8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    };
                    class DLCBackground: RscText
                    {
                        fade=1;
                        idc=24518;
                        x="0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        colorBackground[]={0,0,0,0.5};
                    };
                    class DLCIcon: RscActivePicture
                    {
                        enabled=0;
                        fade=1;
                        color[]={1,1,1,1};
                        colorActive[]={1,1,1,1};
                        idc=24715;
                        text="#(argb,8,8,3)color(1,1,1,1)";
                        x="0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    };
                };
            };
            class Stats: RscControlsGroupNoScrollbars
            {
                x="safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + safezoneH - 10.6 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                fade=1;
                enable=0;
                idc=28644;
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="6 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class controls
                {
                    class StatsBackground: RscText
                    {
                        idc=27347;
                        x="0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="6 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        colorBackground[]={0,0,0,0.5};
                    };
                    class Stat1: RscProgress
                    {
                        colorBar[]={1,1,1,1};
                        colorFrame[]={0,0,0,0};
                        idc=27348;
                        x="0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="14 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="0.9 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    };
                    class Stat2: Stat1
                    {
                        idc=27349;
                        x="0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="14 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="0.9 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    };
                    class Stat3: Stat1
                    {
                        idc=27350;
                        x="0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="14 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="0.9 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    };
                    class Stat4: Stat1
                    {
                        idc=27351;
                        x="0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="3.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="14 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="0.9 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    };
                    class Stat5: Stat1
                    {
                        idc=27352;
                        x="0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="4.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="14 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="0.9 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    };
                    class StatText1: RscText
                    {
                        shadow=0;
                        colorShadow[]={1,1,1,1};
                        idc=27353;
                        x="0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="14 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="0.9 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        colorText[]={0,0,0,1};
                        colorBackground[]={1,1,1,0.1};
                        sizeEx="0.8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    };
                    class StatText2: StatText1
                    {
                        idc=27354;
                        x="0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="14 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="0.9 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        colorText[]={0,0,0,1};
                        colorBackground[]={1,1,1,0.1};
                        sizeEx="0.8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    };
                    class StatText3: StatText1
                    {
                        idc=27355;
                        x="0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="14 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="0.9 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        colorText[]={0,0,0,1};
                        colorBackground[]={1,1,1,0.1};
                        sizeEx="0.8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    };
                    class StatText4: StatText1
                    {
                        idc=27356;
                        x="0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="3.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="14 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="0.9 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        colorText[]={0,0,0,1};
                        colorBackground[]={1,1,1,0.1};
                        sizeEx="0.8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    };
                    class StatText5: StatText1
                    {
                        idc=27357;
                        x="0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="4.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="14 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="0.9 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        colorText[]={0,0,0,1};
                        colorBackground[]={1,1,1,0.1};
                        sizeEx="0.8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    };
                };
            };
            class MouseBlock: RscText
            {
                idc=898;
                style=16;
                x="safezoneX";
                y="safezoneY";
                w="safezoneW";
                h="safezoneH";
            };
            class Template: RscControlsGroup
            {
                fade=1;
                idc=35919;
                x="10 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
                y="0.9 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
                w="20 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="22.2 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class controls
                {
                    class Title: RscTitle
                    {
                        style=0;
                        colorBackground[]=
                        {
                            "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
                            "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
                            "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
                            "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"
                        };
                        idc=34619;
                        text="";
                        x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="0 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="20 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    };
                    class MainBackground: RscText
                    {
                        idc=34622;
                        x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="1.1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="20 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="20 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        colorBackground[]={0,0,0,0.80000001};
                    };
                    class Column1: RscText
                    {
                        idc=34620;
                        x="0.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="1.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="19 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="17.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        colorBackground[]={1,1,1,0.2};
                    };
                    class Column2: RscText
                    {
                        idc=34623;
                        x="9.05 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="1.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="1.9 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="17.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        colorBackground[]={1,1,1,0.1};
                    };
                    class Column3: RscText
                    {
                        idc=34624;
                        x="12.85 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="1.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="1.9 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="17.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        colorBackground[]={1,1,1,0.1};
                    };
                    class Column4: RscText
                    {
                        idc=34625;
                        x="15.7 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="1.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="0.95 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="17.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        colorBackground[]={1,1,1,0.1};
                    };
                    class Column5: RscText
                    {
                        idc=34626;
                        x="17.6 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="1.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="0.95 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="17.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        colorBackground[]={1,1,1,0.1};
                    };
                    class TextName: RscText
                    {
                        style=1;
                        idc=34621;
                        text="$STR_DISP_GAME_NAME";
                        x="0.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="19.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="5.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        colorBackground[]={0,0,0,0.2};
                        sizeEx="0.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    };
                    class EditName: RscEdit
                    {
                        idc=35020;
                        x="6 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="19.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="13.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        sizeEx="0.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    };
                    class ValueName: RscListNBox
                    {
                        columns[]={0,0.44999999,0.55000001,0.64999998,0.75,0.80000001,0.85000002,0.89999998,0.94999999};
                        idc=35119;
                        x="0.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="1.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="19 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="17.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        sizeEx="0.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    };
                    class ButtonOK: RscButtonMenu
                    {
                        idc=36019;
                        text="$STR_DISP_OK";
                        x="15 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="21.2 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    };
                    class ButtonCancel: RscButtonMenu
                    {
                        idc=36020;
                        text="$STR_DISP_CANCEL";
                        x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="21.2 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    };
                    class ButtonDelete: RscButtonMenu
                    {
                        idc=36021;
                        text="$STR_DISP_DELETE";
                        x="9.9 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        y="21.2 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                        w="5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
                        h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    };
                };
            };
            class MessageBox: RscMessageBox
            {
            };
            class TabPrimaryWeapon: RscButtonArsenal
            {
                idc="930 + 						0";
                idcx=930;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\PrimaryWeapon_ca.paa";
                x="safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 0 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_PrimaryWeapon";
            };
            class IconBackgroundPrimaryWeapon: RscPicture
            {
                idc="830 + 						0";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconPrimaryWeapon: TabPrimaryWeapon
            {
                idc="900 + 						0";
                idcx=900;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class SortPrimaryWeapon: RscCombo
            {
                idc="800 + 					0";
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class Items
                {
                    class Alphabet
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_alphabet";
                        default=1;
                    };
                    class Mod
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_mod";
                    };
                };
            };
            class ListPrimaryWeapon: RscListBox
            {
                idc="960 + 					0";
                idcx=960;
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0};
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorPictureSelected[]={1,1,1,1};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
                colorPictureRightSelected[]={1,1,1,1};
            };
            class TabSecondaryWeapon: RscButtonArsenal
            {
                idc="930 + 				1";
                idcx=931;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\SecondaryWeapon_ca.paa";
                x="safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 1.5 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_SecondaryWeapon";
            };
            class IconBackgroundSecondaryWeapon: RscPicture
            {
                idc="830 + 				1";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconSecondaryWeapon: TabSecondaryWeapon
            {
                idc="900 + 				1";
                idcx=901;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class SortSecondaryWeapon: RscCombo
            {
                idc="800 + 			1";
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class Items
                {
                    class Alphabet
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_alphabet";
                        default=1;
                    };
                    class Mod
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_mod";
                    };
                };
            };
            class ListSecondaryWeapon: RscListBox
            {
                idc="960 + 			1";
                idcx=961;
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0};
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorPictureSelected[]={1,1,1,1};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
                colorPictureRightSelected[]={1,1,1,1};
            };
            class TabHandgun: RscButtonArsenal
            {
                idc="930 + 						2";
                idcx=932;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Handgun_ca.paa";
                x="safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 3 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_Handgun";
            };
            class IconBackgroundHandgun: RscPicture
            {
                idc="830 + 						2";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconHandgun: TabHandgun
            {
                idc="900 + 						2";
                idcx=902;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class SortHandgun: RscCombo
            {
                idc="800 + 					2";
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class Items
                {
                    class Alphabet
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_alphabet";
                        default=1;
                    };
                    class Mod
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_mod";
                    };
                };
            };
            class ListHandgun: RscListBox
            {
                idc="960 + 					2";
                idcx=962;
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0};
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorPictureSelected[]={1,1,1,1};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
                colorPictureRightSelected[]={1,1,1,1};
            };
            class TabUniform: RscButtonArsenal
            {
                idc="930 + 						3";
                idcx=933;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Uniform_ca.paa";
                x="safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 4.5 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_Uniform";
            };
            class IconBackgroundUniform: RscPicture
            {
                idc="830 + 						3";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconUniform: TabUniform
            {
                idc="900 + 						3";
                idcx=903;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class SortUniform: RscCombo
            {
                idc="800 + 					3";
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class Items
                {
                    class Alphabet
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_alphabet";
                        default=1;
                    };
                    class Mod
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_mod";
                    };
                };
            };
            class ListUniform: RscListBox
            {
                idc="960 + 					3";
                idcx=963;
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0};
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorPictureSelected[]={1,1,1,1};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
                colorPictureRightSelected[]={1,1,1,1};
            };
            class TabVest: RscButtonArsenal
            {
                idc="930 + 								4";
                idcx=934;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Vest_ca.paa";
                x="safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 6 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_Vest";
            };
            class IconBackgroundVest: RscPicture
            {
                idc="830 + 								4";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconVest: TabVest
            {
                idc="900 + 								4";
                idcx=904;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class SortVest: RscCombo
            {
                idc="800 + 							4";
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class Items
                {
                    class Alphabet
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_alphabet";
                        default=1;
                    };
                    class Mod
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_mod";
                    };
                };
            };
            class ListVest: RscListBox
            {
                idc="960 + 							4";
                idcx=964;
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0};
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorPictureSelected[]={1,1,1,1};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
                colorPictureRightSelected[]={1,1,1,1};
            };
            class TabBackpack: RscButtonArsenal
            {
                idc="930 + 						5";
                idcx=935;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Backpack_ca.paa";
                x="safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 7.5 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_Backpack";
            };
            class IconBackgroundBackpack: RscPicture
            {
                idc="830 + 						5";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconBackpack: TabBackpack
            {
                idc="900 + 						5";
                idcx=905;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class SortBackpack: RscCombo
            {
                idc="800 + 					5";
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class Items
                {
                    class Alphabet
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_alphabet";
                        default=1;
                    };
                    class Mod
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_mod";
                    };
                };
            };
            class ListBackpack: RscListBox
            {
                idc="960 + 					5";
                idcx=965;
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0};
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorPictureSelected[]={1,1,1,1};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
                colorPictureRightSelected[]={1,1,1,1};
            };
            class TabHeadgear: RscButtonArsenal
            {
                idc="930 + 						6";
                idcx=936;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Headgear_ca.paa";
                x="safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 9 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_Headgear";
            };
            class IconBackgroundHeadgear: RscPicture
            {
                idc="830 + 						6";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconHeadgear: TabHeadgear
            {
                idc="900 + 						6";
                idcx=906;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class SortHeadgear: RscCombo
            {
                idc="800 + 					6";
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class Items
                {
                    class Alphabet
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_alphabet";
                        default=1;
                    };
                    class Mod
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_mod";
                    };
                };
            };
            class ListHeadgear: RscListBox
            {
                idc="960 + 					6";
                idcx=966;
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0};
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorPictureSelected[]={1,1,1,1};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
                colorPictureRightSelected[]={1,1,1,1};
            };
            class TabGoggles: RscButtonArsenal
            {
                idc="930 + 						7";
                idcx=937;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Goggles_ca.paa";
                x="safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 10.5 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_Goggles";
            };
            class IconBackgroundGoggles: RscPicture
            {
                idc="830 + 						7";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconGoggles: TabGoggles
            {
                idc="900 + 						7";
                idcx=907;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class SortGoggles: RscCombo
            {
                idc="800 + 					7";
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class Items
                {
                    class Alphabet
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_alphabet";
                        default=1;
                    };
                    class Mod
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_mod";
                    };
                };
            };
            class ListGoggles: RscListBox
            {
                idc="960 + 					7";
                idcx=967;
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0};
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorPictureSelected[]={1,1,1,1};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
                colorPictureRightSelected[]={1,1,1,1};
            };
            class TabNVGs: RscButtonArsenal
            {
                idc="930 + 								8";
                idcx=938;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\NVGs_ca.paa";
                x="safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 12 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_NVGs";
            };
            class IconBackgroundNVGs: RscPicture
            {
                idc="830 + 								8";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconNVGs: TabNVGs
            {
                idc="900 + 								8";
                idcx=908;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class SortNVGs: RscCombo
            {
                idc="800 + 							8";
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class Items
                {
                    class Alphabet
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_alphabet";
                        default=1;
                    };
                    class Mod
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_mod";
                    };
                };
            };
            class ListNVGs: RscListBox
            {
                idc="960 + 							8";
                idcx=968;
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0};
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorPictureSelected[]={1,1,1,1};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
                colorPictureRightSelected[]={1,1,1,1};
            };
            class TabBinoculars: RscButtonArsenal
            {
                idc="930 + 						9";
                idcx=939;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Binoculars_ca.paa";
                x="safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 13.5 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_Binoculars";
            };
            class IconBackgroundBinoculars: RscPicture
            {
                idc="830 + 						9";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconBinoculars: TabBinoculars
            {
                idc="900 + 						9";
                idcx=909;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class SortBinoculars: RscCombo
            {
                idc="800 + 					9";
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class Items
                {
                    class Alphabet
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_alphabet";
                        default=1;
                    };
                    class Mod
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_mod";
                    };
                };
            };
            class ListBinoculars: RscListBox
            {
                idc="960 + 					9";
                idcx=969;
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0};
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorPictureSelected[]={1,1,1,1};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
                colorPictureRightSelected[]={1,1,1,1};
            };
            class TabMap: RscButtonArsenal
            {
                idc="930 + 								10";
                idcx=940;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Map_ca.paa";
                x="safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 15 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_Map";
            };
            class IconBackgroundMap: RscPicture
            {
                idc="830 + 								10";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconMap: TabMap
            {
                idc="900 + 								10";
                idcx=910;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class SortMap: RscCombo
            {
                idc="800 + 							10";
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class Items
                {
                    class Alphabet
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_alphabet";
                        default=1;
                    };
                    class Mod
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_mod";
                    };
                };
            };
            class ListMap: RscListBox
            {
                idc="960 + 							10";
                idcx=970;
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0};
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorPictureSelected[]={1,1,1,1};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
                colorPictureRightSelected[]={1,1,1,1};
            };
            class TabGPS: RscButtonArsenal
            {
                idc="930 + 								11";
                idcx=941;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\GPS_ca.paa";
                x="safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 16.5 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_GPS";
            };
            class IconBackgroundGPS: RscPicture
            {
                idc="830 + 								11";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconGPS: TabGPS
            {
                idc="900 + 								11";
                idcx=911;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class SortGPS: RscCombo
            {
                idc="800 + 							11";
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class Items
                {
                    class Alphabet
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_alphabet";
                        default=1;
                    };
                    class Mod
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_mod";
                    };
                };
            };
            class ListGPS: RscListBox
            {
                idc="960 + 							11";
                idcx=971;
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0};
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorPictureSelected[]={1,1,1,1};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
                colorPictureRightSelected[]={1,1,1,1};
            };
            class TabRadio: RscButtonArsenal
            {
                idc="930 + 								12";
                idcx=942;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Radio_ca.paa";
                x="safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 18 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_Radio";
            };
            class IconBackgroundRadio: RscPicture
            {
                idc="830 + 								12";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconRadio: TabRadio
            {
                idc="900 + 								12";
                idcx=912;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class SortRadio: RscCombo
            {
                idc="800 + 							12";
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class Items
                {
                    class Alphabet
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_alphabet";
                        default=1;
                    };
                    class Mod
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_mod";
                    };
                };
            };
            class ListRadio: RscListBox
            {
                idc="960 + 							12";
                idcx=972;
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0};
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorPictureSelected[]={1,1,1,1};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
                colorPictureRightSelected[]={1,1,1,1};
            };
            class TabCompass: RscButtonArsenal
            {
                idc="930 + 						13";
                idcx=943;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Compass_ca.paa";
                x="safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 19.5 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_Compass";
            };
            class IconBackgroundCompass: RscPicture
            {
                idc="830 + 						13";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconCompass: TabCompass
            {
                idc="900 + 						13";
                idcx=913;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class SortCompass: RscCombo
            {
                idc="800 + 					13";
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class Items
                {
                    class Alphabet
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_alphabet";
                        default=1;
                    };
                    class Mod
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_mod";
                    };
                };
            };
            class ListCompass: RscListBox
            {
                idc="960 + 					13";
                idcx=973;
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0};
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorPictureSelected[]={1,1,1,1};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
                colorPictureRightSelected[]={1,1,1,1};
            };
            class TabWatch: RscButtonArsenal
            {
                idc="930 + 								14";
                idcx=944;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Watch_ca.paa";
                x="safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 21 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_Watch";
            };
            class IconBackgroundWatch: RscPicture
            {
                idc="830 + 								14";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconWatch: TabWatch
            {
                idc="900 + 								14";
                idcx=914;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class SortWatch: RscCombo
            {
                idc="800 + 							14";
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class Items
                {
                    class Alphabet
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_alphabet";
                        default=1;
                    };
                    class Mod
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_mod";
                    };
                };
            };
            class ListWatch: RscListBox
            {
                idc="960 + 							14";
                idcx=974;
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0};
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorPictureSelected[]={1,1,1,1};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
                colorPictureRightSelected[]={1,1,1,1};
            };
            class TabFace: RscButtonArsenal
            {
                idc="930 + 								15";
                idcx=945;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Face_ca.paa";
                x="safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 22.5 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_Face";
            };
            class IconBackgroundFace: RscPicture
            {
                idc="830 + 								15";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconFace: TabFace
            {
                idc="900 + 								15";
                idcx=915;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class SortFace: RscCombo
            {
                idc="800 + 							15";
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class Items
                {
                    class Alphabet
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_alphabet";
                        default=1;
                    };
                    class Mod
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_mod";
                    };
                };
            };
            class ListFace: RscListBox
            {
                idc="960 + 							15";
                idcx=975;
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0};
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorPictureSelected[]={1,1,1,1};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
                colorPictureRightSelected[]={1,1,1,1};
            };
            class TabVoice: RscButtonArsenal
            {
                idc="930 + 								16";
                idcx=946;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Voice_ca.paa";
                x="safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 24 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_Voice";
            };
            class IconBackgroundVoice: RscPicture
            {
                idc="830 + 								16";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconVoice: TabVoice
            {
                idc="900 + 								16";
                idcx=916;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class SortVoice: RscCombo
            {
                idc="800 + 							16";
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class Items
                {
                    class Alphabet
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_alphabet";
                        default=1;
                    };
                    class Mod
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_mod";
                    };
                };
            };
            class ListVoice: RscListBox
            {
                idc="960 + 							16";
                idcx=976;
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0};
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorPictureSelected[]={1,1,1,1};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
                colorPictureRightSelected[]={1,1,1,1};
            };
            class TabInsignia: RscButtonArsenal
            {
                idc="930 + 						17";
                idcx=947;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Insignia_ca.paa";
                x="safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 25.5 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_Insignia";
            };
            class IconBackgroundInsignia: RscPicture
            {
                idc="830 + 						17";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconInsignia: TabInsignia
            {
                idc="900 + 						17";
                idcx=917;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class SortInsignia: RscCombo
            {
                idc="800 + 					17";
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class Items
                {
                    class Alphabet
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_alphabet";
                        default=1;
                    };
                    class Mod
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_mod";
                    };
                };
            };
            class ListInsignia: RscListBox
            {
                idc="960 + 					17";
                idcx=977;
                x="safezoneX + 2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0};
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorPictureSelected[]={1,1,1,1};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
                colorPictureRightSelected[]={1,1,1,1};
            };
            class TabItemOptic: RscButtonArsenal
            {
                idc="930 + 						18";
                idcx=948;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\ItemOptic_ca.paa";
                x="safezoneX + safezoneW - 2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 0 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_ItemOptic";
            };
            class IconBackgroundItemOptic: RscPicture
            {
                idc="830 + 						18";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconItemOptic: TabItemOptic
            {
                idc="900 + 						18";
                idcx=918;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class SortItemOptic: RscCombo
            {
                idc="800 + 					18";
                x="safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class Items
                {
                    class Alphabet
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_alphabet";
                        default=1;
                    };
                    class Mod
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_mod";
                    };
                };
            };
            class ListItemOptic: RscListBox
            {
                idc="960 + 					18";
                idcx=978;
                x="safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 12.0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0};
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorPictureSelected[]={1,1,1,1};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
                colorPictureRightSelected[]={1,1,1,1};
            };
            class TabItemAcc: RscButtonArsenal
            {
                idc="930 + 						19";
                idcx=949;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\ItemAcc_ca.paa";
                x="safezoneX + safezoneW - 2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 1.5 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_ItemAcc";
            };
            class IconBackgroundItemAcc: RscPicture
            {
                idc="830 + 						19";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconItemAcc: TabItemAcc
            {
                idc="900 + 						19";
                idcx=919;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class SortItemAcc: RscCombo
            {
                idc="800 + 					19";
                x="safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class Items
                {
                    class Alphabet
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_alphabet";
                        default=1;
                    };
                    class Mod
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_mod";
                    };
                };
            };
            class ListItemAcc: RscListBox
            {
                idc="960 + 					19";
                idcx=979;
                x="safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 12.0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0};
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorPictureSelected[]={1,1,1,1};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
                colorPictureRightSelected[]={1,1,1,1};
            };
            class TabItemMuzzle: RscButtonArsenal
            {
                idc="930 + 						20";
                idcx=950;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\ItemMuzzle_ca.paa";
                x="safezoneX + safezoneW - 2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 3 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_ItemMuzzle";
            };
            class IconBackgroundItemMuzzle: RscPicture
            {
                idc="830 + 						20";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconItemMuzzle: TabItemMuzzle
            {
                idc="900 + 						20";
                idcx=920;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class SortItemMuzzle: RscCombo
            {
                idc="800 + 					20";
                x="safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class Items
                {
                    class Alphabet
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_alphabet";
                        default=1;
                    };
                    class Mod
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_mod";
                    };
                };
            };
            class ListItemMuzzle: RscListBox
            {
                idc="960 + 					20";
                idcx=980;
                x="safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 12.0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0};
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorPictureSelected[]={1,1,1,1};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
                colorPictureRightSelected[]={1,1,1,1};
            };
            class TabItemBipod: RscButtonArsenal
            {
                idc="930 + 						25";
                idcx=955;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\ItemBipod_ca.paa";
                x="safezoneX + safezoneW - 2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 4.5 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_ItemBipod";
            };
            class IconBackgroundItemBipod: RscPicture
            {
                idc="830 + 						25";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconItemBipod: TabItemBipod
            {
                idc="900 + 						25";
                idcx=925;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class SortItemBipod: RscCombo
            {
                idc="800 + 					25";
                x="safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                class Items
                {
                    class Alphabet
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_alphabet";
                        default=1;
                    };
                    class Mod
                    {
                        text="$STR_a3_rscdisplayarsenal_sort_mod";
                    };
                };
            };
            class ListItemBipod: RscListBox
            {
                idc="960 + 					25";
                idcx=985;
                x="safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 12.0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={0,0,0,0};
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorPictureSelected[]={1,1,1,1};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
                colorPictureRightSelected[]={1,1,1,1};
            };
            class TabCargoMag: RscButtonArsenal
            {
                idc="930 + 						21";
                idcx=951;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\CargoMag_ca.paa";
                x="safezoneX + safezoneW - 2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 0 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_CargoMag";
            };
            class IconBackgroundCargoMag: RscPicture
            {
                idc="830 + 						21";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconCargoMag: TabCargoMag
            {
                idc="900 + 						21";
                idcx=921;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class ListCargoMag: RscListNBox
            {
                idc="960 + 					21";
                idcx=981;
                x="safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 12.0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                columns[]={0.07,0.15000001,0.75};
                drawSideArrows=1;
                disableOverflow=1;
                idcLeft=992;
                idcRight=993;
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
            };
            class TabCargoMagAll: RscButtonArsenal
            {
                idc="930 + 						26";
                idcx=956;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\CargoMagAll_ca.paa";
                x="safezoneX + safezoneW - 2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 1.5 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_CargoMagAll";
            };
            class IconBackgroundCargoMagAll: RscPicture
            {
                idc="830 + 						26";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconCargoMagAll: TabCargoMagAll
            {
                idc="900 + 						26";
                idcx=926;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class ListCargoMagAll: RscListNBox
            {
                idc="960 + 					26";
                idcx=986;
                x="safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 12.0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                columns[]={0.07,0.15000001,0.75};
                drawSideArrows=1;
                disableOverflow=1;
                idcLeft=992;
                idcRight=993;
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
            };
            class TabCargoThrow: RscButtonArsenal
            {
                idc="930 + 						22";
                idcx=952;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\CargoThrow_ca.paa";
                x="safezoneX + safezoneW - 2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 3 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_CargoThrow";
            };
            class IconBackgroundCargoThrow: RscPicture
            {
                idc="830 + 						22";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconCargoThrow: TabCargoThrow
            {
                idc="900 + 						22";
                idcx=922;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class ListCargoThrow: RscListNBox
            {
                idc="960 + 					22";
                idcx=982;
                x="safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 12.0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                columns[]={0.07,0.15000001,0.75};
                drawSideArrows=1;
                disableOverflow=1;
                idcLeft=992;
                idcRight=993;
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
            };
            class TabCargoPut: RscButtonArsenal
            {
                idc="930 + 						23";
                idcx=953;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\CargoPut_ca.paa";
                x="safezoneX + safezoneW - 2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 4.5 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_CargoPut";
            };
            class IconBackgroundCargoPut: RscPicture
            {
                idc="830 + 						23";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconCargoPut: TabCargoPut
            {
                idc="900 + 						23";
                idcx=923;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class ListCargoPut: RscListNBox
            {
                idc="960 + 					23";
                idcx=983;
                x="safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 12.0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                columns[]={0.07,0.15000001,0.75};
                drawSideArrows=1;
                disableOverflow=1;
                idcLeft=992;
                idcRight=993;
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
            };
            class TabCargoMisc: RscButtonArsenal
            {
                idc="930 + 						24";
                idcx=954;
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\CargoMisc_ca.paa";
                x="safezoneX + safezoneW - 2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.02 + 6 * (((safezoneH - 0.1) / 18 / 1.5) min (0.04))";
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="(	(1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) min (safezoneH / 18 / 1.5))";
                tooltip="$STR_A3_RscDisplayArsenal_tab_CargoMisc";
            };
            class IconBackgroundCargoMisc: RscPicture
            {
                idc="830 + 						24";
                text="\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
                x=-1;
                y=-1;
                w="1.4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorText[]={0,0,0,0.80000001};
            };
            class IconCargoMisc: TabCargoMisc
            {
                idc="900 + 						24";
                idcx=924;
                x=-1;
                y=-1;
                h="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                colorBackground[]={1,1,1,0};
            };
            class ListCargoMisc: RscListNBox
            {
                idc="960 + 					24";
                idcx=984;
                x="safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                y="safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                w="15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                h="safezoneH - 12.0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                sizeEx="1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                columns[]={0.07,0.15000001,0.75};
                drawSideArrows=1;
                disableOverflow=1;
                idcLeft=992;
                idcRight=993;
                colorSelectBackground[]={1,1,1,0.5};
                colorSelectBackground2[]={1,1,1,0.5};
                colorSelect[]={1,1,1,1};
                colorSelect2[]={1,1,1,1};
            };
        };
    };
