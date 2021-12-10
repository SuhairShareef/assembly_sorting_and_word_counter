; == READ_NUMBERS ==
; Reads array elements of two digits from the user
; Assumes that elements are stored in array ARRAY predefined and has size of ARRAY_SIZE (less than 100)
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
