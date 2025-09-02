        AREA RESET, DATA, READONLY
        EXPORT __Vectors
__Vectors
        DCD 0x40001000           ; stack pointer value when stack is empty
        DCD Reset_Handler        ; reset vector
        ALIGN

        AREA mycode, CODE, READONLY
        ENTRY
        EXPORT Reset_Handler

Reset_Handler
       LDR     R0, =list         ; R0 -> source array
        LDR     R1, =sorted       ; R1 -> destination array (copy + sort)
        MOV     R2, #10           ; number of elements (N=10)

; -------- Copy original array into sorted[] --------
copy_loop
        LDR     R3, [R0], #4      ; load element from list and post-increment
        STR     R3, [R1], #4      ; store into sorted and post-increment
        SUBS    R2, R2, #1
        BNE     copy_loop

; -------- Selection Sort --------
        LDR     R1, =sorted       ; reset pointer to sorted array
        MOV     R4, #10           ; outer loop counter (i=0..N-2)

outer_loop
        SUBS    R4, R4, #1        ; decrement outer loop counter
        BEQ     done_sort         ; if 0 -> finished

        LDR     R5, =sorted       ; base address of sorted[]
        MOV     R6, #10           ; N
        SUB     R6, R6, R4        ; R6 = N - outer_count -> i index
        ADD     R5, R5, R6, LSL #2 ; R5 -> arr[i]
        MOV     R7, R5            ; min_index = i

        ; inner loop
        MOV     R8, R6            ; j = i
inner_loop
        ADD     R8, R8, #1
        CMP     R8, #10
        BGE     check_swap

        LDR     R9, =sorted
        ADD     R9, R9, R8, LSL #2 ; R9 -> arr[j]
        LDR     R10, [R9]         ; value at arr[j]

        LDR     R11, [R7]         ; value at min_index
        CMP     R10, R11
        BGE     inner_loop        ; if arr[j] >= arr[min_index], continue
        MOV     R7, R9            ; else min_index = j
        B       inner_loop

check_swap
        CMP     R7, R5            ; if min_index == i, no swap
        BEQ     outer_loop

        ; swap arr[i] <-> arr[min_index]
        LDR     R9, [R5]
        LDR     R10, [R7]
        STR     R10, [R5]
        STR     R9, [R7]

        B       outer_loop

done_sort
stop    B       stop

list    DCD     9, 8, 7, 6, 5, 4, 3, 2, 1, 0
; -------- Data Section --------
        AREA    SELECTIONSORT_DATA, DATA, READWRITE
sorted  DCD   0,0,0,0,0,0,0,0,0,0       ; space for 10 elements (copy + sort)

        END