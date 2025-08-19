	AREA RESET, DATA, READONLY
	EXPORT __Vectors
__Vectors
	DCD 0x40001000          ; stack pointer value when stack is empty
	DCD Reset_Handler       ; reset vector
	ALIGN
	AREA mycode, CODE, READONLY
	ENTRY
	EXPORT Reset_Handler

Reset_Handler
	LDR R0, =HEX_INPUT      ; pointer to hex input
	LDR R1, [R0]            ; load hex number into R1
	
	; Convert hex to BCD without division (no UDIV):
	; Approach: repeated subtraction of 10 to find tens digit

	MOV R2, #0              ; tens = 0
	MOV R3, R1              ; remainder = hex input

Loop_Subtract:
	CMP R3, #10
	BLT Done_Loop           ; if remainder < 10, done
	SUB R3, R3, #10         ; remainder -= 10
	ADD R2, R2, #1          ; tens += 1
	B Loop_Subtract

Done_Loop:
	; Compose BCD result: tens in high nibble, remainder (units) in low nibble
	LSL R2, R2, #4          ; tens << 4
	ORR R4, R2, R3          ; combine tens and units
	
	; Store result
	LDR R0, =BCD_RESULT
	STR R4, [R0]

STOP B STOP

HEX_INPUT DCD 0x2A        ; example hex input (decimal 42)
	AREA data, DATA, READWRITE
BCD_RESULT DCD 0

	END
