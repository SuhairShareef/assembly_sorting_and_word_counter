; == PRINT_ARRAY ==
; Prints array elements of two digits from the array ARRAY
; Assumes that elements are stored in array ARRAY predefined and has size of ARRAY_SIZE (less than 100)
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
