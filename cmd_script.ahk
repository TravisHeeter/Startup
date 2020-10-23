#SingleInstance force
#Include C:\ahk_scripts\ahk_utils\ahk_utilities.ahk
SetTitleMatchMode, 3 ; Exact

!^+F6::  ;{ Resecript CMD - also mapped to !^+e in gitBash
  Rescript("cmd")
return

; IN ORDER TO CHANGE crnt:
; ======= RE-RUN this script ========


;============================================
; Alt + C
; switches to a cmd window if it is not active, if it is active the window gets minimized.
;============================================
F6:: ;{ Switch to, between, or open new cmd if one doesn't exist.
  SetTitleMatchMode, 2 ; Contains
  WinGet, cmd_windows, List, ahk_exe cmd.exe
  If cmd_windows > 0
    WinActivate, % "ahk_id " cmd_windows%cmd_windows%
  Else
    newCmd()
return

newCmd(){ ;{ if an explorer window is open, open a cmd prompt to that location
  if WinActive("ahk_class CabinetWClass")
  or WinActive("ahk_class ExploreWClass")
  {
    WinHWND := WinActive()
    For win in ComObjCreate("Shell.Application").Windows
      If (win.HWND = WinHWND){
        currdir := SubStr(win.LocationURL, 9)
        currdir := RegExReplace(currdir, "%20", " ")
        Break
      }
  }
  Run, cmd, % currdir ? currdir : "C:\"
}

#!c::  ; Reload Case Server - Not sure if it works
  WinClose, "Case Server - PHOENIX"
  SetTitleMatchMode, 3 ; Exact
  WinActivate, C:\Windows\SYSTEM32\cmd.exe
  Send, cd %crnt%\main\common\services
  Send, {Enter}
  Send, mvn clean install -Dmaven.test.skip -e
  Send, {Enter}
  Send, cd %crnt%\main\case-management\
  Send, {Enter}
  Send, mvn clean install -Dmaven.test.skip -e
  Send, {Enter}
  Send, start "Case Server - PHOENIX" java -jar case-management-1.0-SNAPSHOT.jar}
return

;=======================================
; Rebuild Phoenix
;=======================================
!p:: ;{ Rebuild Phoenix
  CloseAllCMDs()

  Run, cmd, c:\
  Sleep, 1000

  ; rerun rebuildPhoenix.bat
  Seep("rebuildPhoenix.bat{Enter}")
return

!c:: ;{ Open a new cmd window to c:\
  Run, cmd, c:\
return

#c:: ;{ Show the value for crnt
  MsgBox, %crnt%
return

#^c:: ;{ Reload cmd_script.ahk - very useful for resetting crnt
  MsgBox, Running
  Run, "C:\Users\theeter\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\cmd_script.ahk"
  MsgBox, %crnt%
return
