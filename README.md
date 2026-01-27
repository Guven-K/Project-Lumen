# Project Lumen

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Status](https://img.shields.io/badge/status-early%20development-orange.svg)
![Version](https://img.shields.io/badge/version-0.1--dev-green.svg)

Project Lumen is a clean, Windows-like operating system built from scratch with a custom kernel (not Linux/BSD). Our goal is a modern desktop OS that feels familiar, runs fast, lightweight, and deeply customizable — without bloat, ads, or forced junk.

## ✨ Features (Planned)

- **Custom Kernel**: Built from scratch, not based on Linux or BSD
- **Familiar Interface**: Windows-like desktop experience
- **Lightweight**: Minimal resource usage, fast boot times
- **No Bloat**: Clean system without unnecessary software
- **Privacy Focused**: No telemetry, ads, or forced updates
- **Highly Customizable**: Full control over your system

## 🚀 Current Status

Project Lumen is in **early development** (Phase 0). We currently have:

- ✅ Basic bootloader
- ✅ Minimal kernel with VGA text output
- ✅ Serial port debugging support
- ✅ Project structure and documentation
- 🔄 Working towards v0.1 (Core Kernel)

See [docs/roadmap.md](docs/roadmap.md) for detailed development plans.

## 📚 Documentation

- **[Architecture](docs/architecture.md)** - System architecture, kernel design, driver model, IPC
- **[Roadmap](docs/roadmap.md)** - Development phases, milestones, and v0.1 definition
- **[Build Guide](docs/build.md)** - How to build and run Project Lumen in QEMU

## 🛠️ Quick Start

### Prerequisites

```bash
# Ubuntu/Debian
sudo apt install build-essential nasm qemu-system-x86 xorriso mtools

# Arch Linux
sudo pacman -S base-devel nasm qemu xorriso mtools
```

### Build and Run

```bash
# Clone the repository
git clone https://github.com/Guven-K/Project-Lumen.git
cd Project-Lumen

# Build the OS
make all

# Run in QEMU
make run
```

For detailed build instructions, see [docs/build.md](docs/build.md).

## 📁 Project Structure

```
Project-Lumen/
├── boot/          # Bootloader code
├── kernel/        # Kernel source code
├── drivers/       # Device drivers
├── userland/      # User-space applications
├── docs/          # Documentation
├── build/         # Build output (generated)
└── Makefile       # Build system
```

## 🎯 Goals

### Short-term (v0.1)
- Working bootloader and kernel
- Basic memory management
- Process management
- Essential drivers (keyboard, VGA)

### Mid-term (v0.2-0.3)
- File system support
- Graphical user interface
- Window manager
- Basic applications

### Long-term (v1.0+)
- Full desktop environment
- Network support
- Application ecosystem
- Daily-driver capable

## 🤝 Contributing

We welcome contributions! Project Lumen is in early development, and there's plenty to do:

1. **Core Development**: Kernel, drivers, system components
2. **Testing**: Test on different hardware configurations
3. **Documentation**: Improve docs, write tutorials
4. **Applications**: Develop user-space programs

Please read [docs/roadmap.md](docs/roadmap.md) to see what we're working on.

## 📖 Learning Resources

Building an OS from scratch? Here are some helpful resources:

- [OSDev Wiki](https://wiki.osdev.org/) - Comprehensive OS development resource
- [Writing a Simple Operating System from Scratch](https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf)
- [Intel Software Developer Manuals](https://software.intel.com/content/www/us/en/develop/articles/intel-sdm.html)

## 📜 License

Project Lumen is open source software. License details will be added soon.

## 🙏 Acknowledgments

- The OSDev community for invaluable resources
- All contributors and testers
- Everyone who believes in a cleaner, better OS

## 📞 Contact

- **GitHub**: [Guven-K/Project-Lumen](https://github.com/Guven-K/Project-Lumen)
- **Issues**: Report bugs or suggest features via GitHub Issues

---

**Note**: Project Lumen is in early development. Expect frequent changes and incomplete features.
