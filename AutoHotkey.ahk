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

#z::Run www.autohotkey.com

^!n::
IfWinExist Untitled - Notepad
	WinActivate
else
	Run Notepad
return


; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.

;;;; browsers ;;;;

#c::Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
#+c::Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --incognito
#x::Run "C:\Program Files (x86)\Mozilla Firefox\firefox.exe"
#i::Run C:\Program Files\Internet Explorer\iexplore.exe

;;;; code editors ;;;;

#v::Run "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\devenv.exe"
;#q::Run C:\Program Files\Microsoft SQL Server\90\Tools\Binn\VSShell\Common7\IDE\SqlWb.exe
#s::Run scite
#g::Run SciTE "%homepath%/.gitconfig"

;;;; misc applications ;;;;

#w::Run "c:\Program Files (x86)\Winamp\winamp.exe"
#m::Run "C:\Program Files\MPC-HC\mpc-hc64.exe"
;#b::Run "C:\Program Files\Git\git-bash.exe", "%homepath%"
#b::Run "C:\Program Files\Git\git-bash.exe"

;;;; laptop ;;;;
PrintScreen::AppsKey
#PrintScreen::PrintScreen
