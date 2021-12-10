; == ARRAY_SORT ==
; Bubble sort the array stored ARRAY
; Assumes data is stored in ARRAY of size ARRAY_SIZE (less than 100)
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
