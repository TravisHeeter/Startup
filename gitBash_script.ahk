#SingleInstance force
#Include C:\ahk_scripts\ahk_utils\ahk_utilities.ahk
#Include C:\ahk_scripts\ahk_utils\git_bash_utils.ahk
#NoEnv

#F2:: ;{ Activate gitBash - dont use WinSwap
  If !WinExist("ahk_exe mintty.exe")
    OpenGbHere()
  Else If WinActive("ahk_exe mintty.exe")
    WinMinimize
  Else
    WinActivate, ahk_exe mintty.exe
return

!^+F2::  ;{ Rescript GitBash
  Rescript("git")
return

;file explorer must 1. be active 2. at the new location 3. no other exp windows can be open.
^F3:: ;{ NEW BRANCH: Clones, sets up flow, changes crnt, resets cmd_script so the rebuild script works
  ; Close git bash if it's open
  If WinExist("ahk_exe mintty.exe")
    WinClose, "ahk_exe mintty.exe"
  Sleep, 1000

  ; Switch to File Exp so we can open GB to that location
  WinActivate, ahk_class CabinetWClass
  Sleep, 1000

  ; Open GB to correct location
  OpenGbHere()
  Sleep, 2000

  ; Activate the gb window just in case
  WinActivate, ahk_exe mintty.exe
  Sleep, 1000

  ; Maximize the window
  WinMaximize, ahk_exe mintty.exe
  Sleep, 1000

  ; Clone
  Seep("git clone http://gitlab.dev.ditmac.mil/ditmac/phoenix.git{Enter}",12000)

  ; Run flow stuff
  Seep("c:/newFlowBranch.bat{Enter}", 20000)

  ; Change dir so you can confirm the correctness of flow
  Seep("cd phoenix/{Enter}")

  ; Close All CMD windows
  CloseAllCMDs()

  ; re-run cmd_script.ahk
  Rescript()

  ; Rebuild with the new clone
  Seep("!p")
return

; Alt + F3  => Change crnt (you still need to rerun cmd_script)
!F3:: ;{ change crnt
  full_path := GetCurrentPath()
  Sleep, 1000

  CloseAllCMDs()

  ; Open new cmd to C:\
  Send, !c
  Sleep, 1000

  Seep("SET crnt=" . full_path . "{Enter}")
  Seep("SETX crnt " . full_path . "{Enter}")

  CloseAllCMDs()
  Sleep, 1000
  Rescript()

  Seep("!p")
return

!^+w::  ; Create Git Branches File
  CreateGitBranchFile()
return

!^+c::  ; Run CheckBranch Selection
  Branches := ReadGitBranchesFromFile()
  Branch := ArrayToDropDown(Branches)
return

!^+d::  ; permanently delete all folders in feature (checkbranch)
  Seep("{F4}")
  Crest(47,422,500)
  Seep("^l")
  Seep("{Tab 3}")
  Seep("^a")
  Seep("+{Del}")
return
