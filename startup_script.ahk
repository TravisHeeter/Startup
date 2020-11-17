;=============================================;
; startup script = alt+s                      ;
;---------------------------------------------;
; Launches all necessary apps and tabs        ;
; ============================================;

#SingleInstance force
#Include C:\ahk_scripts\ahk_utils\ahk_utilities.ahk


; ALT + s
; Startup Script
!s:: ;{ Starts from a fresh system restart. cmd, Phoenix, Atom, Chrome, SQuirreL

  ; =========================================================================
    ; cmd
  ; -------------------------------------------------------------------------
    ; Build Phoenix
    Seep("!p")

  ; =========================================================================
    ; atom
  ; -------------------------------------------------------------------------
    ; Open Atom
    Seep("{F3}")

    ; Chrome
  ; -------------------------------------------------------------------------
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


  ; =========================================================================
    ; GIT BASH
  ; -------------------------------------------------------------------------
    Send {F2}
    Sleep, 4000
    Send cd $crnt  ; go to the current phoenix directory
    Sleep, 1000
    Send {Enter}
    Sleep, 1000

  ; =========================================================================
    ; FILE EXPLORER
  ; -------------------------------------------------------------------------
    Send {F4}
    Sleep, 1000
    Send ^l
    Send %crnt%
    Send {Enter}

  ; =========================================================================
    ; SQuirreL
  ; -------------------------------------------------------------------------
    ; Open SQuirreL
    Run, C:\SquirrelSQL\squirrel-sql.bat
    Sleep, 5000

    ; Focus it
    SetTitleMatchMode, 2 ; Contains
    WinActivate, SQuirreL

    ; Open connection
    MouseMove, 50,150
    Sleep, 2000
    Click, 2
    Sleep, 3000


    Crest(109,287,4000)  ; Click login
    Crest(275,151)  ; Close Warning
    Crest(107,454)  ; top Alias
    Crest(129,159)  ; SQL tab

return
