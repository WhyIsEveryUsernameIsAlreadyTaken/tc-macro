#IfWinActive AHK_exe Warframe.x64.exe
#SingleInstance Force
#Persistent
#NoEnv
toggle := 0
SetBatchLines -1
SetKeyDelay, -1
SetMouseDelay, -1
SetControlDelay, -1
SetWinDelay, -1
#MaxHotkeysPerInterval 200

^j:: ; ctrl + j
    afk := !afk
    if (afk){
        CenteredToolTip("On")
    }
    Else {
        CenteredToolTip("Off")
    }
    While (afk){
        Sleep 500
        SendInput {Ctrl Down}
        Sleep 1
        SendInput {v}
        Sleep 1
        SendInput {Ctrl Up}
        sleep 1
        SendInput {enter}
        Sleep 1
        SendInput {Blind}{t}
        Sleep 120050
    }
Return

CenteredToolTip(text, duration = 999){ ; Duration in ms (MilliSeconds). Default value can be optionally overridden
    ToolTip, %text%, A_ScreenWidth/2, A_ScreenHeight/2
    SetTimer, RemoveToolTip, -%duration% ; Negative to only trigger once
}
RemoveToolTip(){
    ToolTip
}
