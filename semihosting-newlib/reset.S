.section .reset
.global Reset_Handler
Reset_Handler:
    ldr sp, =__StackTop
    bl _start
    b .
