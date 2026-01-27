# Device Drivers

This directory contains device drivers for Project Lumen.

## Current Status

Drivers are currently being developed. Basic VGA and serial drivers are integrated into the kernel.

## Planned Drivers

### Phase 1 (v0.1)
- ✅ VGA Text Mode (integrated in kernel)
- ✅ Serial Port (COM1) (integrated in kernel)
- [ ] Keyboard (PS/2)
- [ ] Basic PCI enumeration

### Phase 2 (v0.2)
- [ ] IDE/SATA disk controller
- [ ] Mouse (PS/2)
- [ ] VESA graphics
- [ ] RTC (Real-Time Clock)

### Phase 3 (v0.3)
- [ ] USB controller
- [ ] USB keyboard/mouse
- [ ] Modern GPU support
- [ ] Audio driver

### Phase 4 (v0.4)
- [ ] Network card (Ethernet)
- [ ] Wi-Fi (future)

## Driver Architecture

Project Lumen uses a hybrid driver model:
- Critical drivers run in kernel space
- Other drivers can run in user space (future)

See `docs/architecture.md` for more details.

## Directory Structure

```
drivers/
├── block/         # Block device drivers (disks)
├── char/          # Character device drivers
├── net/           # Network drivers
├── graphics/      # Graphics drivers
├── input/         # Input device drivers
└── audio/         # Audio drivers
```
