.section .start
.global _start
_start:
    // puts(message)
    mov r0, #0x04
    ldr r1, =message
    swi 0x123456

    // exit(233)
    mov r0, #0x18
    mov r1, #233
    swi 0x123456

    // should never get here
    b .

message:
    .asciz "Hello, world.\n"
