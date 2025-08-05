    AREA RESET, DATA, READONLY
    EXPORT __Vectors
__Vectors
    DCD 0x40001000          ; Initial stack pointer
    DCD Reset_Handler       ; Reset vector
    ALIGN

    AREA mycode, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler
Reset_Handler
    LDR R0, =Numbers        ; Load base address of numbers array
    MOV R4, #10             ; Set counter for 10 numbers
    MOV R5, #0              ; Clear sum register R5

Loop_Add
    LDR R1, [R0], #4        ; Load a number from memory, then increment pointer by 4 bytes
    ADDS R5, R5, R1         ; Add loaded number to sum in R5
    SUBS R4, R4, #1         ; Decrement counter
    BNE Loop_Add            ; Loop until all 10 numbers are added

    LDR R2, =Result         ; Load address of result
    STR R5, [R2]            ; Store sum in result variable

Stop
    B Stop                  ; Infinite loop to stop program

    AREA code_data, DATA, READONLY
Numbers
    DCD 0x00000001
    DCD 0x00000002
    DCD 0x00000003
    DCD 0x00000004
    DCD 0x00000005
    DCD 0x00000006
    DCD 0x00000007
    DCD 0x00000008
    DCD 0x00000009
    DCD 0x0000000A

    AREA data, DATA, READWRITE
Result  DCD 0                  ; Reserve space for result
