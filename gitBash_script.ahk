#SingleInstance force
#Include C:\ahk_scripts\ahk_utilities.ahk
#NoEnv

#F2:: ;{ Switch to, between windows of, or create new window of Git Bash if one doesn't exist. And, if File Explorer is open, open Git Bash to that location.
  If !WinExist("ahk_exe mintty.exe")
    OpenGbHere()
  Else If WinActive("ahk_exe mintty.exe")
    WinMinimize
  Else
    WinActivate, ahk_exe mintty.exe
return

; Gets the current path from a file explorer window.
GetCurrentPath()
{
  If !WinActive("ahk_class CabinetWClass"){
    MsgBox, File Explorer is not active. Please open a file explorer window and navigate to a phoenix folder.
    Reload ; Stops this script and reloads it, basically what break should do.
  }
  ; This is required to get the full path of the file from the address bar
  WinGetText, full_path, A

  ; Split on newline (`n)
  StringSplit, word_array, full_path, `n

  ; Find and take the element from the array that contains address
  Loop, %word_array0%
  {
      IfInString, word_array%A_Index%, Address
      {
          full_path := word_array%A_Index%
          break
      }
  }

  ; strip to bare address
  full_path := RegExReplace(full_path, "^Address: ", "")

  ; Just in case - remove all carriage returns (`r)
  StringReplace, full_path, full_path, `r, , all

  return full_path
}

; Opens the Git bash shell in the File Explorer path.
OpenGbHere()
{
    full_path := GetCurrentPath()

    IfInString full_path, \
    {
        Run,  C:\Program Files\Git\git-bash.exe, %full_path%
    }
    else
    {
        Run, C:\Program Files\Git\git-bash.exe --cd-to-home
    }
}

;file explorer must 1. be active 2. at the new location 3. no other exp windows can be open.
^F3:: ;{ Clones Phoenix, sets up flow, changes crnt, resets cmd_script so rebuildPhoenix works
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

  ; Clone phoenix
  Seep("git clone http://gitlab.dev.ditmac.mil/ditmac/phoenix.git{Enter}",12000)

  ; Run flow stuff
  Seep("c:/newFlowBranch.bat{Enter}", 20000)

  ; Change dir ot phoenix so you can confirm the correctness of flow
  Seep("cd phoenix/", 4000)

  ; Reset file exp so crnt updates
  WinClose, ahk_class CabinetWClass
  Sleep, 3000
  Send, {F4}
  Sleep, 3000

  ; Close All CMD windows
  CloseAllCMDs()

  ; ------------------------
  ; re-run cmd_script.ahk
  ; ------------------------
  Send, #Esc
  Sleep, 1000

  ; Rebuild Phoenix with the new clone
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

  ;GroupAdd,ExplorerGroup, ahk_class CabinetWClass
  ;GroupAdd,ExplorerGroup, ahk_class ExploreWClass
  ;WinClose, ahk_group ExplorerGroup
return

!+^e::  ;{ Testing auto cmd refresh
  Seep("{F4}")
  Crest(47, 401)
  Crest(297,265,right=true)
return
