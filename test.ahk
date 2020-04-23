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
    global sp
    SendInput, j
    Sleep, 80

    spx := sp.x
    spy := sp.y

    ToolTip, % 入手书信 spx
    Send {Click %spx%, %spy%} ;入手书信tab页
    Sleep, 1000

    searchAreaX1 := sp.x - 150
    searchAreaY1 := sp.y + 100
    searchAreaX2 := sp.x - 20
    searchAreaY2 := sp.x + 600

    PixelSearch, Rx, Ry, %searchAreaX1%, %searchAreaY1%, %searchAreaX2%, %searchAreaY2%, 0x3191C9, 3, Fast RGB
    if (ErrorLevel == 1) {
        TrayTip, 清漪的小提示, 找不到勇猛怪我咯
        SendInput, j
        return
    }
    targetX := Rx + 204
    TrayTip, 清漪的小提示, %targetX%， %Ry%
    Send {Click %targetX%, %Ry%}
    Sleep, 600
    Loop, 5
    {
        SendInput, {Space}
        Sleep, 600
    }
    SendInput, f
    TrayTip, 清漪的小提示, 接好咯
    Sleep, 1000
    SendInput, j
    return
}

; 交勇猛 1080p
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
    TrayTip, 清漪的小提示, 交好咯
    Sleep, 1000
    SendInput, i
    return
}

mosterDetected() {
    global s2
    ret := GetColor(s2.x, s2.y) != s2.color
    TrayTip, 清漪的小提示, 各单位请注意，目标出现了！
    return ret
}

MsgBox, 0, , 鼠标移动到需要释放的技能上面按下Alt+对应技能键取色，取好后alt+f1开始`n例如： 按ALT+2 保存2号技能，当出现提示信息点击确认保存成功`n需要清漪的小程序自动交接任务的话必须要保存 任务面板入手书信位置（ALT+P）和 交任务小书卷图标的位置信息 (ALT+I)

; 下面坐标可以 F1 取色然后参照修改
SkillAuto:
    if (timer.ymAuto != 1) { 
        return 
    }
    if ( GetColor(sf.x, sf.y) == sf.color ) ;(捡东西, 分辨率 1080p) f亮了就快点她
    {
        SendInput, f
        Sleep, 20
        SendInput, y
        Sleep, 20
    }
    if mosterDetected() { ;技能2识别，如果亮了说明进入战斗，开始你的表演
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

    ;(被怪攻击了任务没接到没关系再接一次, 分辨率 1080p) 识别勇猛蓝色进度条出来没有
    PixelSearch, Px, Py, 1710, 666, 1714, 799, 0x3BA8FF, 1, Fast RGB
    if (ErrorLevel == 1) {
        getYongmeng()
        TrayTip, 清漪的小提示, 再接一次任务
        Sleep, 1000
    }
    ; if ( GetColor(1713, 732) != "0x3BA8FF" ) {
    ;      getYongmeng()
    ;      Sleep, 1000
    ; }
    return

; 手动接任务
Alt & F3::
    getYongmeng()
return

Alt & TAB::
    res := getPosAndColor()
    MsgBox, % 已保存好tab技能哦 TAB技能色是 res.y
    sTab := res.Clone()
    return

Alt & 2::
    res := getPosAndColor()
    MsgBox, % 已保存好2技能哦 2技能色是 res.color
    s2 := res.Clone()
return

Alt & 4::
    res := getPosAndColor()
    MsgBox, % 已保存好4技能哦 4技能色是 res.color
    s4 := res.Clone()
return

Alt & v::
    res := getPosAndColor()
    MsgBox, % 已保存好v技能哦 v技能色是 res.color
    sv := res.Clone()
return

Alt & t::
    res := getPosAndColor()
    MsgBox, % 已保存t技能哦 右键技能色是 res.color
    st := res.Clone()
return

Alt & f::
    res := getPosAndColor()
    MsgBox, % 已保存f 拾取F技能色是 res.color
    sf := res.Clone()

Alt & i::
    res := getPosAndColor()
    MsgBox, % 已保存任务图标信息，交任务图标色是 res.color
    si := res.Clone()

Alt & p::
    res := getPosAndColor()
    MsgBox, % 已保存任务面板入手书卷信息 res.x
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
    ToolTip, %MouseX%，%MouseY%颜色是：%color%
return