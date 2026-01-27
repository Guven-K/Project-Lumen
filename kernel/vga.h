/*
 * VGA Text Mode Driver Header
 */

#ifndef VGA_H
#define VGA_H

#include <stddef.h>
#include <stdint.h>

#define VGA_MEMORY 0xB8000
#define VGA_WIDTH 80
#define VGA_HEIGHT 25

enum vga_color {
    VGA_COLOR_BLACK = 0,
    VGA_COLOR_BLUE = 1,
    VGA_COLOR_GREEN = 2,
    VGA_COLOR_CYAN = 3,
    VGA_COLOR_RED = 4,
    VGA_COLOR_MAGENTA = 5,
    VGA_COLOR_BROWN = 6,
    VGA_COLOR_LIGHT_GREY = 7,
    VGA_COLOR_DARK_GREY = 8,
    VGA_COLOR_LIGHT_BLUE = 9,
    VGA_COLOR_LIGHT_GREEN = 10,
    VGA_COLOR_LIGHT_CYAN = 11,
    VGA_COLOR_LIGHT_RED = 12,
    VGA_COLOR_LIGHT_MAGENTA = 13,
    VGA_COLOR_YELLOW = 14,
    VGA_COLOR_WHITE = 15,
};

void vga_init(void);
uint8_t vga_make_color(enum vga_color fg, enum vga_color bg);
uint16_t vga_make_entry(char c, uint8_t color);
void vga_set_color(enum vga_color fg, enum vga_color bg);
void vga_clear(void);
void vga_putchar_at(char c, uint8_t color, size_t x, size_t y);
void vga_putchar(char c);
void vga_print(const char* str);
void vga_write(const char* str, size_t len);

#endif // VGA_H
