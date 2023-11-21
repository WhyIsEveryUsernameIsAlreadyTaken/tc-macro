#SingleInstance Force
#Persistent
#NoEnv
#KeyHistory 0
#MaxHotkeysPerInterval 9999999
#HotkeyInterval 9999999
#MaxThreads 255
ListLines, Off
SetBatchLines -1
SetKeyDelay, -1
SetMouseDelay, -1
SetControlDelay, -1
SetWinDelay, -1
SendMode, Input

lSleep(s_time, ByRef start = "") {														; the most accurate sleep function for AHK
    DllCall("QueryPerformanceCounter", "Int64*", CounterBefore)							; create timestamp 
    If (start != "")																	; if start isn't noticed, it will be current time of PC's interal counter of tacts
        CounterBefore := start															;
    Frequency ? Frequency : DllCall("QueryPerformanceFrequency", "Int64*", Frequency)	; check QueryPerformanceCounter's frequency
    If (s_time > 20) {																	; if desired sleep time is more than 20ms
        DllCall("QueryPerformanceCounter", "Int64*", CounterAfter)						; create CounterAfter timestamp
        Sleep % s_time - (1000 * (CounterAfter - CounterBefore) / Frequency) - 20		; calculation of time which will be slept in usual way and will not affect the final sleep time
    }
    End := (CounterBefore + ( Frequency * (s_time/1000))) - 1							; create end point of time for sleep
    Loop {
        DllCall("QueryPerformanceCounter", "Int64*", CounterAfter)						; looped timestamp until desired sleep time won't be reached
        If (End <= CounterAfter)														; if desired sleep time is reached
            Break																		; timestamp's loop breaks
    }
}

clipboardCopy()
{
	clipboard := ""
			centeredToolTip("Clipboard emptied, please copy your desired message", 5000)
			ClipWait, , 0 ; wait indefinitely for the clipboard to contain raw text
			FileDelete copypastamsg.txt
			FileAppend %Clipboard%, copypastamsg.txt
			clipboard := ""
			centeredToolTip("Message copied & script enabled!", 5000)
}
removeToolTip(){
	ToolTip
}

centeredToolTip(text, duration = 1000){
	ToolTip, %text%, A_ScreenWidth/2, A_ScreenHeight/2
	SetTimer, RemoveToolTip, -%duration%
}

file := A_ScriptDir "\copypastamsg.txt"

^j::
	afk := !afk
	if (afk){
		if !FileExist(file)
		{
			clipboardCopy()
		}
		else
		{
			FileGetSize,size,%file%,
			if size = 0
			{
				clipboardCopy()
			}
			else
			{
				MsgBox, 3, tclazy2, Do you want to replace last saved message?
				IfMsgBox Yes
				{
					clipboardCopy()
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
		}
	}
	else {
		centeredToolTip("Off")
	}
	while (afk){
		FileGetSize,size,%file%,
		if !FileExist(file)
		{
			MsgBox, 0, No Storage File Found, Press OK to generate new file and store desired text
			clipboardCopy()
		}
		else
		{
			if size = 0
			{
				MsgBox, 0, Storage File Empty, Press OK to store desired text
				clipboardCopy()
			}
			else
			{
				KeyWait Control
				KeyWait Alt
				KeyWait Tab
				lSleep(50)
				BlockInput On
				WinGet, winid ,, A
				MouseGetPos mousex, mousey
				lSleep(20)
				WinActivate, Warframe
				WinGetPos, X, Y,,, Warframe
				lSleep(20)
				FileRead msgtext, copypastamsg.txt
				lSleep(20)
				Send {Blind}{Text} %msgtext%
				lSleep(20)
				Send {Blind}{enter}
				lSleep(20)
				Send {Blind}{t}
				lSleep(20)
				SendInput {Blind}{BackSpace}
				WinActivate ahk_id %winid%
				MouseMove mousex, mousey
				BlockInput Off
				lSleep(120000)
			}
		}
}
return
