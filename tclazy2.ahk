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
		MsgBox, 3, tclazy2, Do you want to replace last saved message?
		IfMsgBox Yes
		{
			clipboard := ""
			centeredToolTip("Clipboard emptied, please copy your desired message", 5000)
			ClipWait, , 0 ; wait indefinitely for the clipboard to contain raw text
			FileDelete copypastamsg.txt
			FileAppend %Clipboard%, copypastamsg.txt
			clipboard := ""
			centeredToolTip("Message copied & script enabled!", 5000)
		}
		else IfMsgBox No
		{
			centeredToolTip("Script enabled!", 5000)
		}
		else IfMsgBox Cancel
		{
			Reload
		}
	}
	else {
		centeredToolTip("Off")
	}
	while (afk){
		BlockInput On
		WinGet, winid ,, A
		MouseGetPos mousex, mousey
		Sleep 50
		WinActivate, Warframe
		WinGetPos, X, Y,,, Warframe
		Sleep 20
		MouseMove X+10, Y+10
		Sleep 20
		Send {Click}
		Sleep 50
		FileRead msgtext, copypastamsg.txt
		Sleep 20
		Send {Blind}{Text} %msgtext%
		sleep 60
		SendInput {enter}
		Sleep 20
		SendInput {Blind}{t}
		Sleep 50
		SendInput {Blind}{BackSpace}
		WinActivate, ahk_id %winid%
		MouseMove mousex, mousey
		BlockInput Off
		Sleep 120050
}
return
