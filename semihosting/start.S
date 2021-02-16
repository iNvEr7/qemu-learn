.section .start
.global _start
_start:
    ldr sp, =__stack_end__
    bl main
loop:
    b loop
