#IfWinActive ahk_class LaunchUnrealUWindowsClient

MsgBox, ALT+F2����/�رգ�����Ҽ����¿�ʼ����Ŷ���ɿ�ֹͣ

timer := {}

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
    if ( timer.skAuto == 1) {
        SetTimer, SkillAuto, off
        timer.skAuto := 0
    } else {
        SetTimer, SkillAuto, 0
        timer.skAuto := 1
    }
    return

RButton Up::
    if (timer.off) {
        return
    }
    SetTimer, SkillAuto, off
    timer.skAuto := 0
    return

Alt & F2::
    Suspend
    if (A_IsSuspended) {
        SoundPlay *64
    } else {
        SoundPlay *16
    }
return