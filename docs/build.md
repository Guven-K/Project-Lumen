# Building and Running Project Lumen

## Prerequisites

### Required Tools

#### Ubuntu/Debian
```bash
sudo apt update
sudo apt install -y build-essential nasm qemu-system-x86 xorriso mtools
```

#### Arch Linux
```bash
sudo pacman -S base-devel nasm qemu xorriso mtools
```

#### macOS
```bash
brew install nasm qemu xorriso
brew install i686-elf-gcc  # Cross-compiler
```

#### Windows (WSL2 recommended)
```bash
# In WSL2 Ubuntu
sudo apt update
sudo apt install -y build-essential nasm qemu-system-x86 xorriso mtools
```

### Tool Versions
- **GCC**: 9.0 or higher (or cross-compiler for i686-elf)
- **NASM**: 2.14 or higher
- **QEMU**: 4.0 or higher
- **Make**: 4.0 or higher

### Setting Up Cross-Compiler (Recommended)

For best results, use a cross-compiler targeting i686-elf:

#### Building GCC Cross-Compiler
```bash
# Install dependencies
sudo apt install libgmp-dev libmpfr-dev libmpc-dev

# Download and build binutils
export PREFIX="/usr/local/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"

mkdir -p ~/cross-compiler && cd ~/cross-compiler

# Binutils
wget https://ftp.gnu.org/gnu/binutils/binutils-2.39.tar.xz
tar -xf binutils-2.39.tar.xz
mkdir build-binutils && cd build-binutils
../binutils-2.39/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make
sudo make install
cd ..

# GCC
wget https://ftp.gnu.org/gnu/gcc/gcc-12.2.0/gcc-12.2.0.tar.xz
tar -xf gcc-12.2.0.tar.xz
mkdir build-gcc && cd build-gcc
../gcc-12.2.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
make all-gcc
make all-target-libgcc
sudo make install-gcc
sudo make install-target-libgcc
```

## Building Project Lumen

### Quick Start

```bash
# Clone the repository
git clone https://github.com/Guven-K/Project-Lumen.git
cd Project-Lumen

# Build everything
make all

# Run in QEMU
make run
```

### Build Targets

```bash
# Build bootloader only
make bootloader

# Build kernel only
make kernel

# Build ISO image
make iso

# Clean build artifacts
make clean

# Clean everything including ISO
make distclean
```

### Build Output

The build process creates:
- `build/boot/bootloader.bin` - Bootloader binary
- `build/kernel/kernel.bin` - Kernel binary
- `build/lumen.iso` - Bootable ISO image

## Running in QEMU

### Basic Run

```bash
make run
# or
qemu-system-i386 -cdrom build/lumen.iso
```

### Run with Options

```bash
# Run with 512MB RAM
make run RAM=512M

# Run with serial output
qemu-system-i386 -cdrom build/lumen.iso -serial stdio

# Run with debugging
qemu-system-i386 -cdrom build/lumen.iso -s -S
# Then in another terminal:
# gdb build/kernel/kernel.bin
# (gdb) target remote localhost:1234
```

### QEMU Options Explained

- `-cdrom build/lumen.iso`: Boot from ISO
- `-m 512M`: Allocate 512MB RAM
- `-serial stdio`: Redirect serial output to terminal
- `-s`: Start GDB server on port 1234
- `-S`: Pause at startup (wait for GDB)
- `-enable-kvm`: Use KVM acceleration (Linux only)

### Advanced QEMU Usage

```bash
# Full debugging setup
qemu-system-i386 \
  -cdrom build/lumen.iso \
  -m 512M \
  -serial stdio \
  -d int,cpu_reset \
  -no-reboot \
  -no-shutdown

# Performance testing
qemu-system-i386 \
  -cdrom build/lumen.iso \
  -m 1G \
  -enable-kvm \
  -cpu host \
  -smp 2
```

## Running on Real Hardware

### Creating a Bootable USB

#### Linux
```bash
# Build ISO
make iso

# Write to USB (replace /dev/sdX with your USB device)
sudo dd if=build/lumen.iso of=/dev/sdX bs=4M status=progress
sync
```

