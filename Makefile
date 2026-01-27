# Project Lumen Makefile

# Directories
BUILD_DIR = build
BOOT_DIR = boot
KERNEL_DIR = kernel
DRIVERS_DIR = drivers
USERLAND_DIR = userland

# Output files
BOOTLOADER = $(BUILD_DIR)/boot/bootloader.bin
KERNEL = $(BUILD_DIR)/kernel/kernel.bin
ISO = $(BUILD_DIR)/lumen.iso

# Tools
ASM = nasm
CC = gcc
LD = ld

# Check if cross-compiler exists
ifeq ($(shell which i686-elf-gcc 2>/dev/null),)
    CC = gcc
    LD = ld
else
    CC = i686-elf-gcc
    LD = i686-elf-ld
endif

# Flags
ASM_FLAGS = -f bin
CC_FLAGS = -m32 -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-pie -fno-stack-protector
LD_FLAGS = -m elf_i386 -T $(KERNEL_DIR)/linker.ld --oformat binary

# QEMU options
QEMU = qemu-system-i386
QEMU_FLAGS = -cdrom $(ISO)
RAM ?= 256M

# Source files
KERNEL_C_SOURCES = $(wildcard $(KERNEL_DIR)/*.c)
KERNEL_ASM_SOURCES = $(wildcard $(KERNEL_DIR)/*.asm)
KERNEL_OBJECTS = $(patsubst $(KERNEL_DIR)/%.c, $(BUILD_DIR)/kernel/%.o, $(KERNEL_C_SOURCES))
KERNEL_OBJECTS += $(patsubst $(KERNEL_DIR)/%.asm, $(BUILD_DIR)/kernel/%.o, $(KERNEL_ASM_SOURCES))

# Default target
.PHONY: all
all: $(ISO)

# Create directories
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)/boot
	mkdir -p $(BUILD_DIR)/kernel
	mkdir -p $(BUILD_DIR)/iso/boot/grub

# Build bootloader
$(BOOTLOADER): $(BOOT_DIR)/bootloader.asm | $(BUILD_DIR)
	$(ASM) $(ASM_FLAGS) $< -o $@

# Build kernel object files
$(BUILD_DIR)/kernel/%.o: $(KERNEL_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CC_FLAGS) -c $< -o $@

$(BUILD_DIR)/kernel/%.o: $(KERNEL_DIR)/%.asm | $(BUILD_DIR)
	$(ASM) -f elf32 $< -o $@

# Link kernel
$(KERNEL): $(KERNEL_OBJECTS) | $(BUILD_DIR)
	$(LD) $(LD_FLAGS) -o $@ $^

# Create ISO
$(ISO): $(BOOTLOADER) $(KERNEL) | $(BUILD_DIR)
	mkdir -p $(BUILD_DIR)/iso/boot/grub
	cp $(KERNEL) $(BUILD_DIR)/iso/boot/kernel.bin
	echo 'set timeout=0' > $(BUILD_DIR)/iso/boot/grub/grub.cfg
	echo 'set default=0' >> $(BUILD_DIR)/iso/boot/grub/grub.cfg
	echo 'menuentry "Project Lumen" {' >> $(BUILD_DIR)/iso/boot/grub/grub.cfg
	echo '    multiboot /boot/kernel.bin' >> $(BUILD_DIR)/iso/boot/grub/grub.cfg
	echo '    boot' >> $(BUILD_DIR)/iso/boot/grub/grub.cfg
	echo '}' >> $(BUILD_DIR)/iso/boot/grub/grub.cfg
	grub-mkrescue -o $(ISO) $(BUILD_DIR)/iso 2>/dev/null || \
		(dd if=/dev/zero of=$(ISO) bs=1M count=10 && \
		dd if=$(BOOTLOADER) of=$(ISO) conv=notrunc && \
		dd if=$(KERNEL) of=$(ISO) seek=1 conv=notrunc)

# Individual build targets
.PHONY: bootloader
bootloader: $(BOOTLOADER)

.PHONY: kernel
kernel: $(KERNEL)

.PHONY: iso
iso: $(ISO)

# Run in QEMU
.PHONY: run
run: $(ISO)
	$(QEMU) $(QEMU_FLAGS) -m $(RAM)

# Run with serial output
.PHONY: run-debug
run-debug: $(ISO)
	$(QEMU) $(QEMU_FLAGS) -m $(RAM) -serial stdio

# Run with GDB debugging
.PHONY: debug
debug: $(ISO)
	$(QEMU) $(QEMU_FLAGS) -m $(RAM) -serial stdio -s -S

# Clean build artifacts
.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)/boot $(BUILD_DIR)/kernel

# Clean everything including ISO
.PHONY: distclean
distclean:
	rm -rf $(BUILD_DIR)

# Help
.PHONY: help
help:
	@echo "Project Lumen Build System"
	@echo ""
	@echo "Targets:"
	@echo "  all         - Build everything (default)"
	@echo "  bootloader  - Build bootloader only"
	@echo "  kernel      - Build kernel only"
	@echo "  iso         - Create bootable ISO"
	@echo "  run         - Run in QEMU"
	@echo "  run-debug   - Run in QEMU with serial output"
	@echo "  debug       - Run in QEMU with GDB server"
	@echo "  clean       - Remove build artifacts"
	@echo "  distclean   - Remove all build files including ISO"
	@echo "  help        - Show this help message"
	@echo ""
	@echo "Options:"
	@echo "  RAM=512M    - Set QEMU RAM (default: 256M)"
