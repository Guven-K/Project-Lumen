/*
 * Serial Port Driver Header
 */

#ifndef SERIAL_H
#define SERIAL_H

#include <stddef.h>
#include <stdint.h>

void serial_init(void);
void serial_putchar(char c);
void serial_print(const char* str);
void serial_write(const char* str, size_t len);

#endif // SERIAL_H
