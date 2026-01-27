# Userland Applications

This directory contains user-space applications for Project Lumen.

## Current Status

User applications are not yet implemented. They will be added in Phase 2 of development when we have:
- Process management
- System calls
- Basic C library

## Planned Applications

### Phase 2 (v0.2)
- **Shell**: Interactive command-line interface
- **ls**: List directory contents
- **cat**: Display file contents
- **echo**: Print text
- **mkdir**: Create directories
- **rm**: Remove files

### Phase 3 (v0.3)
- **File Manager**: Graphical file browser
- **Text Editor**: Simple text editing application
- **System Settings**: Configuration tool
- **Calculator**: Basic calculator app

## Building Applications

Once implemented, applications will be built with:

```bash
make userland
```

## Directory Structure

```
userland/
├── apps/          # Application source code
├── lib/           # User-space libraries
└── include/       # Header files
```
