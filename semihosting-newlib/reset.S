.section .reset
.global Reset_Handler
Reset_Handler:

    // set SP to end of RAM 
    ldr sp, =__StackTop

    // clear .bss section
    ldr r0, =__bss_start__
    ldr r1, =__bss_end__
    mov r2, #0
bss_cmp:
    cmp r0, r1
    bge bss_done
    str r2, [r0]
    add r0, #4
    b bss_cmp
bss_done:


    // copy .data section
    ldr r0, =__data_start__
    ldr r1, =__data_end__
    ldr r2, =__etext
data_cmp:
    cmp r0, r1
    bge data_done
    ldr r3, [r2]
    str r3, [r0]
    add r0, #4
    add r2, #4
    b data_cmp
data_done:

    bl _start
    b .
