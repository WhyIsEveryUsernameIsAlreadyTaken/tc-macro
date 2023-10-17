#Persistent
#NoEnv
SetControlDelay, 0
SetWinDelay, 0
SendMode, Input

removeToolTip(){
	ToolTip
}

centeredToolTip(text, duration = 1000){
	ToolTip, %text%, A_ScreenWidth/2, A_ScreenHeight/2
	SetTimer, RemoveToolTip, -%duration%
}

^j::
	afk := !afk
	if (afk){
		clipboard := ""
		centeredToolTip("Clipboard emptied, please copy your desired message", 5000)
		ClipWait, , 0 ; wait indefinitely for the clipboard to contain raw text
		centeredToolTip("Message copied & script enabled!", 5000)
	}
	else {
		centeredToolTip("Off")
	}
	while (afk){
		Sleep 500
		WinActivate, Warframe
		WinGetPos, X, Y,,, Warframe
		Sleep 20
		MouseMove X+10, Y+10
		Sleep 20
		Send {Click}
		Sleep 20
		SendInput {Ctrl Down}
		Sleep 20
		SendInput {v}
		Sleep 20
		SendInput {Ctrl Up}
		sleep 20
		SendInput {enter}
		Sleep 20
		SendInput {Blind}{t}
		Sleep 20
		SendInput {Blind}{BackSpace}
		Sleep 120050
}
return
