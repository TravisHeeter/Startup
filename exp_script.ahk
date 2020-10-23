#SingleInstance force
#Include C:\ahk_scripts\ahk_utilities.ahk
#NoEnv

F4::
  ;If !WinExist("ahk_class CabinetWClass")
  ;  Run, %systemroot%\explorer.exe
  ;Else If WinActive("ahk_class CabinetWClass")
  ;  WinMinimize
  ;Else
  ;  WinActivate, ahk_class CabinetWClass

  WinSwap("ahk_class CabinetWClass", "%systemroot%\explorer.exe")
return
