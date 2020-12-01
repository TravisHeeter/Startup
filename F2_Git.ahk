#SingleInstance force
#Include C:\ahk_scripts\ahk_utils\F2_Git_Functions.ahk


#F2:: ActivateGitBash()  ; Activate gitBash - dont use WinSwap
!^+F2:: Rescript("git")  ; Rescript GitBash

^F2:: CloneAndFlow()  ; Clone And Flow
+F2:: CloneAndCheckout()  ; Clone and Checkout
!F2:: ChangeCRNT() ; Change %crnt%

; checkBranch runners
!^+w:: CB_CreateGitBranchFile()  ; Generate a txt file of all the available Branches
!^+c:: CB_SelectCheckBranch()  ; Allow User to select which branch to run checkBranch on
!^+d:: CB_DeleteFeatures()  ; Delete any clones created from running checkBranch
