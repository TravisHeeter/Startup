#SingleInstance force
#Include C:\ahk_scripts\ahk_utils\ahk_utilities.ahk
#NoEnv
SetTitleMatchMode, 2  ; Contains

F1:: ;{ Switch to Chrome, between Chrome windows or open a new Chrome window if one doesn't exist
  WinSwap("Google Chrome", "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")
return

!F1:: ;{ Same as F1, but minimizes the window between switching
  WinSwapMin("Google Chrome", "ahk_exe chrome.exe", "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")
return

^+!F1::  ;{ Rescript Chrome
  Rescript("chrome")
return

RunPhoenixUser(User:="DMAnalyst",Screen:="Full"){
  GoToPhoenix(User,Screen)
  Sleep, 1000
;  Tester(Screen)
}

!d:: ;{ Run Phoenix as Analyst
!z::
  RunPhoenixUser()
return
!i::  ;{ Run Phoenix as ISSO
!x::
  RunPhoenixUser("DMIsso")
return
!t::  ;{ Run Phoenix as a Triage Manager
!c::
  RunPhoenixUser("DMTM")
return




; ================ Functions =================

; ===================================================
; Click Phoenix Buttons
; Used to click login, scroll down, then the consent button, this is what you need to do each time Phoenix is reloaded
; Opperates for different browser sizes:
  ; Full (default), which is the monitor's normal size;
  ; Small, which is 1440x990;
  ; Laptop, which is the laptop screen size - but that hasn't been coded yet.
  ; Windowed : The Screen is full, but the browser window is inthe upper-righ t corner of the screen
; ===================================================
ClickPhoenixButtons(Rest:=2000,Screen:="Full",DockedDevTools:="true"){
  ; When the app starts after a full reload, it takes a little longer.
  WinActivate, DSOS 3.0
  Sleep, %Rest%

  ; X,Y coordinates for the FULL sized monitor screen
  LoginCoords := [2491,176]    ; x,y coords of the login button
  ConsentCoords := [1254,809]  ; coords of the consent button when chome dev tools are docked in the lower part of the browser

  if(DockedDevTools = "false")
    ConsentCoords := [1239,918]

  If(Screen == "Small"){
    LoginCoords := [1513,186]
    ConsentCoords := [758,715]
  }Else If(Screen == "Laptop"){
    LoginCoords := [1513,186]
    ConsentCoords := [758,715]
  }Else If(Screen == "Windowed"){
    LoginCoords := [1200,180]
    ConsentCoords := [600,800]
  }Else If(Screen == "Quarter"){
    LoginCoords := [1200,184]
    ConsentCoords := [602,519]
  }Else If(Screen != "Full"){
    WrongParameter("Screen", "ClickPhoenixButtons", "chrome_script", Screen, ["Full", "Small", "Laptop"])
    return
  }

  Crest(LoginCoords,,3000)
  Send, {WheelDown 10}
  Sleep, 2000
  Crest(ConsentCoords)
}

 ; { Open a new Chrome incognito window, navigate to phoenix
GoToPhoenix(User:="Org23TM",Screen:="Full"){
  ; Try to activate DSoS
  SetTitleMatchMode, 2  ; Contains
  WinActivate, DSOS 3.0
  Sleep, 1000

  ; If there is already a DSoS window, close it.
  If WinActive(DSOS 3.0) {
    WinClose
    ; Refresh the page
    ;Send, {F5}
    ;Sleep, 6800
  } ;Else {

    ; Open a new incognito window to phoenix
    Run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe -incognito https://localhost:8081/phoenix/
    Sleep, 2000

    SelectUser(User)

    ; Maximize the window
    Sleep, 1000
    WinActivate, DSOS 3.0
    Sleep, 1000
    WinMaximize, DSOS 3.0
    Sleep, 4000

    ; Open dev tools
    Send {F12}
    Sleep, 3000
  ;}

  ClickPhoenixButtons(7000,Screen,false)
}

Tester(Screen:="Full"){
; Go To First Case
  if(Screen = "Full"){
    ; Crest(449,230) ; Cases
    Crest(525,225) ; RFIs
    ; Crest(587,486) ; Click the Case
    ; Crest(256,440) ; Click the RFI
  } Else If(Screen = "Windowed"){
    ;Crest(233,168)  ; Cases
    ;Crest(367,406)  ; First Case
  } Else If(Screen = "Quarter"){

  } Else
    Crest(400,228)

  ; Go to the workbook section
  ;Send, {WheelDown 10}
  ;CreateNewCase()
}

CreateNewCase(){
  Crest(2350,218) ; New case button
  Crest(524,558)  ; Incident date input
  Seep("{Enter}") ; Accept default datetime
  Crest(1100,800) ; Incident desc
  FormatTime, dt,, dd-MM-yy HH:mm:ss
  crntvar:=crnt
  ttp:="Testing " crntvar " - " dt
  Seep(ttp)       ; Incident desc
  Seep("{Tab 4}{Enter}{Down 1}{Enter}") ; Responsible Org
  Seep("{Tab 3}{Enter}{Down 1}{Enter}") ; Triage Level
  Seep("{Tab}{Esc}{Tab}{Esc}{Tab}{Tab}Testing") ; Actions to Date
  Seep("{Tab 19}{Enter}") ; Report Thresholds
  Seep("{Tab 20}Richmond") ; City
  Seep("{Tab}v") ; State
  Seep("{Tab 3}{Enter}", 3000) ; Lookup Person Button
  Seep("{Tab}H") ; Last name
  Seep("{Down}{Enter}") ; Autofill name
  Seep("{Tab 2}{Enter}", 6000) ; Find Person
  Crest(1244,494) ; Click to normalize tab distance
  Seep("{Tab 1}{Enter}", 2000) ; Select First Person
  Seep("{Tab 7}{Enter}") ; Accept Person
}

!^+a::
  Seep("{Tab 2}{Enter}", 3000) ; Lookup Person Button

return

; ================ Keybinds =================

; Alt + Shift + T
+!T::Tester()  ; Tester

; Shift + F1
+F1::GoToPhoenix()  ; Go To Phoenix


+F3:: ;{Click Phoenix Buttons
  ClickPhoenixButtons()
return

; Ctrl + Shift + F1
^+F1:: ;{ reload phoenix and press buttons
  ; Refresh the webpage
  Send, {F5}
  Sleep, 5000

  ClickPhoenixButtons()
return

; ===================================================
;Shift + F2 => TIMESHEETS
; ===================================================
+F2:: ;{ Timesheets
  NewTab("https://te.novetta.com/cpweb/masterPage.htm#A0")

  Sleep, 3000

  ; Click Login to go to Novetta login page
  Crest(923,758,3000)

  ; On the Novetta Login page - username should already be filled out,
  ; click the password input box.
  Crest(1179,747)

  ; Clicking the passowrd input box should bring up an auto-login option,
  ; click the option to autofill passowrd.
  Crest(1216,789)

  ; Click the sign-in button
  Crest(1287,846)

  ; Click the Answer input box
  Crest(1289,658)
  Send, Jacob Marley

  ; Click confirm
  Crest(1201,737)
return

; Ctrl + Alt + S => Startup Script
^!s:: ;{ Startup Script for Chrome
  ; Open Chrome, wait for loading, maximize window
  NewTab("https://mail.google.com")
  WinMaximize

  ; =========================================================================
    ; MATTERMOST
  ; -------------------------------------------------------------------------
    NewTab("http://mattermost.dev.ditmac.mil/dsos/channels/3_0_development")
    ; No need to login, you're auto-logged in unless something went wrong.

  ; =========================================================================
    ; JIRA
  ; -------------------------------------------------------------------------
    NewTab("http://jira.dev.ditmac.mil:8080/secure/Dashboard.jspa")

    ; Click on the login input
    Crest(1533,329)

    ; Activate the autofill
    Seep("t")

    Crest(1568,381)      ; Autofill Credentials
    Crest(1562,496,2000) ; Login Button
    Crest(434,152,3000)  ; Projects Drop-down
    Crest(434,238,2000)  ; PHOEN Project

  ; =========================================================================
    ; GIT LAB
  ; -------------------------------------------------------------------------
    NewTab("http://gitlab.dev.ditmac.mil/",3000)

    Crest(1764,269)  ; Close Message
    Crest(1558,334)  ; Standard login
    Crest(1432,415)  ; Username
    Crest(1444,469)  ; Credentials
    Crest(1562,590,3000)  ; Login Button
    Crest(809,370)   ; Project


  ; =========================================================================
    ; NOVETTA GMAIL
  ; -------------------------------------------------------------------------
    ; Ctrl + One activates the first tab, Gmail
    Send ^1
    Sleep, 3000

    ; Flash Support Warning dismissal - only happens on first launch after system reset
    ;Click, 2545, 139
    ;Sleep, 1000

    Crest(2529,151,2000)  ; Account Icon
    Crest(2222,460,2000)  ; theeter@novetta.com


  ; =========================================================================
    ; WORK DRIVE FOLDER & COMMON
  ; -------------------------------------------------------------------------
    newTab("https://drive.google.com/drive/u/0/folders/1i4wbSXY6S2YePJoHJr3q-FIpDc1tYaf4")
    newTab("https://docs.google.com/document/d/1Yb14-Oodm0ZeWvtnP40RgElsF-eSGfSQqNrgo6h1ICs/edit")
return

; ==========
