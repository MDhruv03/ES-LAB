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
	LDR R0, =ARRAY          ; pointer to start of array
	LDR R1, =ARRAY_END      ; pointer just past end of array

	SUB R1, R1, #4          ; point to last element (ARRAY_END - 4)
	
Loop_Reverse
	CMP R0, R1              ; while start pointer < end pointer
	BGE Done_Reverse

	; Swap values at R0 and R1
	LDR R2, [R0]            ; load value at start
	LDR R3, [R1]            ; load value at end

	STR R3, [R0]            ; store end value at start
	STR R2, [R1]            ; store start value at end

	ADD R0, R0, #4          ; move start pointer forward
	SUB R1, R1, #4          ; move end pointer backward

	B Loop_Reverse

Done_Reverse
	B Done_Reverse          ; infinite loop here to stop

	AREA data, DATA, READWRITE
ARRAY
	DCD 1,2,3,4,5,6,7,8,9,10
ARRAY_END

	END