#### Windows
1. Download [Rufus](https://rufus.ie/)
2. Select your USB drive
3. Select `build/lumen.iso`
4. Click "Start"

#### macOS
```bash
# Find USB device
diskutil list

# Unmount USB (replace diskN with your device)
diskutil unmountDisk /dev/diskN

# Write ISO
sudo dd if=build/lumen.iso of=/dev/rdiskN bs=4m
```

### BIOS/UEFI Settings

For best results:
- Disable Secure Boot (UEFI systems)
- Enable Legacy Boot or CSM
- Set USB/CD as first boot device

### Tested Hardware

✅ **Working**
- VirtualBox
- VMware Workstation
- QEMU
- Most Intel-based systems

⚠️ **Partial Support**
- Some AMD systems (YMMV)
- Older hardware (pre-2010)

❌ **Not Yet Supported**
- UEFI-only systems (working on it)
- ARM-based systems
- Very new hardware (may need drivers)

## Debugging

### Serial Console

The kernel outputs debugging information via serial port (COM1). To view:

```bash
# QEMU
qemu-system-i386 -cdrom build/lumen.iso -serial stdio

# Real hardware - use a USB-to-serial adapter
# Connect and use screen or minicom:
screen /dev/ttyUSB0 115200
```

### GDB Debugging

```bash
# Terminal 1: Start QEMU with debugging
make debug

# Terminal 2: Connect GDB
gdb build/kernel/kernel.bin
(gdb) target remote localhost:1234
(gdb) break kernel_main
(gdb) continue
```

### Common Issues

#### "No bootable device" Error
- Ensure ISO is properly created: `make iso`
- Check BIOS boot order
- Try different USB port or media

#### QEMU Crashes
- Update QEMU: `sudo apt upgrade qemu-system-x86`
- Try without KVM: Don't use `-enable-kvm`
- Check RAM allocation: Use `-m 256M` or higher

#### Build Errors
- Install all prerequisites
- Use cross-compiler (i686-elf-gcc)
- Clean and rebuild: `make clean && make all`

#### Black Screen
- Check serial output: `qemu-system-i386 -cdrom build/lumen.iso -serial stdio`
- Verify kernel loaded: Look for boot messages
- Try VGA text mode (default)

## Development Workflow

### Recommended Setup

```bash
# 1. Build project
make all

# 2. Run in QEMU with serial output
make run-debug

# 3. Make changes to code

# 4. Rebuild and test
make clean && make all && make run-debug
```

### Live Development

Use `watch` for automatic rebuild:

```bash
# Install entr (optional)
sudo apt install entr

# Auto-rebuild on changes
find kernel/ boot/ -name '*.c' -o -name '*.asm' | entr make all
```

### Testing Checklist

Before committing changes:
- [ ] Code compiles without warnings
- [ ] Boots in QEMU
- [ ] No kernel panics
- [ ] Serial output shows expected messages
- [ ] Tested on real hardware (if possible)

## Performance Tips

### Faster Builds
```bash
# Use parallel make
make -j$(nproc)

# Or set in environment
export MAKEFLAGS="-j$(nproc)"
```

### Faster QEMU
```bash
# Use KVM (Linux only)
qemu-system-i386 -cdrom build/lumen.iso -enable-kvm

# Use TCG with optimizations
qemu-system-i386 -cdrom build/lumen.iso -accel tcg,thread=multi
```

## Next Steps

1. **Explore the Code**: Start with `kernel/main.c`
2. **Read the Docs**: Check `docs/architecture.md`
3. **Join Development**: See `docs/roadmap.md`
4. **Report Issues**: Use GitHub Issues
5. **Contribute**: Submit Pull Requests

## Additional Resources

- [OSDev Wiki](https://wiki.osdev.org/) - Excellent OS development resource
- [QEMU Documentation](https://www.qemu.org/docs/master/)
- [GCC Cross-Compiler Guide](https://wiki.osdev.org/GCC_Cross-Compiler)
- [x86 Assembly Reference](https://www.felixcloutier.com/x86/)

---

**Having trouble?** Open an issue on GitHub or check existing issues for solutions.
