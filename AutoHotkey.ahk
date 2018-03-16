; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one ahk file simultaneously and each will get its own tray icon.

; SAMPLE HOTKEYS: Below are two sample hotkeys.  The first is Win+Z and it
; launches a web site in the default browser.  The second is Control+Alt+N
; and it launches a new Notepad window (or activates an existing one).  To
; try out these hotkeys, run AutoHotkey again, which will load this file.

;#z::Run www.autohotkey.com
;
;^!n::
;IfWinExist Untitled - Notepad
;	WinActivate
;else
;	Run Notepad
;return

; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.

; help
; keylist: https://autohotkey.com/docs/KeyList.htm
; # win, + shift, ! alt, ^ ctrl

;;;; autohotkey ;;;;
!+a::Reload ; reload

;;;; browsers ;;;;

#c::Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
#+c::Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --incognito
#x::Run "C:\Program Files (x86)\Mozilla Firefox\firefox.exe"
#i::Run C:\Program Files\Internet Explorer\iexplore.exe

;;;; code editors ;;;;

#v::Run "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\devenv.exe"
;#q::Run C:\Program Files\Microsoft SQL Server\90\Tools\Binn\VSShell\Common7\IDE\SqlWb.exe
#s::
	sel := Explorer_GetSelected()
	sel := RegExReplace(sel, "^", """")
	sel := RegExReplace(sel, "$", """")
	Run, SciTE %sel%
	Return
;;;; files ;;;;
#g::Run SciTE "%homepath%/.gitconfig"
#k::Run SciTE "%homepath%/Documents/AutoHotkey.ahk"

;;;; misc applications ;;;;

#w::Run "c:\Program Files (x86)\Winamp\winamp.exe"
#m::
	sel := Explorer_GetSelected()
	loopcount = 0
	Loop, parse, sel, `n, `r
	{
		Run, "C:\Program Files\MPC-HC\mpc-hc64.exe" `"%A_LoopField%`"
		loopcount++
	}
	if (loopcount == 0)
	{
		Run, "C:\Program Files\MPC-HC\mpc-hc64.exe"
	}
	Return
;#b::Run "C:\Program Files\Git\git-bash.exe", "%homepath%"
#b::Run "C:\Program Files\Git\git-bash.exe"

;;;; laptop ;;;;
PrintScreen::AppsKey
#PrintScreen::PrintScreen

;;;; mouse (sculpt ergo) ;;;;
;WheelLeft::Browser_Back
;WheelRight::Browser_Forward
RWin::Browser_Forward

;;;; helpers ;;;;

; see https://autohotkey.com/board/topic/60985-get-paths-of-selected-items-in-an-explorer-window/
Explorer_GetPath(hwnd="")
{
	if !(window := Explorer_GetWindow(hwnd))
		return
	if (window="desktop")
		return A_Desktop
	path := window.LocationURL
	path := RegExReplace(path, "ftp://.*@","ftp://")
	StringReplace, path, path, file:///
	StringReplace, path, path, /, \, All 
	
	; thanks to polyethene
	Loop
		If RegExMatch(path, "i)(?<=%)[\da-f]{1,2}", hex)
			StringReplace, path, path, `%%hex%, % Chr("0x" . hex), All
		Else Break
	return path
}
Explorer_GetAll(hwnd="")
{
	return Explorer_Get(hwnd)
}
Explorer_GetSelected(hwnd="")
{
	return Explorer_Get(hwnd,true)
}

Explorer_GetWindow(hwnd="")
{
	; thanks to jethrow for some pointers here
	WinGet, process, processName, % "ahk_id" hwnd := hwnd? hwnd:WinExist("A")
	WinGetClass class, ahk_id %hwnd%
	
	if (process!="explorer.exe")
		return
	if (class ~= "(Cabinet|Explore)WClass")
	{
		for window in ComObjCreate("Shell.Application").Windows
			if (window.hwnd==hwnd)
				return window
	}
	else if (class ~= "Progman|WorkerW") 
		return "desktop" ; desktop found
}
Explorer_Get(hwnd="",selection=false)
{
	if !(window := Explorer_GetWindow(hwnd))
		return
	if (window="desktop")
	{
		ControlGet, hwWindow, HWND,, SysListView321, ahk_class Progman
		if !hwWindow ; #D mode
			ControlGet, hwWindow, HWND,, SysListView321, A
		ControlGet, files, List, % ( selection ? "Selected":"") "Col1",,ahk_id %hwWindow%
		base := SubStr(A_Desktop,0,1)=="\" ? SubStr(A_Desktop,1,-1) : A_Desktop
		Loop, Parse, files, `n, `r
		{
			path := base "\" A_LoopField
			IfExist %path% ; ignore special icons like Computer (at least for now)
				ret .= path "`n"
		}
	}
	else
	{
		if selection
			collection := window.document.SelectedItems
		else
			collection := window.document.Folder.Items
		for item in collection
			ret .= item.path "`n"
	}
	return Trim(ret,"`n")
}
