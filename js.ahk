#IfWinActive ahk_class LaunchUnrealUWindowsClient

MsgBox, 鼠标右键按下开始表演哦，松开停止

timer := {}
timer.off := true

SkillAuto:
    if (timer.skAuto != 1) {
        return 
    }
    SendInput, {Tab}
    Sleep, 100
    SendInput, v
    Sleep, 20
    SendInput, 4
    Sleep, 20
    SendInput, t
    Sleep, 20
    SendInput, f
    Sleep, 20
    SendInput, r
    Sleep, 50
    return


RButton::
    if (timer.off) {
        return
    }
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
    if (timer.off) {
        return
    }
    SetTimer, SkillAuto, off
    timer.skAuto := 0
    SoundPlay *-1
    return

Alt & F2::
    timer.off := !timer.off
return