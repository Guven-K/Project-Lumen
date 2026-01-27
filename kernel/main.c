/*
 * Project Lumen Kernel
 * Main kernel entry point
 */

#include "kernel.h"
#include "vga.h"
#include "serial.h"

// Kernel entry point called from bootloader
void kernel_main(void) {
    // Initialize VGA text mode
    vga_init();
    
    // Initialize serial port for debugging
    serial_init();
    
    // Clear screen
    vga_clear();
    
    // Print welcome message
    vga_set_color(VGA_COLOR_LIGHT_GREEN, VGA_COLOR_BLACK);
    vga_print("Project Lumen v0.1\n");
    vga_set_color(VGA_COLOR_WHITE, VGA_COLOR_BLACK);
    vga_print("Custom Operating System\n\n");
    
    serial_print("Project Lumen kernel started\n");
    
    // Print system information
    vga_print("Kernel initialized successfully!\n");
    vga_print("Memory manager: Not yet implemented\n");
    vga_print("Process manager: Not yet implemented\n");
    vga_print("Filesystem: Not yet implemented\n");
    vga_print("\n");
    
    vga_set_color(VGA_COLOR_LIGHT_CYAN, VGA_COLOR_BLACK);
    vga_print("Welcome to Project Lumen!\n");
    vga_set_color(VGA_COLOR_WHITE, VGA_COLOR_BLACK);
    vga_print("This is a minimal kernel. More features coming soon...\n");
    
    serial_print("Kernel initialization complete\n");
    
    // Halt the system
    vga_print("\nSystem halted.\n");
    serial_print("System halted\n");
    
    // Infinite loop
    while(1) {
        __asm__ volatile("hlt");
    }
}
