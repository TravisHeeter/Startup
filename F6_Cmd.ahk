#SingleInstance force
#Include C:\ahk_scripts\ahk_utils\F6_Cmd_Functions.ahk
SetTitleMatchMode, 3 ; Exact

!^+F6:: RescriptCMD()       ; Resecript CMD - also mapped to !^+e in gitBash
F6::    WinSwapCMD()        ; WinSwapCMD

#!p::   ReloadCaseServer()  ; Reload Case Server - Needs work
!p::    RebuildPhoenix()    ; Rebuild Phoenix

#c::    CmdToC()            ; Open a new cmd window to c:\
#!c::   MsgBox, %crnt%      ; Show the value for crnt
