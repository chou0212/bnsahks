#IfWinActive ahk_class LaunchUnrealUWindowsClient
; DetectHiddenWindows, On

sTab := {}
sTab.x := 855
sTab.y := 973
sTab.color := "0x9EA4F9"

st := {}
st.x := 1124
st.y := 971
st.color := "0x313131"

s2 := {}
s2.x := 946
s2.y := 974
s2.color := "0x626262"

s4 := {}
s4.x := 1030
s4.y := 970
s4.color := "0xB8C4AD"

sv := {}
sv.x := 1028
sv.y := 1026
sv.color := "0xEBF9FF"

sf := {}
sf.x := 1121
sf.y := 811
sf.color := "0x463220"

si := {}
si.x := 1728
si.y := 407
si.color := "0xB66A31"

sp := {}
sp.x := 924
sp.y := 284

timer := {}

;ץȡ��ɫ������������ű��е��á�
GetColor(x,y)
{
    PixelGetColor, color, x, y, RGB
    StringRight color, color, 10
    return color
}

getPosAndColor() {
    ret := {}
    MouseGetPos, MouseX, MouseY
    PixelGetColor, color, %MouseX%, %MouseY%, RGB
    StringRight color, color, 10
    ret.x := MouseX
    ret.y := MouseY
    ret.color := color
    return ret
}

;�����Ϳ� 1080p
getYongmeng() {
    global sp
    SendInput, j
    Sleep, 80

    spx := sp.x
    spy := sp.y

    ToolTip, % �������� spx
    Send {Click %spx%, %spy%} ;��������tabҳ
    Sleep, 1000

    searchAreaX1 := sp.x - 150
    searchAreaY1 := sp.y + 100
    searchAreaX2 := sp.x - 20
    searchAreaY2 := sp.x + 600

    PixelSearch, Rx, Ry, %searchAreaX1%, %searchAreaY1%, %searchAreaX2%, %searchAreaY2%, 0x3191C9, 3, Fast RGB
    if (ErrorLevel == 1) {
        TrayTip, ������С��ʾ, �Ҳ������͹��ҿ�
        SendInput, j
        return
    }
    targetX := Rx + 204
    TrayTip, ������С��ʾ, %targetX%�� %Ry%
    Send {Click %targetX%, %Ry%}
    Sleep, 600
    Loop, 5
    {
        SendInput, {Space}
        Sleep, 600
    }
    SendInput, f
    TrayTip, ������С��ʾ, �Ӻÿ�
    Sleep, 1000
    SendInput, j
    return
}

; ������ 1080p
handYongmeng(ix, iy) {
    SendInput, i
    Sleep, 300
    Send {Click %ix%, %iy%}
    Sleep, 700
    Loop, 6
    {
        SendInput, {Space}
        Sleep, 400
    }
    SendInput, f
    TrayTip, ������С��ʾ, ���ÿ�
    Sleep, 1000
    SendInput, i
    return
}

mosterDetected() {
    global s2
    ret := GetColor(s2.x, s2.y) != s2.color
    TrayTip, ������С��ʾ, ����λ��ע�⣬Ŀ������ˣ�
    return ret
}

MsgBox, 0, , ����ƶ�����Ҫ�ͷŵļ������水��Alt+��Ӧ���ܼ�ȡɫ��ȡ�ú�alt+f1��ʼ`n���磺 ��ALT+2 ����2�ż��ܣ���������ʾ��Ϣ���ȷ�ϱ���ɹ�`n��Ҫ������С�����Զ���������Ļ�����Ҫ���� ���������������λ�ã�ALT+P���� ������С���ͼ���λ����Ϣ (ALT+I)

