#IfWinActive ahk_class LaunchUnrealUWindowsClient

timer := {}
skInterval := 20    

MsgBox, ALT+F2����/�رգ�����Ҽ����¿�ʼ����Ŷ���ɿ�ֹͣ

InputBox, inputSkInterval, ���ü��ܼ��, �������ܼ������λ���룩., , 400, 200
if ErrorLevel
    MsgBox, �Ǿ��������̰�.
else
    skInterval := inputSkInterval

Suspend

SkillAuto:
    if (timer.skAuto != 1) {
        return 
    }
    SendInput, {Tab}
    Sleep, 100
    SendInput, v
    Sleep, %skInterval%
    SendInput, 4
    Sleep, %skInterval%
    SendInput, t
    Sleep, %skInterval%
    SendInput, f
    Sleep, %skInterval%
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