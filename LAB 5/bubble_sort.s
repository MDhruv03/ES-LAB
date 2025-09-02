
	AREA RESET, DATA, READONLY
	EXPORT __Vectors
__Vectors
	DCD 0x40001000 ; stack pointer value when stack is empty
	DCD Reset_Handler ; reset vector
	ALIGN
	AREA ascend, code, readonly
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	mov r4,#0
	mov r1,#10 ;counter
	ldr r0, =list
	ldr r2, =result
up  ldr r3, [r0,r4]
	str r3, [r2,r4]
	add r4, #04
	sub r1,#01
	cmp r1,#00
	bhi up
	ldr r0, =result
	; inner loop counter
	mov r3, #10
	sub r3, r3, #1
	mov r9, r3 ; R9 contain no of passes
	; outer loop counter
outer_loop
	mov r5, r0
	mov r4, r3 ; R4 contains no of compare in a pass
inner_loop
	ldr r6, [r5], #4
	ldr r7, [r5]
	cmp r7, r6
	 ; swap without swp instruction
	strlt r6, [r5]
	strlt r7, [r5, #-4]
	subs r4, r4, #1
	bne inner_loop
	sub r3, #1
	subs r9, r9, #1
	bne outer_loop
list dcd 0x10,0x05,0x33,0x24,0x56,0x77,0x21,0x04,0x87,0x01
	AREA data1, data, readwrite
result DCW 0,0,0,0,0,0,0,0,0,0
end
