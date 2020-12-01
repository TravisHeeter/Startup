#SingleInstance force
#Include C:\ahk_scripts\ahk_utils\F3_Atom_Functions.ahk

F3::    WinSwap("Atom", AtomExe)  ; WinSwap Atom
!^+F3:: Rescript("atom")          ; Rescript Atom
#!+F3:: CommentPOMs()             ; Comment POMs - Needs Work
