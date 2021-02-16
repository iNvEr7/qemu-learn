.section .reset
.global Reset_Handler
Reset_Handler:

    // set SP to end of RAM 
    ldr sp, =__StackTop

    // clear .bss section
    ldr	r1, =__bss_start__
    ldr	r2, =__bss_end__
    movs	r0, #0
.bss_loop:
    cmp	r1, r2
    itt	lt
    strlt	r0, [r1], #4
    blt	.bss_loop

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
