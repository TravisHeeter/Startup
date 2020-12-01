#SingleInstance force
#Include C:\ahk_scripts\ahk_utils\Functions.ahk

F4:: WinSwap("ahk_class CabinetWClass", "C:\Windows\explorer.exe")  ; WinSwap Windows Explorer
!^+F4:: Rescript("exp")  ; Rescript exp_script
