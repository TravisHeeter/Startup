
; F8::Send !{F4}                      ; close the active window
; F9::Send ^+{TAB}                    ; go to next child window of an MDI window
; F10::Send ^{TAB}                    ; go to prev child window of an MDI window
; F11::Send ^{F4}                     ; close the active child of an MDI window

; PAUSE::Send !{SPACE}n               ; minimize the active window
; `::Send !{TAB}                      ; cool switch

PAUSE::Send !{TAB}                    ; Pause switches between app windows
ScrollLock::Send !+{TAB}              ; Scroll Lock switches backwards through app windows
