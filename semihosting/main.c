#include <stdint.h>

#define SYS_WRITE0      0x04
#define SYS_READC       0x07
#define SYS_REPORTEXC   0x18

uintptr_t __semi_call(uintptr_t type, uintptr_t arg0);

void main()
{
#if defined(__arm__)
    uintptr_t exit_code = 0x20026;
#else
    uintptr_t exit_block[2] = {0x20026, 0};
    uintptr_t exit_code = (uintptr_t) &exit_block;
#endif

    __semi_call(SYS_WRITE0, (uintptr_t) "Hello World");
    __semi_call(SYS_REPORTEXC, exit_code);
}

uintptr_t __semi_call(uintptr_t type, uintptr_t arg0)
{
#if defined(__arm__)
    register uintptr_t t asm("r0") = type;
    register uintptr_t a0 asm("r1") = arg0;
#ifdef __thumb__
#  define SVC  "svc 0xab"
#else
#  define SVC  "svc 0x123456"
#endif
    asm(SVC : "=r" (t)
        : "r" (t), "r" (a0));
#else
    register uintptr_t t asm("x0") = type;
    register uintptr_t a0 asm("x1") = arg0;
    asm("hlt 0xf000"
        : "=r" (t)
        : "r" (t), "r" (a0));
#endif

    return t;
}
