/*
 * Kernel Linker Script
 * Defines memory layout for the kernel
 */

ENTRY(kernel_main)

SECTIONS
{
    /* Kernel loaded at 32KB (0x8000) by bootloader */
    . = 0x8000;

    .text : ALIGN(4K)
    {
        *(.text)
    }

    .rodata : ALIGN(4K)
    {
        *(.rodata)
    }

    .data : ALIGN(4K)
    {
        *(.data)
    }

    .bss : ALIGN(4K)
    {
        *(COMMON)
        *(.bss)
    }
}
