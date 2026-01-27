# Contributing to Project Lumen

Thank you for your interest in contributing to Project Lumen! This guide will help you get started.

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally
3. **Create a branch** for your feature or bugfix
4. **Make your changes** and test them
5. **Submit a pull request**

## Development Setup

See [docs/build.md](docs/build.md) for detailed build instructions.

```bash
# Install prerequisites
sudo apt install build-essential nasm qemu-system-x86 xorriso mtools

# Build and test
make all
make run-debug
```

## Areas We Need Help

### High Priority
- **Kernel Development**: Memory management, process scheduling
- **Driver Development**: Keyboard, mouse, disk drivers
- **Testing**: Test on real hardware, report bugs
- **Documentation**: Improve existing docs, add tutorials

### Medium Priority
- **Build System**: Improve Makefile, add CI/CD
- **Userland**: System utilities, shell
- **File System**: Design and implement LumenFS

### Future
- **GUI**: Window manager, desktop environment
- **Applications**: File manager, text editor, etc.
- **Network Stack**: TCP/IP implementation

## Coding Standards

### C Code
- Use K&R style indentation (4 spaces, no tabs)
- Functions should be well-documented
- Keep functions short and focused
- Use meaningful variable names
- Add comments for complex logic

### Assembly Code
- Use NASM syntax
- Comment each section
- Keep code readable and organized

### Example C Code
```c
/*
 * Brief description of what this does
 */
void example_function(int param) {
    // Clear initialization
    int result = 0;
    
    // Do something
    result = param * 2;
    
    // Return or use result
    return result;
}
```

## Commit Messages

Write clear, descriptive commit messages:

```
Short summary (50 chars or less)

More detailed explanation if needed. Wrap at 72 characters.
Explain what changed and why, not how.

- Bullet points are okay
- Reference issues: Fixes #123
```

## Testing

Before submitting a PR:

1. **Build successfully**: `make all`
2. **Test in QEMU**: `make run-debug`
3. **Check for errors**: Review serial output
4. **Test on real hardware** (if possible)

## Documentation

- Update documentation if you change functionality
- Add comments to complex code
- Update README.md if you add new features

## Pull Request Process

1. **Ensure your code builds** without warnings
2. **Test your changes** thoroughly
3. **Update documentation** as needed
4. **Describe your changes** clearly in the PR
5. **Link related issues** in the PR description

### PR Description Template
```markdown
## Description
Brief description of what this PR does

## Changes
- List of changes made
- Each on a separate line

## Testing
How you tested these changes

## Related Issues
Fixes #123
```

## Code Review

- Be respectful and constructive
- Respond to feedback promptly
- Make requested changes or explain why you disagree

## Questions?

- Open a GitHub Issue for questions
- Check existing documentation first
- Ask in pull request comments

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

---

Thank you for contributing to Project Lumen! 🚀
