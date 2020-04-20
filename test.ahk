#IfWinActive ahk_class LaunchUnrealUWindowsClient
; DetectHiddenWindows, On

;抓取颜色函数，在上面脚本中调用。
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

;接勇猛咯 1080p
getYongmeng() {
    SendInput, j
    Sleep, 500
    Send {Click 924, 284} ;入手书信tab页
    Send {Click 1032, 733}
    Sleep, 600
    Loop, 5
    {
        Send {Click}
        Sleep, 600
    }
    SendInput, f
    ToolTip, 接好咯
    Sleep, 1000
    SendInput, j
    return
}

; 交勇猛 1080p
handYongmeng(ix, iy) {
    SendInput, i
    Sleep, 500
    Send {Click %ix%, %iy%}
    Sleep, 700
    Loop, 6
    {
        Send {Click}
        Sleep, 400
    }
    SendInput, f
    ToolTip, 交好咯
    Sleep, 1000
    SendInput, i
    return
}

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

timer := {}

MsgBox, 0, , 鼠标移动到需要释放的技能上面按下Alt+对应技能键取色，取好后alt+f1开始

; 下面坐标可以 F1 取色然后参照修改
SkillAuto:
    if (timer.ymAuto != 1) { 
        return 
    }
    if ( GetColor(sf.x, sf.y) == sf.color ) ;(捡东西, 分辨率 1080p) f亮了就快点她
    {
        SendInput, f
        Sleep, 20
    }
    if ( GetColor(s2.x, s2.y) != s2.color ) { ;技能2识别，如果亮了说明进入战斗，开始你的表演
        if ( GetColor(sTab.x, sTab.y) == sTab.color ) ;(TAB可用, 分辨率 1080p)
        {
            SendInput, {Tab}
            Sleep, 20
        }
        if ( GetColor(st.x, st.y) != st.color ) ;(右键技能, 分辨率 1080p)
        {
            SendInput, t
            Sleep, 50
        }
        if ( GetColor(sv.x, sv.y) == sv.color ) ;(v可用, 分辨率 1080p)
        {
            SendInput, v
            Sleep, 100
        }
        if ( GetColor(s4.x, s4.y) != s4.color ) ;(4可用, 分辨率 1080p)j
        {
            SendInput, 4
            Sleep, 100
        }
    }
    return

TaskAuto:
    ImageSearch, FoundX, FoundY, 1675, 320, 1900, 990, %A_WorkingDir%\task-done.bmp
    if (ErrorLevel == 0) {
        handYongmeng(FoundX, FoundY)
        Sleep, 1000
        getYongmeng()
        return
    }
    ;(被怪攻击了任务没接到没关系再接一次, 分辨率 1080p) 识别勇猛蓝色进度条出来没有
    ; PixelSearch, Px, Py, 1710, 731, 1714, 734, 0x3BA8FF, 0, Fast
    ; ToolTip, %ErrorLevel%
    ; if (ErrorLevel == 1) {
    ;     getYongmeng()
    ;     Sleep, 1000
    ; }
    if ( GetColor(1713, 732) != "0x3BA8FF" ) {
         getYongmeng()
         Sleep, 1000
    }
    return

; 手动接任务
Alt & F3::
    getYongmeng()
return

Alt & TAB::
    res := getPosAndColor()
    MsgBox, % TAB技能色是 res.y
    sTab := res.Clone()
    return

Alt & 2::
    res := getPosAndColor()
    MsgBox, % 2技能色是 res.color
    s2 := res.Clone()
return

Alt & 4::
    res := getPosAndColor()
    MsgBox, % 4技能色是 res.color
    s4 := res.Clone()
return

Alt & v::
    res := getPosAndColor()
    MsgBox, % v技能色是 res.color
    sv := res.Clone()
return

Alt & t::
    res := getPosAndColor()
    MsgBox, % 右键技能色是 res.color
    st := res.Clone()
return

Alt & f::
    res := getPosAndColor()
    MsgBox, % 拾取F技能色是 res.color
    sf := res.Clone()
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
    ToolTip, %MouseX%，%MouseY%颜色是：%color%
return
