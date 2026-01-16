# 🤝 Contributing to Cursive Terminal Setup

Thank you for your interest in contributing! This project thrives on community contributions from developers who love beautiful terminals.

## 🌟 Ways to Contribute

### 🔤 Font Support
- Add support for new cursive monospace fonts
- Improve font detection and installation
- Create font preview generators

### 🎨 Themes & Styling
- Design new terminal color themes
- Enhance syntax highlighting configurations
- Create new visual elements

### 📚 Documentation
- Improve setup instructions
- Add troubleshooting guides
- Create video tutorials or GIFs

### 🐛 Bug Fixes
- Fix installation issues
- Resolve font rendering problems
- Improve cross-terminal compatibility

### 🛠️ Tools & Scripts
- Enhance existing scripts
- Add new utility tools
- Improve automation

## 🚀 Getting Started

### Prerequisites
- macOS (primary support)
- Homebrew installed
- Basic terminal/shell knowledge
- Git experience

### Development Setup
1. **Fork and Clone**
   ```bash
   git clone https://github.com/YOUR_USERNAME/Cursive-Terminal.git
   cd Cursive-Terminal
   ```

2. **Test Current Setup**
   ```bash
   ./install.sh
   ./scripts/cursive_font_demo.sh
   ```

3. **Create Feature Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

## 📋 Contribution Guidelines

### Code Style
- **Shell Scripts**: Use `#!/bin/bash` and `set -e` for error handling
- **Python Scripts**: Follow PEP 8, include docstrings
- **Comments**: Explain complex logic, especially font-related code
- **Error Handling**: Provide helpful error messages

### Commit Messages
Use conventional commit format:
```
type(scope): description

✨ feat(fonts): add support for Comic Code font
🐛 fix(install): resolve Homebrew detection issue
📚 docs(readme): update installation instructions
🎨 style(themes): add dark mode color scheme
```

### Testing Checklist
Before submitting a PR:
- [ ] Test on Terminal.app
- [ ] Test on iTerm2
- [ ] Verify font installation works
- [ ] Check cursive rendering
- [ ] Run existing demo scripts
- [ ] Update documentation if needed

### File Organization
```
cursive-terminal-setup/
├── scripts/           # Executable tools and utilities
├── configs/          # Configuration files
├── themes/           # Color schemes and themes
├── docs/            # Documentation and images
└── .github/         # GitHub templates and workflows
```

## 🔤 Adding New Fonts

### Font Requirements
1. **Monospaced**: Must be fixed-width for code alignment
2. **Cursive Support**: Should have italic/cursive variants
3. **Availability**: Installable via Homebrew or direct download
4. **License**: Must be freely redistributable

### Font Addition Process
1. **Research the font**:
   - Verify license compatibility
   - Check installation methods
   - Test cursive quality

2. **Update installation**:
   - Add to `install.sh`
   - Update font detection in scripts

3. **Add to demos**:
   - Include in `font_comparison.sh`
   - Add to preview generator

4. **Documentation**:
   - Update README font list
   - Add to troubleshooting if needed

### Example Font Addition
```bash
# In install.sh
fonts=(
    "font-victor-mono"
    "font-your-new-font"  # Add here
)

# In font_comparison.sh
show_font "Your New Font" "Description of cursive style"
```

## 🎨 Theme Guidelines

### Theme Requirements
- **Readability**: Must work well with cursive fonts
- **Contrast**: Adequate contrast for all terminal colors
- **Consistency**: Follow established color patterns

### Theme Structure
```bash
# Theme template
echo -e "\033]10;#FOREGROUND\007"  # Text color
echo -e "\033]11;#BACKGROUND\007"  # Background color
echo -e "\033]12;#CURSOR\007"      # Cursor color

# ANSI colors (0-7)
echo -e "\033]4;0;#COLOR0\007"     # Black
# ... continue for all 16 colors
```

## 📝 Documentation Standards

### README Updates
- Keep examples current and working
- Include screenshots when adding visual features
- Update installation instructions for new dependencies

### Code Documentation
```python
def create_font_preview(font_path, font_name, output_dir="docs/images"):
    """Create a preview image for a font showing cursive text samples
    
    Args:
        font_path: Absolute path to the font file
        font_name: Display name for the font
        output_dir: Directory to save preview images
        
    Returns:
        Path to created preview image or None if failed
    """
```

## 🐛 Bug Reports

When reporting bugs:
1. Use the bug report template
2. Include your macOS version
3. Specify which terminal app
4. Provide reproduction steps
5. Attach screenshots if visual

## 💬 Community

### Getting Help
- Check existing issues first
- Use GitHub Discussions for questions
- Be specific about your setup

### Code Review Process
1. Maintainers review all PRs
2. At least one approval required
3. All checks must pass
4. Squash and merge preferred

## 🏷️ Releases

### Versioning
We use [Semantic Versioning](https://semver.org/):
- **MAJOR**: Breaking changes
- **MINOR**: New features, new fonts
- **PATCH**: Bug fixes, documentation

### Release Process
1. Update CHANGELOG.md
2. Update version references
3. Create GitHub release
4. Update any package managers

## 📜 License

By contributing, you agree that your contributions will be licensed under the MIT License.

## 🙏 Recognition

Contributors are listed in:
- GitHub contributors page
- CHANGELOG.md for significant contributions
- Special thanks in releases

---

**Happy Contributing! Let's make terminals beautiful together! ✨**