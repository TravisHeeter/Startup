#SingleInstance force
#Include C:\ahk_scripts\ahk_utils\ahk_utilities.ahk


F3:: ;{ Switch to, between or open new Atom if one doesn't exist.
  WinSwap("Atom", "C:\Users\theeter\AppData\Local\atom\atom.exe")
return

; Alt + F3 is used in gitbash for changing crnt
;!F3:: ;{ Same as F1, but minimizes the window between switching
;  WinSwapMin("Atom", "ahk_exe atom.exe", "C:\Users\theeter\AppData\Local\atom\atom.exe")
;return

; Open the current project, and remove the unneccessary lines from the POM files.
^!+F3:: ;{ Comment POMs; Incomplete
  ; Make sure Atom is active
  Act("Atom","C:\Users\theeter\AppData\Local\atom\atom.exe")

  ; Navigate to the Open Folder Dialog
  Send, ^+O
  Sleep, 1000

  ; Navigate to the current project folder
  Send, ^l
  Sleep, 1000
  Send, %crnt%
  Sleep, 1000

  ; Press Enter to navigate to that Folder
  Send, {Enter}
  Sleep, 1000

  ; Tab to the "Select Folder Button"
  Send, {Tab 7}
  Sleep, 1000
  Send, {Enter}
  Sleep, 5000

  ; Open Fuzzy Find
  Send, ^p
  Sleep, 3000

  ; Open the normal POM file
  Send, pom
  Sleep, 1000
  Send, {Enter}
  Sleep, 1000

  commentOut(61)
  commentOut(64,66)

  Send, ^s
  Sleep, 1000

  ; =========== 2nd POM FIle ===========
  ; Open Fuzzy Find
  Send, ^p
  Sleep, 1000
  Send, pom
  Sleep, 1000

  ; Open the common POM
  Send, {Down 4}
  Sleep, 1000
  Send, {Enter}
  Sleep, 1000

  commentOut(19,20)

  Send, ^s
return

commentOut(start,end:=""){
  ; Go to the line that starts commented out part
  goTo(start)

  ; Enter the start of the comment
  Send, <{!}--
  Sleep, 500

  ; If end is defined, go to that line. Otherwise, assume we're just commenting out one line
  If(end)
    goTo(end)

  ; Go to the end of the line and enter the ending comment
  Send, {End}
  Send, -- ; Atom will autofill the ending comment
  Sleep, 1000
}

goTo(lineNumber){
  Send, ^g
  Sleep, 500
  Send, %lineNumber%
  Sleep, 500
  Send, {Enter}
  Sleep, 500
}

; temp test for manipulating Atom, but atom does not seem to comply most of the time.
^+!\:: ;{ Testing Goto in AHK & Atom
  ; Open the Goto dialog
  Send, ^g
  Sleep, 1000

  ; Go to line 64
  Send, 64
  Sleep, 1000
  Send, {Enter}
  Sleep, 1000

  ; Enter the begining comment block
  Send, {<}{!}--
  Sleep, 1000

  ; Move down 2 lines
  Send, {Down 2}
  Sleep, 1000

  ; Go to the end of the line
  Send, {End}
  Sleep, 1000

  ; Typing two dashes will automatically add the ending commment {>}
  Send, --
  Sleep, 1000

  ; Save the file
  WinMenuSelectItem, "ahk_exe atom.exe", , File, Save
  Sleep, 1000

return
