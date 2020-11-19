#SingleInstance force
#Include C:\ahk_scripts\ahk_utils\chrome_functions.ahk

SetTitleMatchMode, 2  ; Contains

F1:: WinSwap("Google Chrome", ChromeEXE)  ; Switch to Chrome, between Chrome windows or open a new Chrome window if one doesn't exist
!F1:: WinSwapMin("Google Chrome", "ahk_exe chrome.exe", ChromeEXE) ; Same as F1, but minimizes the window between switching

^+!F1:: Rescript("chrome") ; Rescript Chrome
^+2:: LaunchTimeSheet()  ; Timesheet
^!s:: ChromeStartup() ; Startup Script for Chrome

!z:: LaunchSite()
!x:: LaunchSite("DMIsso")
!c:: LaunchSite("DMTM")
