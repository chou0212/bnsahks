#IfWinActive ahk_class LaunchUnrealUWindowsClient
; DetectHiddenWindows, On

;ץȡ��ɫ������������ű��е��á�
GetColor(x,y)
{
    PixelGetColor, color, x, y, RGB
    StringRight color, color, 10 ;
    return color
}

;�����Ϳ� 1080p
getYongmeng() {
    SendInput, j
    Sleep, 500
    Send {Click 1037, 734}
    Sleep, 600
    Loop, 5
    {
        Send {Click}
        Sleep, 600
    }
    SendInput, f
    ToolTip, �Ӻÿ�
    Sleep, 1000
    SendInput, j
    return
}

; ������ 1080p
handYongmeng() {
    SendInput, i
    Sleep, 500
    Send {Click 1723, 431}
    Sleep, 700
    Loop, 6
    {
        Send {Click}
        Sleep, 400
    }
    SendInput, f
    ToolTip, ���ÿ�
    Sleep, 1000
    SendInput, i
    return
}

timer := {}

; ����������� F1 ȡɫȻ������޸�
yujianAuto:
    if (timer.yujianAuto != 1) { return }
    if ( GetColor(1124, 802) == "0x4C3A27" ) ;(����, �ֱ��� 1080p) f���˾Ϳ����
    {
        SendInput, f
        Sleep, 20
    }
    if ( GetColor(945, 978) != "0x232323" ) { ;����2ʶ���������˵������ս������ʼ��ı���
        if ( GetColor(857, 973) == "0x848BD2" ) ;(TAB����, �ֱ��� 1080p)
        {
            SendInput, {Tab}
            Sleep, 20
        }
        if ( GetColor(1120, 974) != "0x585858" ) ;(�Ҽ�����, �ֱ��� 1080p)
        {
            SendInput, t
            Sleep, 50
        }
        if ( GetColor(1028, 1031) == "0x445BEE" ) ;(v����, �ֱ��� 1080p)
        {
            SendInput, v
            Sleep, 200
        }
        if ( GetColor(1027, 972) == "0xF7FBFF" ) ;(4����, �ֱ��� 1080p)
        {
            SendInput, 4
            Sleep, 200
        }
    } else {
        ; ������
        if ( GetColor(1723, 431) == "0xB85F22" ) ;����С��ͼ��������͵���
        {
            handYongmeng()
            Sleep, 1000
            getYongmeng()
        }
        else if ( GetColor(1713, 787) != "0x32A0FF" ) ;(���ֹ���������û�ӵ�û��ϵ�ٽ�һ��, �ֱ��� 1080p) ʶ��������ɫ����������û��
        {
            getYongmeng()
            Sleep, 5000
        }
    }
    return


; �ֶ�������
Alt & F3::
    getYongmeng()
return

Alt & F1::
    if ( timer.yujianAuto == 1) {
        SetTimer, yujianAuto, off
        timer.yujianAuto := 0
    } else {
        SetTimer, yujianAuto, 0
        timer.yujianAuto := 1
    }
return

$F1::
    MouseGetPos, MouseX, MouseY
    PixelGetColor, color, %MouseX%, %MouseY%, RGB
    StringRight color,color,10 ;
    ToolTip, %MouseX%��%MouseY%��ɫ�ǣ�%color%
return
