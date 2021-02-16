.section .reset
.global Reset_Handler
Reset_Handler:

    // set SP to end of RAM 
    ldr sp, =__StackTop

    // copy .data section
    ldr	r1, =__etext
    ldr	r2, =__data_start__
    ldr	r3, =__data_end__
.data_loop:
    cmp	r2, r3
    ittt	lt
    ldrlt	r0, [r1], #4
    strlt	r0, [r2], #4
    blt	.data_loop

    bl _start
    b .
