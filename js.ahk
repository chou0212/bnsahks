#IfWinActive ahk_class LaunchUnrealUWindowsClient

MsgBox, 鼠标右键按下开始表演哦，松开停止

timer := {}

; 下面坐标可以 F1 取色然后参照修改
SkillAuto:
    if (timer.skAuto != 1) { 
        return 
    }
    SendInput, {Tab}
    Sleep, 50
    SendInput, v
    Sleep, 20
    SendInput, 4
    Sleep, 20
    SendInput, f
    Sleep, 20
    SendInput, r
    Sleep, 50
    return


RButton::
    if ( timer.skAuto == 1) {
        SetTimer, SkillAuto, off
        SoundPlay *-1
        timer.skAuto := 0
    } else {
        SetTimer, SkillAuto, 0
        timer.skAuto := 1
        SoundPlay *48
    }
    return

RButton Up::
    SetTimer, SkillAuto, 0
    timer.skAuto := 1
    SoundPlay *48
    return
