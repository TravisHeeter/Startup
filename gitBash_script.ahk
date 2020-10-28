#SingleInstance force
#Include C:\ahk_scripts\ahk_utils\ahk_utilities.ahk
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

!+^e::  ;{ Testing auto cmd refresh
  Rescript()

return
