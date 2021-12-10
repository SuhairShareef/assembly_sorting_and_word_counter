; == EXIT ==
; Exits the program
EXIT MACRO
         MOV AH, 4CH    ; End of program
         INT 21H
ENDM
