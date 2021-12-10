;------------------------------------------------------------
;       Advanced Microprocessor Lab Project                 |  
;                                                           |
;       Suhair Shareef      171055                          |
;       Leyan Zahida        171078                          |
;------------------------------------------------------------

;------------------------------------------------------------
; Library of macros                                         |
; Contents:                                                 |
;    1) PRINT_STR                                           |
;    2) READ                                                |
;    3) PRINT                                               |
;    4) SWAP                                                |
;    5) EXIT                                                |
;------------------------------------------------------------

.MODEL SMALL ; Memory configuration


; ============== MACROS DECLARATIONS ===================

; == SWAP ==
; Print any string by the arguement STRING
PRINT_STR MACRO STRING
              PUSH AX            ; Store AX
              PUSH DX            ; Store DX

              LEA  DX, STRING    ; Load address of string @ DX
              MOV  AH, 09H       ; Load DOS operation
              INT  21H

              POP  DX            ; Restore DX
              POP  AX            ; Restore AX
ENDM

; == READ ==
; Read one character
READ MACRO
         MOV AH, 01H    ; Load DOS operation
         INT 21H
ENDM

; == PRINT ==
; Print one character
PRINT MACRO
          MOV AH, 02H
          INT 21H
ENDM

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

; == EXIT ==
EXIT MACRO
         MOV AH, 4CH    ; End of program
         INT 21H
ENDM


; =====================================================
.STACK 100H ; Stack size in bytes

.data                                                                                                                                  ; Data section
    
    ; Strngs to print
    MENU          DB "What's your choice?",13,10,"1. Array Sorting",13,10,"2. Word Counter",13,10,"3. Exit",13,10,,13,10,,13,10,"$"
    STR1          DB "Enter array's size (LESS THAN 100!): $"
    STR2          DB "Enter array's elements: $"
    STR3          DB "Sorted Array: $"
    ENDL          DB 0AH,0DH,"$"
    
    ; Data to use
    TEN           DB 10
    ARRAY_SIZE    DB 10
    ARRAY_ELEMENT DB 10
    ARRAY         DB 100 DUP(0)
    

    ; =====================================================

.code

; ============== PROSEDURES DECLARATIONS ===================
; == READ_NUMBERS ==
; Reads array elements of two digits from the user
READ_NUMBERS PROC
    ; Read the array size
                  PRINT_STR ENDL
                  PRINT_STR STR1                 ; Prompt the user to enter the array size
                  PRINT_STR ENDL

                  READ                           ; Read the first digit from the left (tens)
                  SUB       AL, '0'
                  MUL       TEN
                  MOV       ARRAY_SIZE, AL

                  READ                           ; Read the second digit from the left (ones)
                  SUB       AL, '0'
                  ADD       ARRAY_SIZE, AL

    ; Read the array elements loop
                  PRINT_STR ENDL
                  PRINT_STR STR2                 ; Prompt the user to enter the elements of the array
                  PRINT_STR ENDL

                  MOV       CH, 0                ; Reset Ch
                  MOV       CL, ARRAY_SIZE       ; Initislize CL to the array size for the loop
                  MOV       SI, 0H

    Loop1:        
                  READ                           ; Read the first digit
                  SUB       AL, '0'
                  MUL       TEN
                  MOV       ARRAY_ELEMENT, AL

                  READ                           ; Read the second digit
                  SUB       AL, '0'
                  ADD       AL, ARRAY_ELEMENT

                  MOV       ARRAY[SI], AL        ; Add the element to the array

                  PRINT_STR ENDL

                  INC       SI                   ; Increment index
                  LOOP      Loop1

                  RET
                 
READ_NUMBERS ENDP

; == PRINT_ARRAY ==
; Prints array elements of two digits from the array ARRAY
PRINT_ARRAY proc

                  PRINT_STR ENDL
                  PRINT_STR STR3
                  PRINT_STR ENDL

                  MOV       Cl, ARRAY_SIZE
                  MOV       SI, 0H               ; First element has 0 index
    LOOP2:        

                  MOV       AH, 0H
                  MOV       AL, ARRAY[SI]
                  DIV       TEN
        
                  MOV       ARRAY[SI], AH
                  MOV       DL, AL
                  ADD       DL, 30H
                  PRINT

                  MOV       DL, ARRAY[SI]
                  ADD       DL, 30H
                  PRINT
                  PRINT_STR ENDL
        
                  INC       SI
                  LOOP      LOOP2

                  RET
PRINT_ARRAY ENDP

    ; == ARRAY_SORT ==
    ; Bubble sort the array stored ARRAY
ARRAY_SORT PROC

    ; initializing for the outer loop
                  MOV       CH, 0H
                  MOV       CL, ARRAY_SIZE
                  MOV       SI, 0H
                  MOV       DI, 0H
                  MOV       AX, 01H
                  DEC       CX

    OUTER_LOOP:   
                  PUSH      CX                   ; Storing for the outer loop
                  MOV       BL, ARRAY[SI]

    ; initializing for the inner loop
                  MOV       CH, 0h
                  MOV       CL, ARRAY_SIZE
                  SUB       CX, AX

    INNER_LOOP:   
                  INC       DI

                  CMP       BL, ARRAY[SI]
                  JL        SKIP_EXCHANGE

                  MOV       DL, ARRAY[DI]        ; Swap elements
                  MOV       ARRAY[DI], BL
                  MOV       ARRAY[SI], DL
                  MOV       BL, DL               ; Store the smallest element in BL
                
    SKIP_EXCHANGE:
                  LOOP      INNER_LOOP
                  INC       AX
                  POP       CX

                  INC       SI
                  MOV       DI, SI

                  LOOP      OUTER_LOOP

                  RET
ARRAY_SORT ENDP

MAIN PROC
    ; Start the program
                  MOV       AX, @DATA
                  MOV       DS, AX

    ; Print the menu
    PrintMenu:    
                  PRINT_STR MENU
    
                  READ                           ; Read option
                  CMP       AL, '1'              ; if input out of range reset
                  JL        PrintMenu

                  CMP       AL, '3'              ; if input out of range reset
                  JG        PrintMenu

                  CMP       AL, '1'              ; Sort array option
                  JE        ArraySORT

                  CMP       AL, '2'              ; Word counter option
                  JE        WordCounter

                  CMP       AL, '3'              ; Exit option
                  EXIT


    ; Sorting
    ArraySORT:    
                  CALL      READ_NUMBERS
                  CALL      ARRAY_SORT
                  CALL      PRINT_ARRAY

                  JMP       PrintMenu
                  PRINT_STR ENDL
                  PRINT_STR ENDL

    ; Word Counter
    WordCounter:  

    Error:


MAIN ENDP
END MAIN
