.section .start
.global _start
_start:
    ldr sp, =__stack_end__
    b main
