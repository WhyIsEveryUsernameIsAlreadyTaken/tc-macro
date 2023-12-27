#SingleInstance Force
#MaxThreads 255
#Requires AutoHotkey 2.0+ 
#include Lsleep.ahk
ListLines True
SetKeyDelay -1
SetMouseDelay -1
SetControlDelay -1
SetWinDelay -1

global textFileName := "copypastamsg"
global textFilePath := A_WorkingDir . "\" . textFileName . ".txt"
global afk := false
global flip := false

clipboardCopy()
{
	A_Clipboard := ""
			SetTimer ChangeButtonNames, 1
			Result2 := MsgBox("Select number of messages to copy.", "CopyMessages", 3)
			if Result2 = "Yes"
			{
				FileDelete(textFilePath) ; Deletes old storage file before creating new storage file with clipboard contents
				centeredToolTip("Clipboard emptied, please copy your desired message", 5000)
				ClipWait , 0 ; wait indefinitely for the clipboard to contain raw text
				msg1 := A_Clipboard
				A_Clipboard := ""
				msg2 := msg1
				msgfull := msg1 . "`n" . msg2
			}
			else if Result2 = "No"
			{
				FileDelete(textFilePath) ; Deletes old storage file before creating new storage file with clipboard contents
				centeredToolTip("Clipboard emptied, please copy first message", 5000)
				ClipWait , 0 ; wait indefinitely for the clipboard to contain raw text
				msg1 := A_Clipboard
				A_Clipboard := ""
				centeredToolTip("Clipboard emptied, please copy second message", 5000)
				ClipWait , 0 ; wait indefinitely for the clipboard to contain raw text
				msg2 := A_Clipboard
				A_Clipboard := ""
				msgfull := msg1 . "`n" . msg2
			}
			else if Result2 = "Cancel"
			{
				Reload
			}
			ChangeButtonNames()
			{
				if !WinExist("CopyMessages")
					Return
				SetTimer , 0
				WinActivate
				ControlSetText "&1", "Button1"
				ControlSetText "&2", "Button2"
				ControlSetText "&Cancel", "Button3"
			}
			FileAppend msgfull, "copypastamsg.txt"
			centeredToolTip("Message copied & script enabled!", 5000)
}

removeToolTip(){
	ToolTip
}

centeredToolTip(text, duration := 1000){
	ToolTip text, A_ScreenWidth/2, A_ScreenHeight/2
	SetTimer RemoveToolTip, -duration
}

parseMsgs(file)
{
	fullstr := FileRead(file)
	Loop Parse, fullstr, "`n", "`r"
	{
		if A_Index = 1
		{
			text1 := A_LoopField
		}
		if A_Index = 2
		{
			text2 := A_LoopField
		}
	}
	return [text1, text2]
}
	

pasteLoop(boolvar, file, txt1, txt2)
{
	while (boolvar){
		size := FileGetSize(file)
		if !FileExist(file) or size = 0
		{
			MsgBox("Press OK to generate new file and store desired text", "Storage File Empty/Not Found", 0)
			clipboardCopy()
		}
		
		lSleep(100)
		KeyWait "Control" ; KeyWaits are for making sure no keys are pressed down when BlockInput is activated,
		KeyWait "Alt"     ; without this if a key is pressed down when BlockInput is activated, it'll be stuck
		KeyWait "Tab"     ; down and can mess with the message being sent in trade chat
		KeyWait "Space"
		KeyWait "Enter"
		KeyWait "Esc"
		KeyWait "BS"
		KeyWait "Shift"
		BlockInput True ; Blocks user inputs to prevent messing with message being sent into trade chat
		active_id := WinGetID("A") ; Gets the current active window before switching to Warframe window
		MouseGetPos &mousex, &mousey ; Gets the cursor position before switching to Warframe window
		WinActivate "ahk_exe Warframe.x64.exe"
		WinGetPos &X, &Y,,, "ahk_exe Warframe.x64.exe"
		lSleep(20)
		SendInput(flip ? txt2 : txt1)
		global flip := !flip
		lSleep(50)				
		Send("{Blind}{enter}")
		lSleep(50)
		Send("{Blind}{t}") ; Reopens trade chat when in dojo
		lSleep(50)
		SendInput("{Blind}{BackSpace}") ; Removes the t typed when not in dojo
		lSleep(50)
		WinActivate active_id ; Switches back to last active window
		MouseMove mousex, mousey ; places cursor back to last position
		BlockInput False ; Unblocks user inputs
		lSleep(120000)
	}
}

^r::Reload ; Reloads the script, used when going through loading screens in-game

^j::
{
	global afk := !afk
	if (afk){
		if FileExist(textFilePath)
		{
			size := FileGetSize(textFilePath)
			if size = 0
			{
				clipboardCopy()
				allmsgs := parseMsgs(textFilePath)
				pasteLoop(afk, textFilePath, allmsgs[1], allmsgs[2])
			}
			else 
			{
				SetTimer ChangeButtonNames, 1
				Result1 := MsgBox("Do you want to replace last saved message?", "tclazy2", 3)
				if Result1 = "Yes"
				{
					clipboardCopy()
					allmsgs := parseMsgs(textFilePath)
					pasteLoop(afk, textFilePath, allmsgs[1], allmsgs[2])
				}
				else if Result1 = "No"
				{
					allmsgs := parseMsgs(textFilePath)
					centeredToolTip("Script enabled!", 5000)
					pasteLoop(afk, textFilePath, allmsgs[1], allmsgs[2])
				}
				else if Result1 = "Cancel"
				{
					Reload
				}
				ChangeButtonNames()
				{
					if !WinExist("tclazy2")
						Return
					SetTimer , 0
					WinActivate
					ControlSetText "&Replace", "Button1"
					ControlSetText "&Keep", "Button2"
					ControlSetText "&Cancel", "Button3"
				}
			}
		}
		else if !FileExist(textFilePath)
		{
			clipboardCopy()
			allmsgs := parseMsgs(textFilePath)
			pasteLoop(afk, textFilePath, allmsgs[1], allmsgs[2])
		}
	}
return
}
