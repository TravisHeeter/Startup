#SingleInstance force
#Include C:\ahk_scripts\ahk_utils\chrome_functions.ahk

SetTitleMatchMode, 2  ; Contains

F1:: WinSwap("Google Chrome", ChromeEXE)  ; WinSwap Chrome
!F1:: WinSwapMin("Google Chrome", "ahk_exe chrome.exe", ChromeEXE) ; WinSwapMin Chrome

^+!F1:: Rescript("chrome")      ; Rescript Chrome
^+2:: LaunchTimeSheet()         ; Timesheet
^!s:: ChromeStartup()           ; Chrome Startup

!z:: LaunchSite("ArmyAnalyst")  ; Launch Army Analyst
!x:: LaunchSite("DMIsso")       ; Launch DM Isso
!c:: LaunchSite("DMTM")         ; Launch DM Triage Manager

!a:: CreateNewCase()            ; Create New Case
!b:: FillSsnDod()               ; Fill SSN & DoD Number
