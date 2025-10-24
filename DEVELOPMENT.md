# 🛠️ Development Guide - Cursive Terminal

Welcome to the Cursive Terminal development guide! This document helps contributors understand the project structure, development workflow, and how to add new features.

## 📋 Table of Contents

- [About This Project](#about-this-project)
- [Quick Start for Developers](#quick-start-for-developers)
- [Project Structure](#project-structure)
- [Development Workflow](#development-workflow)
- [Adding New Features](#adding-new-features)
- [Testing](#testing)
- [Documentation](#documentation)
- [Release Process](#release-process)

## 🎨 About This Project

**Cursive Terminal** is a comprehensive theming and font system that transforms your terminal into a beautiful cursive writing experience. The project combines:

- **33 Professional Themes** across 5 categories (dark, light, colorful, business, accessibility)
- **5+ Cursive Fonts** with full monospace compatibility
- **Complete Configuration System** for iTerm2, Terminal.app, Neovim, and Starship
- **40+ Utility Scripts** for demos, installation, testing, and deployment

### Project Goals
1. Make terminal coding aesthetically beautiful with cursive fonts
2. Provide professional themes for all coding scenarios
3. Maintain perfect monospace alignment for code
4. Ensure accessibility with WCAG-AA compliant themes
5. Support easy installation and customization

### Target Users
- Developers who value aesthetics in their tools
- Typography enthusiasts
- Content creators making terminal demos
- Anyone wanting a more elegant coding environment

## 🚀 Quick Start for Developers

### Prerequisites
- macOS 12+ (for full functionality)
- Homebrew package manager
- Git for version control
- Basic shell scripting knowledge

### Setup Development Environment

```bash
# Clone the repository
git clone https://github.com/midnightnow/Cursive-Terminal.git
cd Cursive-Terminal

# Run quick setup to test installation
./quick_setup.sh

# Test demo scripts
./scripts/cursive_font_demo.sh
./scripts/colored_text_demo.sh
./scripts/showcase.sh
```

## 📁 Project Structure

```
Cursive-Terminal/
├── scripts/                      # Core scripts and tools
│   ├── cursive_font_demo.sh     # Font demonstration
│   ├── colored_text_demo.sh     # Color showcase
│   ├── theme-selector.sh        # Interactive theme picker
│   ├── showcase.sh              # Feature showcase
│   ├── font_comparison.sh       # Font comparison tool
│   ├── font_preview_generator.py # Generate font previews
│   └── [30+ additional scripts]
│
├── themes/                       # Theme definitions
│   └── cursive_terminal_themes.sh # All 33 theme definitions
│
├── configs/                      # Configuration files
│   ├── cursive_iterm_profile.json # iTerm2 profile
│   ├── cursive_neovim_config.lua  # Neovim configuration
│   └── starship.toml             # Starship prompt config
│
├── docs/                         # Documentation and assets
│   ├── images/                   # Screenshots and demos
│   ├── FONT_GALLERY.md          # Visual font comparisons
│   └── [additional docs]
│
├── website/                      # Web resources
│
├── install.sh                    # Full installation script
├── quick_setup.sh               # Quick theme installation
├── launch-now.sh                # Launch/deployment script
│
├── README.md                     # Main documentation
├── CONTRIBUTING.md              # Contribution guidelines
├── CHANGELOG.md                 # Version history
├── WORK_LOG.md                  # Development session log
├── DEVELOPMENT.md               # This file
├── TROUBLESHOOTING.md           # Help and solutions
└── LICENSE                      # MIT license

```

## 🔄 Development Workflow

### Branch Strategy

- `main` - Production-ready code
- `claude/[feature-name]-[session-id]` - Feature branches created by Claude Code
- Feature branches for manual development

### Making Changes

1. **Create a Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make Your Changes**
   - Edit scripts, themes, or documentation
   - Follow existing code style
   - Test thoroughly

3. **Document Your Work**
   - Update `WORK_LOG.md` with session details
   - Update `CHANGELOG.md` with changes
   - Add comments to complex code

4. **Test Everything**
   ```bash
   # Test individual scripts
   ./scripts/your-modified-script.sh

   # Run all tests
   ./scripts/run-all-tests.sh
   ```

5. **Commit and Push**
   ```bash
   git add .
   git commit -m "feat: Brief description of your change"
   git push origin feature/your-feature-name
   ```

### Commit Message Format

Follow conventional commits:

- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting)
- `refactor:` - Code refactoring
- `test:` - Adding or updating tests
- `chore:` - Maintenance tasks

Example:
```
feat: Add new Ocean Breeze theme with teal/coral colors

- Created theme definition in themes directory
- Added to theme selector options
- Updated README with theme description
- Added preview screenshot

🤖 Generated with [Claude Code](https://claude.com/claude-code)
Co-Authored-By: Claude <noreply@anthropic.com>
```

## ✨ Adding New Features

### Adding a New Theme

1. **Edit the theme file**
   ```bash
   nano themes/cursive_terminal_themes.sh
   ```

2. **Add your theme function** (use existing themes as templates):
   ```bash
   theme_your_theme_name() {
       echo "Setting 'Your Theme Name' theme..."

       # Background and foreground
       printf '\033]11;#BACKGROUND_COLOR\007'  # Background
       printf '\033]10;#FOREGROUND_COLOR\007'  # Foreground

       # ANSI Colors (0-15)
       printf '\033]4;0;#COLOR0\007'   # Black
       printf '\033]4;1;#COLOR1\007'   # Red
       # ... add all 16 colors

       echo "✓ Your Theme Name theme applied!"
   }
   ```

3. **Add to theme selector**
   - Edit `scripts/theme-selector.sh`
   - Add your theme to the appropriate category

4. **Document the theme**
   - Add description to README.md
   - Create preview screenshot
   - Update CHANGELOG.md

5. **Test the theme**
   ```bash
   source themes/cursive_terminal_themes.sh
   theme_your_theme_name
   ```

### Adding a New Script

1. **Create the script file**
   ```bash
   touch scripts/your_new_script.sh
   chmod +x scripts/your_new_script.sh
   ```

2. **Add shebang and header**
   ```bash
   #!/bin/bash

   # Description: What this script does
   # Usage: ./scripts/your_new_script.sh [options]
   # Author: Your Name
   # Date: YYYY-MM-DD
   ```

3. **Implement functionality**
   - Use existing scripts as templates
   - Follow shell scripting best practices
   - Add error handling

4. **Add to README if user-facing**
   - Document in appropriate section
   - Provide usage examples

### Adding a New Font

1. **Test the font**
   - Install font on your system
   - Verify cursive/italic rendering
   - Check monospace alignment

2. **Add to font demo**
   - Edit `scripts/cursive_font_demo.sh`
   - Add font showcase

3. **Update documentation**
   - Add to README font list
   - Create visual comparison
   - Document installation method

4. **Add to configs**
   - Update iTerm2 profile if needed
   - Add to font comparison script

## 🧪 Testing

### Manual Testing Checklist

- [ ] Install script works on fresh system
- [ ] Quick setup installs all 33 themes
- [ ] Theme selector works correctly
- [ ] All demo scripts execute without errors
- [ ] Fonts render properly in cursive/italic
- [ ] Colors display correctly (check 256-color and true color)
- [ ] Documentation is accurate and up-to-date
- [ ] No broken links or references

### Automated Tests

```bash
# Run all tests
./scripts/run-all-tests.sh

# Test theme installation
./scripts/test-theme-selector.sh

# Validate launch checklist
./scripts/launch-validator.sh
```

### Testing New Themes

1. **Visual Test**
   ```bash
   source themes/cursive_terminal_themes.sh
   theme_your_new_theme
   ./scripts/colored_text_demo.sh
   ```

2. **Check Contrast Ratios** (for light themes)
   - Use online contrast checker
   - Ensure WCAG-AA compliance (4.5:1 minimum)
   - Document contrast ratios

3. **Test in Different Terminals**
   - Terminal.app
   - iTerm2
   - Alacritty (if applicable)

## 📚 Documentation

### Required Documentation Updates

When adding features, update these files:

1. **WORK_LOG.md** - Log your development session
   - What you worked on
   - Scripts executed
   - Key findings
   - Outcomes

2. **CHANGELOG.md** - Document the change
   - Add to [Unreleased] section
   - Use appropriate category (Added/Changed/Fixed/Removed)

3. **README.md** - User-facing documentation
   - Add new features to feature list
   - Update installation instructions if needed
   - Add to theme gallery or font list

4. **CONTRIBUTING.md** - If workflow changes
   - Update contribution guidelines
   - Add new processes

### Documentation Style Guide

- Use clear, concise language
- Include code examples with syntax highlighting
- Add screenshots for visual features
- Use emojis sparingly for section headers
- Keep line length under 100 characters
- Use proper markdown formatting

## 🚀 Release Process

### Preparing a Release

1. **Update version numbers**
   - Decide version: major.minor.patch
   - Update CHANGELOG.md with release date
   - Tag release in git

2. **Test everything**
   ```bash
   ./scripts/run-all-tests.sh
   ./scripts/launch-validator.sh
   ```

3. **Update documentation**
   - Finalize CHANGELOG.md
   - Update README if needed
   - Check all links work

4. **Create release**
   ```bash
   git tag -a v1.1.0 -m "Release version 1.1.0"
   git push origin v1.1.0
   ```

5. **GitHub Release**
   - Create release on GitHub
   - Add release notes from CHANGELOG
   - Attach any binaries or assets

### Version Numbering (Semantic Versioning)

- **Major (X.0.0)**: Breaking changes, major rewrites
- **Minor (1.X.0)**: New features, new themes, backwards-compatible
- **Patch (1.0.X)**: Bug fixes, documentation, minor improvements

## 🐛 Debugging

### Common Issues

**Theme not applying**
- Check theme function name
- Verify color codes are valid hex
- Test with simple `printf` commands

**Script fails**
- Check file permissions: `chmod +x script.sh`
- Verify shebang: `#!/bin/bash`
- Test with `bash -x script.sh` for debug output

**Font not rendering**
- Confirm font is installed
- Check terminal font settings
- Verify italic variant exists

### Debug Mode

Run scripts with debug output:
```bash
bash -x ./scripts/your_script.sh
```

## 🤝 Code Style

### Shell Script Best Practices

1. **Use descriptive variable names**
   ```bash
   # Good
   theme_background_color="#1a1a2e"

   # Bad
   bg="#1a1a2e"
   ```

2. **Add comments for complex logic**
   ```bash
   # Calculate contrast ratio for WCAG compliance
   # Uses formula: (L1 + 0.05) / (L2 + 0.05)
   ```

3. **Error handling**
   ```bash
   if [ ! -d "$theme_dir" ]; then
       echo "Error: Theme directory not found"
       exit 1
   fi
   ```

4. **Consistent formatting**
   - 4-space indentation
   - Space after `#` in comments
   - Quotes around variables: `"$var"`

## 📞 Getting Help

- **Issues**: GitHub Issues for bugs and feature requests
- **Discussions**: GitHub Discussions for questions
- **TROUBLESHOOTING.md**: Common problems and solutions
- **WORK_LOG.md**: See what's been done in previous sessions

## 🎯 Development Goals

### Short Term
- Add more theme categories
- Improve cross-platform support
- Enhanced theme selector UI

### Long Term
- Linux and Windows support
- VS Code extension
- Theme customizer tool
- Community theme repository

---

**Happy coding in cursive!** ✨

For contribution guidelines, see [CONTRIBUTING.md](CONTRIBUTING.md).
