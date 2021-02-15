.global _start
_start:
    ldr sp, =#0x40001000
    b main
