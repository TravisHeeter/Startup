#SingleInstance force
#Include C:\ahk_scripts\ahk_utils\atom_functions.ahk

F3:: WinSwap("Atom", "C:\Users\theeter\AppData\Local\atom\atom.exe")  ; WinSwap Atom
!^+F3:: Rescript("atom")  ; Rescript Atom
#!+F3:: CommentPOMs()     ; Comment POMs - Needs Work
