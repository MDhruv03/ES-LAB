	AREA RESET, DATA, READONLY
	EXPORT __Vectors
__Vectors
	DCD 0x40001000
	DCD Reset_Handler
	ALIGN
	AREA mycode, CODE, READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
        LDR    R0, =HEX_NUM
        LDR    R1, [R0]  		; Load byte (8-bit) into R1
		LDR    R2, [R0] 
		

        ; Extract high nibble (bits 7-4)
        LSR R2, #4      ; high nibble in R2

        ; Extract low nibble (bits 3-0)
        AND     R3, R1, #0xF        ; low nibble in R3

        ; Convert high nibble to ASCII
        CMP     R2, #9
        ADDLS   R2, #0x30       ; if nibble <= 9 add '0'
        ADDHI   R2, #0x37       ; else add 'A'-10

        ; Convert low nibble to ASCII
        CMP     R3, #9
        ADDLS   R3, #0x30       ; if nibble = 9 add '0'
        ADDHI   R3, #0x37       ; else add 'A'-10

        ; Pack high nibble ASCII into high byte, low nibble ASCII into low byte
        MOV     R4, R2, LSL #8       ; shift high ASCII left by 8 bits
        ORR     R4, R4, R3           ; combine with low ASCII

        ; Store packed 16-bit ASCII word into memory
        LDR     R5, = ASCII_WORD
        STRH    R4, [R5]             ; store halfword (16 bits)
STOP B STOP
HEX_NUM     DCD     0x6A          ; Example 2-digit hex number (0x3F)
        AREA data, DATA, READWRITE
ASCII_WORD  DCD  0    ; space for packed ASCII word
	END
