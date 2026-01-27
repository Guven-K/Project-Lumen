# Project Lumen Architecture

## Overview

Project Lumen is a custom operating system built from scratch with a clean architecture focusing on modularity, performance, and user experience. This document outlines the core architectural components of the system.

## Kernel Architecture

### Kernel Model

Project Lumen uses a **hybrid microkernel** architecture that balances the performance benefits of monolithic kernels with the modularity and safety of microkernels.

#### Core Kernel Components

1. **Kernel Core**
   - Process and thread management
   - Memory management (virtual memory, paging)
   - Interrupt handling and system calls
   - Scheduling (priority-based preemptive scheduler)
   - Basic synchronization primitives (mutexes, semaphores)

2. **Memory Manager**
   - Physical memory allocator
   - Virtual memory manager with paging support
   - Kernel heap allocator
   - Memory protection and page table management
   - Support for demand paging and copy-on-write

3. **Process Manager**
   - Process creation and termination
   - Thread management
   - Context switching
   - Process scheduling
   - Signal handling

4. **System Call Interface**
   - Clean, well-defined syscall ABI
   - Security and validation layer
   - Performance-optimized syscall dispatch

### Driver Model

Project Lumen implements a flexible driver architecture that allows both in-kernel and user-space drivers.

#### Driver Architecture

1. **In-Kernel Drivers**
   - Critical drivers run in kernel space (disk, network, graphics)
   - Direct hardware access for performance
   - Strict API and security constraints

2. **User-Space Drivers** (Future)
   - Less critical drivers can run in user space
   - Enhanced stability (driver crash doesn't crash kernel)
   - Easier development and debugging

#### Driver Components

- **Driver Manager**: Loads and manages drivers, handles driver dependencies
- **Device Tree**: Hierarchical representation of hardware devices
- **Driver API**: Standardized interface for driver development
- **Plug and Play Support**: Automatic device detection and driver loading

#### Supported Driver Types

- **Block Drivers**: Disk controllers, filesystem support
- **Character Drivers**: Serial ports, input devices
- **Network Drivers**: Ethernet, Wi-Fi (future)
- **Graphics Drivers**: VGA, VESA, modern GPU support (future)
- **Input Drivers**: Keyboard, mouse, touchpad
- **Audio Drivers**: Sound cards (future)

### Inter-Process Communication (IPC)

Project Lumen provides multiple IPC mechanisms optimized for different use cases.

#### IPC Mechanisms

1. **Message Passing**
   - Asynchronous message queues
   - Synchronous send/receive operations
   - Priority-based message delivery
   - Zero-copy optimization for large messages

2. **Shared Memory**
   - Fast data exchange between processes
   - Memory-mapped regions
   - Synchronization primitives for shared access

3. **Pipes**
   - Anonymous pipes for parent-child communication
   - Named pipes (FIFOs) for unrelated processes
   - Stream-based communication

4. **Signals**
   - Asynchronous event notification
   - Process control and error handling

5. **Semaphores and Mutexes**
   - Cross-process synchronization
   - Named and anonymous variants

#### IPC Security

- Process capability-based access control
- IPC endpoint authentication
- Message validation and size limits
- Prevention of resource exhaustion attacks

## System Architecture Layers

```
┌─────────────────────────────────────────────────┐
│          User Applications                       │
├─────────────────────────────────────────────────┤
│          System Libraries & Runtime              │
├─────────────────────────────────────────────────┤
│          System Services (User Space)            │
├─────────────────────────────────────────────────┤
│          System Call Interface                   │
├─────────────────────────────────────────────────┤
│          Kernel Core (Hybrid Microkernel)        │
│  ┌──────────────┬──────────────┬──────────────┐ │
│  │  Process Mgr │  Memory Mgr  │  Scheduler   │ │
│  ├──────────────┼──────────────┼──────────────┤ │
│  │  VFS Layer   │  IPC Manager │  Security    │ │
│  └──────────────┴──────────────┴──────────────┘ │
├─────────────────────────────────────────────────┤
│          Device Drivers                          │
├─────────────────────────────────────────────────┤
│          Hardware Abstraction Layer              │
├─────────────────────────────────────────────────┤
│          Physical Hardware                       │
└─────────────────────────────────────────────────┘
```

## Filesystem Architecture

### Virtual File System (VFS)

- Unified interface for different filesystems
- Support for multiple mounted filesystems
- File descriptor management
- Caching and buffering layer

### Supported Filesystems

- **LumenFS** (native): Custom filesystem optimized for Project Lumen
- **FAT32**: Compatibility with removable media
- **ISO9660**: CD/DVD support
- **Future**: ext2/ext3, NTFS read support

## Boot Process

1. **BIOS/UEFI**: Hardware initialization
2. **Bootloader**: Load kernel into memory
3. **Kernel Initialization**: Set up core subsystems
4. **Driver Loading**: Initialize essential drivers
5. **Init Process**: Start system services
6. **User Session**: Launch desktop environment

## Security Model

- **User/Kernel Space Separation**: Ring 0 (kernel) and Ring 3 (user)
- **Process Isolation**: Each process has its own address space
- **Capability-Based Security**: Fine-grained permissions
- **Secure Boot** (future): Verify kernel and driver signatures

## Performance Considerations

- Optimized context switching
- Efficient syscall handling
- Smart memory caching
- I/O scheduling and prioritization
- Minimal kernel bloat

## Future Enhancements

- SMP (Symmetric Multi-Processing) support
- Advanced power management
- Container/virtualization support
- Enhanced security features (ASLR, DEP)
- Modern filesystem features (journaling, encryption)
