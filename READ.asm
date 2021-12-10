; == READ ==
; Read one character
READ MACRO
         MOV AH, 01H    ; Load DOS operation
         INT 21H
ENDM
