; == SWAP ==
; Swap two memory locations values
SWAP MACRO NUM1, NUM2
         PUSH AX          ; Store AX
         PUSH BX          ; Store BL

         MOV  AL, NUM1
         MOV  BL, AL
         MOV  AL, NUM2
         MOV  NUM1, AL
         MOV  NUM2, BL

         POP  BX          ; Restore AX
         POP  AX          ; Restore BL

ENDM
