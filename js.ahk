#IfWinActive ahk_class LaunchUnrealUWindowsClient

MsgBox, 鼠标右键按下开始表演哦，松开停止

timer := {}

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
    SetTimer, SkillAuto, off
    timer.skAuto := 0
    SoundPlay *48
    return
