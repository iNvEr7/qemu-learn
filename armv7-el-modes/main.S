.section .start
.global _start
_start:
    mrs     r3, cpsr
    bic     r3, r3, #0xf

    orr     r4, r3, #0x2 // irq
    msr     cpsr_c, r4
    ldr     r5, =0x0a717269
    mov     sp, r5

    orr     r4, r3, #0x1 // fiq
    msr     cpsr_c, r4
    ldr     r5, =0x0a717266
    mov     sp, r5
                
    orr     r4, r3, #0x7 // abort
    msr     cpsr_c, r4
    ldr     r5, =0x0a746261
    mov     sp, r5
        
    orr     r4, r3, #0xb // undefined
    msr     cpsr_c, r4
    ldr     r5, =0x0a646e75
    mov     sp, r5
        
    orr     r4, r3, #0xf // system
    msr     cpsr_c, r4
    ldr     r5, =0x0a737973
    mov     sp, r5

    orr     r4, r3, #0x3 // supervisor
    msr     cpsr_c, r4
    ldr     r5, =0x0a637673
    mov     sp, r5

    ldr     r1, =__stack_start__
    mov     r4, #0
    str     r4, [r1, #4]

    orr     r4, r3, #0x2 // irq
    msr     cpsr_c, r4
    str     sp, [r1]
    orr     r4, r3, #0x3
    msr     cpsr_c, r4
    mov     r0, #0x04
    swi     0x123456

    orr     r4, r3, #0x1 // fiq
    msr     cpsr_c, r4
    str     sp, [r1]
    orr     r4, r3, #0x3
    msr     cpsr_c, r4
    mov     r0, #0x04
    swi     0x123456

    orr     r4, r3, #0x7 // abort
    msr     cpsr_c, r4
    str     sp, [r1]
    orr     r4, r3, #0x3
    msr     cpsr_c, r4
    mov     r0, #0x04
    swi     0x123456

    orr     r4, r3, #0xb // undefined
    msr     cpsr_c, r4
    str     sp, [r1]
    orr     r4, r3, #0x3
    msr     cpsr_c, r4
    mov     r0, #0x04
    swi     0x123456

    orr     r4, r3, #0xf // system
    msr     cpsr_c, r4
    str     sp, [r1]
    orr     r4, r3, #0x3
    msr     cpsr_c, r4
    mov     r0, #0x04
    swi     0x123456

    orr     r4, r3, #0x3 // supervisor
    msr     cpsr_c, r4
    str     sp, [r1]
    mov     r0, #0x04
    swi     0x123456

    // exit(233)
    mov     r0, #0x18
    mov     r1, #0
    swi     0x123456

    // should never get here
    b .
