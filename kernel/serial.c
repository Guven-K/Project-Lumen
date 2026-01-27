/*
 * Serial Port Driver
 * Used for debugging output
 */

#include "serial.h"

#define PORT 0x3F8   // COM1

// I/O port operations
static inline void outb(uint16_t port, uint8_t val) {
    __asm__ volatile ("outb %0, %1" : : "a"(val), "Nd"(port));
}

static inline uint8_t inb(uint16_t port) {
    uint8_t ret;
    __asm__ volatile ("inb %1, %0" : "=a"(ret) : "Nd"(port));
    return ret;
}

// Initialize serial port
void serial_init(void) {
    outb(PORT + 1, 0x00);    // Disable all interrupts
    outb(PORT + 3, 0x80);    // Enable DLAB (set baud rate divisor)
    outb(PORT + 0, 0x03);    // Set divisor to 3 (lo byte) 38400 baud
    outb(PORT + 1, 0x00);    //                  (hi byte)
    outb(PORT + 3, 0x03);    // 8 bits, no parity, one stop bit
    outb(PORT + 2, 0xC7);    // Enable FIFO, clear them, with 14-byte threshold
    outb(PORT + 4, 0x0B);    // IRQs enabled, RTS/DSR set
}

// Check if transmit is empty
static int serial_is_transmit_empty(void) {
    return inb(PORT + 5) & 0x20;
}

// Write character to serial port
void serial_putchar(char c) {
    while (!serial_is_transmit_empty());
    outb(PORT, c);
}

// Write string to serial port
void serial_print(const char* str) {
    for (size_t i = 0; str[i] != '\0'; i++) {
        serial_putchar(str[i]);
    }
}

// Write string with length to serial port
void serial_write(const char* str, size_t len) {
    for (size_t i = 0; i < len; i++) {
        serial_putchar(str[i]);
    }
}
