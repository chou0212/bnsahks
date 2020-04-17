#IfWinActive ahk_class LaunchUnrealUWindowsClient

;抓取颜色函数，在上面脚本中调用。
GetColor(x,y)
{
    PixelGetColor, color, x, y, RGB
    StringRight color, color, 10 ;
    return color
}

;接勇猛咯 1080p
getYongmeng() {
    SendInput, j
    Sleep, 500
    Send {Click 1037, 775}
    Sleep, 600
    Send {Click}
    Sleep, 600
    Send {Click}
    Sleep, 600
    Send {Click}
    Sleep, 600
    Send {Click}
    Sleep, 600
    Send {Click}
    Sleep, 600
    SendInput, f
    ToolTip, 接好咯
    Sleep, 1000
    SendInput, j
    return
}

; 交勇猛 1080p
handYongmeng() {
    SendInput, i
    Sleep, 500
    Send {Click 1723, 431}
    Sleep, 700
    Send {Click}
    Sleep, 400
    Send {Click}
    Sleep, 400
    Send {Click}
    Sleep, 400
    Send {Click}
    Sleep, 400
    Send {Click}
    Sleep, 400
    Send {Click}
    Sleep, 400
    SendInput, f
    ToolTip, 交好咯
    Sleep, 1000
    SendInput, i
    return
}



yujianAuto:
    timeFlag := 1
    if ( GetColor(945, 978) != "0x232323" ) {
        if ( GetColor(857, 973) == "0x848BD2" ) ;(TAB可用, 分辨率 1080p)
        {
            SendInput, {Tab}
            Sleep, 20
        }
        if ( GetColor(1119, 974) != "0x626262" ) ;(右键技能, 分辨率 1080p)
        {
            SendInput, t
            Sleep, 50
        }
        if ( GetColor(1028, 1031) == "0x445BEE" ) ;(v可用, 分辨率 1080p)
        {
            SendInput, v
            Sleep, 200
        }
        if ( GetColor(1027, 972) == "0xF7FBFF" ) ;(4可用, 分辨率 1080p)
        {
            SendInput, 4
            Sleep, 200
        }
    }
    if ( GetColor(1124, 802) == "0x4C3A27" ) ;(捡东西, 分辨率 1080p)
    {
        SendInput, f
        Sleep, 20
    }
    if ( GetColor(1706, 740) != "0xFFFFFF" && isHanding != 1 ) ;(任务没接到, 分辨率 1080p)
    {
        getYongmeng()
        Sleep, 20000
    }
    ; 交任务
    if ( GetColor(1723, 431) == "0xB85F22" )
    {
        isHanding := 1
        handYongmeng()
        Sleep, 1000
        getYongmeng()
        isHanding := 0
    } 
return

Alt & F3::
    getYongmeng()
return

Alt & F1::
    if ( timeFlag == 1) {
        SetTimer, yujianAuto, off
        timeFlag := 0
    } else {
        SetTimer, yujianAuto, 0
    }
return

$F1::
    MouseGetPos, MouseX, MouseY
    PixelGetColor, color, %MouseX%, %MouseY%, RGB
    StringRight color,color,10 ;
    ToolTip, %MouseX%，%MouseY%颜色是：%color%
return
