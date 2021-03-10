MEMORY
{
  flash (rx)  : ORIGIN = 0x00000000, LENGTH = 0x00004000
  ram   (rwx) : ORIGIN = 0x40000000, LENGTH = 0x80000000
}

__stack_size__ = 0x10000;

ENTRY(_start)
SECTIONS
{
    . = 0x0;

    .text :
    {
        KEEP(*(.start))
        *(.text)
    } > flash

    .data :
    {
        *(.data)
    } > ram

    .bss (NOLOAD) :
    {
        *(.bss)
        *(COMMON)
    } > ram

    .stack (NOLOAD) :
    {
        . = ALIGN(8);
        __stack_start__ = .;
        . = . + __stack_size__;
        . = ALIGN(8);
        __stack_end__ = .;
    } > ram
}
