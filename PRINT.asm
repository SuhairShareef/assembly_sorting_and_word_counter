; == PRINT ==
; Print one character
PRINT MACRO
          MOV AH, 02H
          INT 21H
ENDM
