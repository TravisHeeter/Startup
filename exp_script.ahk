#SingleInstance force
#Include C:\ahk_scripts\ahk_utils\ahk_utilities.ahk
#NoEnv

F4::
  ;If !WinExist("ahk_class CabinetWClass")
  ;  Run, %systemroot%\explorer.exe
  ;Else If WinActive("ahk_class CabinetWClass")
  ;  WinMinimize
  ;Else
  ;  WinActivate, ahk_class CabinetWClass

  WinSwap("ahk_class CabinetWClass", "C:\Windows\explorer.exe")
return

!^+F4::  ;{ Rescript GitBash
  Rescript("exp")
return
