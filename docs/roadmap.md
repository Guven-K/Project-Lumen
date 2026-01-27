# Project Lumen Roadmap

## Vision

Project Lumen aims to be a modern, clean, and fast operating system built from scratch. Our goal is to create a familiar Windows-like desktop experience without bloat, ads, or forced updates.

## Development Phases

### Phase 0: Foundation (Current)
**Timeline**: Months 1-3

#### Goals
- ✅ Repository setup and project structure
- ✅ Basic documentation
- 🔄 Bootloader development
- 🔄 Minimal kernel with basic features

#### Deliverables
- Working bootloader (Stage 1 and Stage 2)
- Kernel that boots and displays text
- Basic memory management
- Simple interrupt handling
- Serial output for debugging

---

### Phase 1: Core Kernel (v0.1)
**Timeline**: Months 4-8

#### What v0.1 Means
Version 0.1 represents the **Minimum Viable Kernel** - a functioning kernel with essential features that can:
- Boot successfully on real hardware and QEMU
- Manage memory (physical and virtual)
- Handle interrupts and exceptions
- Support basic process management (single process)
- Provide simple text-mode console output
- Execute basic system calls

#### Milestones

**Milestone 1.1: Memory Management**
- Physical memory allocator
- Virtual memory with paging
- Kernel heap allocator
- Basic memory protection

**Milestone 1.2: Process Management**
- Process structure and creation
- Basic scheduler (round-robin)
- Context switching
- Thread support

**Milestone 1.3: System Calls**
- Syscall interface definition
- Basic syscalls (read, write, exit)
- Syscall dispatch mechanism

**Milestone 1.4: Driver Framework**
- Driver loading mechanism
- Device manager
- Basic PCI enumeration

**v0.1 Release Criteria**
- [ ] Boots on QEMU and physical hardware
- [ ] Stable memory management
- [ ] Can run a simple "Hello World" process
- [ ] Serial and VGA text output
- [ ] Basic keyboard input
- [ ] Core documentation complete

---

### Phase 2: Essential Drivers (v0.2)
**Timeline**: Months 9-12

#### Goals
- Implement essential hardware drivers
- File system support
- Basic userland utilities

#### Milestones

**Milestone 2.1: Storage**
- IDE/SATA driver
- Simple filesystem (LumenFS or FAT32)
- VFS layer

**Milestone 2.2: Input/Output**
- Keyboard driver (PS/2 and USB)
- Mouse driver
- VGA/VESA graphics driver

**Milestone 2.3: Userland Foundation**
- C standard library port
- Basic shell
- Essential utilities (ls, cat, echo, etc.)

**v0.2 Release Criteria**
- [ ] Read/write files to disk
- [ ] Interactive shell
- [ ] Basic file utilities
- [ ] Keyboard and mouse support

---

### Phase 3: User Experience (v0.3)
**Timeline**: Months 13-18

#### Goals
- Graphical user interface
- Window manager
- Basic applications

#### Milestones

**Milestone 3.1: Graphics Foundation**
- Framebuffer driver
- Graphics API
- Font rendering

**Milestone 3.2: Window System**
- Window manager
- Basic GUI toolkit
- Event handling

**Milestone 3.3: Core Applications**
- File manager
- Text editor
- System settings

**v0.3 Release Criteria**
- [ ] Graphical desktop environment
- [ ] Working window manager
- [ ] Basic GUI applications
- [ ] Mouse-driven interface

---

### Phase 4: Networking & Services (v0.4)
**Timeline**: Months 19-24

#### Goals
- Network stack implementation
- System services
- Multi-user support

#### Milestones

**Milestone 4.1: Network Stack**
- Ethernet driver
- TCP/IP stack
- Network utilities

**Milestone 4.2: Services**
- Service manager
- Background services
- IPC mechanisms

**Milestone 4.3: Security**
- User management
- Permissions system
- Basic authentication

**v0.4 Release Criteria**
- [ ] Network connectivity
- [ ] Web browser (basic)
- [ ] Multi-user support
- [ ] System services framework

---

### Phase 5: Advanced Features (v0.5+)
**Timeline**: Month 25+

#### Potential Features
- Audio subsystem
- USB 3.0 support
- Advanced graphics (GPU acceleration)
- Modern web browser
- Software package manager
- Developer tools (compiler, IDE)
- Virtualization support
- SMP (multi-core) support
- Advanced power management
- Mobile device support (future)

---

## Success Metrics

### Technical Metrics
- Boot time < 5 seconds (on modern hardware)
- Memory usage < 256MB for base system
- Stable operation (no kernel panics)
- Responsive UI (< 16ms frame time)

### Community Metrics
- Active contributors
- Bug reports and fixes
- Documentation quality
- User adoption

## Release Philosophy

### Version Numbering
- **v0.x**: Pre-release, under active development
- **v1.0**: First stable release, suitable for daily use
- **v1.x**: Bug fixes and minor features
- **v2.0+**: Major feature releases

### Release Cadence
- Development builds: Weekly
- Milestone releases: When features complete
- Major versions: When stable and tested

## Contributing

We welcome contributions at all phases! Priority areas:
1. Core kernel development
2. Driver development
3. Testing on real hardware
4. Documentation
5. Application development

## Long-term Vision

Project Lumen will eventually be:
- A daily-driver desktop OS
- Clean, fast, and customizable
- Free from bloat and ads
- Respectful of user privacy
- Open source and community-driven

---

**Last Updated**: January 2026  
**Current Phase**: Phase 0 (Foundation)  
**Next Milestone**: v0.1 - Core Kernel