; ����������� F1 ȡɫȻ������޸�
SkillAuto:
    if (timer.ymAuto != 1) { 
        return 
    }
    if ( GetColor(sf.x, sf.y) == sf.color ) ;(����, �ֱ��� 1080p) f���˾Ϳ����
    {
        SendInput, f
        Sleep, 20
        SendInput, y
        Sleep, 20
    }
    if mosterDetected() { ;����2ʶ���������˵������ս������ʼ��ı���
        if ( GetColor(sTab.x, sTab.y) == sTab.color ) ;(TAB����, �ֱ��� 1080p)
        {
            SendInput, {Tab}
            Sleep, 20
        }
        if ( GetColor(st.x, st.y) != st.color ) ;(�Ҽ�����, �ֱ��� 1080p)
        {
            SendInput, t
            Sleep, 50
        }
        if ( GetColor(sv.x, sv.y) == sv.color ) ;(v����, �ֱ��� 1080p)
        {
            SendInput, v
            Sleep, 100
        }
        if ( GetColor(s4.x, s4.y) != s4.color ) ;(4����, �ֱ��� 1080p)j
        {
            SendInput, 4
            Sleep, 100
        }
    }
    return

TaskAuto:
    if mosterDetected()  {
        return
    }

    if ( GetColor(si.x, si.y) == si.color  ) {
        handYongmeng(si.x, si.y)
        Sleep, 1000
        getYongmeng()
        return
    }

    ; ImageSearch, FoundX, FoundY, 1675, 320, 1900, 990, %A_WorkingDir%\task-done.bmp

    ;(���ֹ���������û�ӵ�û��ϵ�ٽ�һ��, �ֱ��� 1080p) ʶ��������ɫ����������û��
    PixelSearch, Px, Py, 1710, 666, 1714, 799, 0x3BA8FF, 1, Fast RGB
    if (ErrorLevel == 1) {
        getYongmeng()
        TrayTip, ������С��ʾ, �ٽ�һ������
        Sleep, 1000
    }
    ; if ( GetColor(1713, 732) != "0x3BA8FF" ) {
    ;      getYongmeng()
    ;      Sleep, 1000
    ; }
    return

; �ֶ�������
Alt & F3::
    getYongmeng()
return

Alt & TAB::
    res := getPosAndColor()
    MsgBox, % �ѱ����tab����Ŷ TAB����ɫ�� res.y
    sTab := res.Clone()
    return

Alt & 2::
    res := getPosAndColor()
    MsgBox, % �ѱ����2����Ŷ 2����ɫ�� res.color
    s2 := res.Clone()
return

Alt & 4::
    res := getPosAndColor()
    MsgBox, % �ѱ����4����Ŷ 4����ɫ�� res.color
    s4 := res.Clone()
return

Alt & v::
    res := getPosAndColor()
    MsgBox, % �ѱ����v����Ŷ v����ɫ�� res.color
    sv := res.Clone()
return

Alt & t::
    res := getPosAndColor()
    MsgBox, % �ѱ���t����Ŷ �Ҽ�����ɫ�� res.color
    st := res.Clone()
return

Alt & f::
    res := getPosAndColor()
    MsgBox, % �ѱ���f ʰȡF����ɫ�� res.color
    sf := res.Clone()

Alt & i::
    res := getPosAndColor()
    MsgBox, % �ѱ�������ͼ����Ϣ��������ͼ��ɫ�� res.color
    si := res.Clone()

Alt & p::
    res := getPosAndColor()
    MsgBox, % �ѱ�������������������Ϣ res.x
    sp := res.Clone()

return

Alt & F1::
    if ( timer.ymAuto == 1) {
        SetTimer, SkillAuto, off
        SetTimer, TaskAuto, off
        timer.ymAuto := 0
    } else {
        SetTimer, SkillAuto, 0
        SetTimer, TaskAuto, 15000
        timer.ymAuto := 1
    }
return

$F1::
    MouseGetPos, MouseX, MouseY
    PixelGetColor, color, %MouseX%, %MouseY%, RGB
    StringRight color,color,10 ;
    ToolTip, %MouseX%��%MouseY%��ɫ�ǣ�%color%
return