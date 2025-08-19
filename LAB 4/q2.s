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
	LDR R0, =BCD_INPUT      ; pointer to BCD input
	LDR R1, [R0]            ; load BCD number into R1 (only low byte used)
	
	; Extract high nibble (tens digit)
	MOV R2, R1, LSR #4      ; R2 = high nibble (tens)
	
	; Extract low nibble (units digit)
	AND R3, R1, #0xF        ; R3 = low nibble (units)
	
	; Convert BCD tens to decimal value = tens * 10
	; Since no multiply instruction, use shift and add:
	; tens * 10 = (tens * 8) + (tens * 2)
	
	LSL R4, R2, #3          ; R4 = tens * 8
	ADD R4, R4, R2, LSL #1  ; R4 = R4 + (tens * 2) = tens * 10
	
	; Add units digit
	ADD R4, R4, R3          ; R4 = decimal equivalent (hex output)
	
	; Store result
	LDR R0, =HEX_RESULT
	STR R4, [R0]

STOP B STOP

BCD_INPUT DCD 0x42        ; Example BCD input (42 decimal)
	AREA data, DATA, READWRITE
HEX_RESULT DCD 0

	END
