# Project Lumen - Getting Started

Welcome to Project Lumen! This guide will help you get started with the project.

## What is Project Lumen?

Project Lumen is a custom operating system built from scratch with a clean architecture. Unlike many hobby OS projects that use existing kernels (like Linux), Project Lumen has its own custom kernel designed from the ground up.

## Current State

Project Lumen is in **Phase 0** (Foundation) of development. We have:

- ✅ Basic bootloader that loads from BIOS
- ✅ Minimal kernel with VGA text mode output
- ✅ Serial port driver for debugging
- ✅ Build system (Make-based)
- ✅ Comprehensive documentation

## Quick Start

### 1. Install Prerequisites

```bash
# Ubuntu/Debian
sudo apt install build-essential nasm qemu-system-x86 xorriso mtools

# Arch Linux
sudo pacman -S base-devel nasm qemu xorriso mtools
```

### 2. Clone and Build

```bash
git clone https://github.com/Guven-K/Project-Lumen.git
cd Project-Lumen
make all
```

### 3. Run in QEMU

```bash
make run
```

You should see:
```
Project Lumen v0.1
Custom Operating System

Kernel initialized successfully!
Memory manager: Not yet implemented
Process manager: Not yet implemented
Filesystem: Not yet implemented

Welcome to Project Lumen!
This is a minimal kernel. More features coming soon...

System halted.
```

## Project Structure

```
Project-Lumen/
├── boot/              # Bootloader (NASM assembly)
│   └── bootloader.asm # Stage 1 bootloader
│
├── kernel/            # Kernel source code
│   ├── main.c        # Kernel entry point
│   ├── vga.c/h       # VGA text mode driver
│   ├── serial.c/h    # Serial port driver
│   └── linker.ld     # Linker script
│
├── drivers/           # Device drivers (future)
├── userland/          # User applications (future)
│
├── docs/              # Documentation
│   ├── architecture.md  # System architecture
│   ├── roadmap.md      # Development roadmap
│   └── build.md        # Build instructions
│
├── Makefile          # Build system
└── README.md         # Project overview
```

## What Can You Do?

### As a Developer

1. **Explore the Code**: Start with `kernel/main.c` to see the kernel entry point
2. **Read the Architecture**: Check `docs/architecture.md` to understand the design
3. **Check the Roadmap**: See `docs/roadmap.md` for what's coming next
4. **Contribute**: See `CONTRIBUTING.md` for contribution guidelines

### As a Tester

1. **Test in QEMU**: Run `make run-debug` to see serial output
2. **Try Different Configurations**: Adjust RAM with `make run RAM=512M`
3. **Report Issues**: Found a bug? Open a GitHub issue

### Learning OS Development

Project Lumen is a great learning resource:
- Clean, well-documented code
- Real bootloader and kernel code
- Active development with new features being added

## Next Steps

### Phase 1 Goals (v0.1 - Core Kernel)

We're currently working towards v0.1, which will include:
- ✅ Bootloader and basic kernel _(Done)_
- [ ] Memory management (physical and virtual)
- [ ] Basic process management
- [ ] Interrupt handling
- [ ] Keyboard driver

See `docs/roadmap.md` for the complete plan.

## Common Commands

```bash
# Build everything
make all

# Build only bootloader
make bootloader

# Build only kernel
make kernel

# Run in QEMU
make run

# Run with debugging output
make run-debug

# Debug with GDB
make debug

# Clean build files
make clean

# Clean everything including ISO
make distclean

# Show help
make help
```

## Debugging

### Serial Output

The kernel outputs debugging information via serial port (COM1):

```bash
make run-debug
```

You'll see kernel messages in your terminal.

### GDB Debugging

```bash
# Terminal 1
make debug

# Terminal 2
gdb build/kernel/kernel.bin
(gdb) target remote localhost:1234
(gdb) break kernel_main
(gdb) continue
```

## Getting Help

- **Documentation**: Check the `docs/` folder
- **Issues**: Open a GitHub issue
- **Community**: Join discussions in GitHub Discussions (coming soon)

## Contributing

We welcome contributions! See `CONTRIBUTING.md` for guidelines.

Priority areas:
- Kernel development (memory management, scheduling)
- Driver development (keyboard, mouse, disk)
- Testing on real hardware
- Documentation improvements

## Resources

- [OSDev Wiki](https://wiki.osdev.org/) - Comprehensive OS dev resource
- [Intel Manuals](https://software.intel.com/content/www/us/en/develop/articles/intel-sdm.html) - x86 reference
- [NASM Documentation](https://www.nasm.us/doc/) - Assembly language reference

## License

Project Lumen is open source. License details coming soon.

---

**Ready to dive in?** Start with `docs/architecture.md` to understand the system design!
