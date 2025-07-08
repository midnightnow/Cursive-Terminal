# 📋 Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### 🎬 Added
- Font preview generator for creating PNG comparisons
- Showcase GIF generator for animated demonstrations
- GitHub issue and PR templates
- Contributing guidelines
- Professional README with badges

### 🔧 Changed
- Enhanced directory structure with proper organization
- Updated installation script with better error handling
- Improved documentation throughout

## [1.0.0] - 2025-01-08

### 🎉 Initial Release

#### ✨ Added
- **Core Fonts Support**:
  - Victor Mono (primary cursive font)
  - Cascadia Code (Microsoft's elegant cursive)
  - JetBrains Mono (subtle cursive)
  - Fira Code (with ligatures)
  - SF Mono Oblique (custom generated)

- **Installation & Setup**:
  - Complete installation script (`install.sh`)
  - Quick setup script for basic configuration
  - Font detection and automatic installation

- **Demo & Testing**:
  - Comprehensive font demonstration script
  - Font comparison tool
  - Animated showcase presentation
  - Cursive text rendering tests

- **Configuration Files**:
  - iTerm2 profile with cursive settings
  - Neovim configuration for cursive coding
  - Starship prompt with cursive styling
  - Enhanced zsh syntax highlighting

- **Themes & Styling**:
  - Cursive Elegance theme (purple/gold)
  - Cursive Noir theme (black/silver)
  - Cursive Garden theme (green/brown)
  - Optimized color schemes for cursive fonts

- **Tools & Utilities**:
  - Custom oblique font generator
  - Terminal theme switcher
  - Font preview generator (PNG output)
  - Showcase GIF creator

- **Documentation**:
  - Comprehensive README with setup instructions
  - Detailed troubleshooting guide
  - Font gallery with visual comparisons
  - Installation and configuration guides

#### 🛠️ Technical Details
- **Platform**: macOS (primary support)
- **Dependencies**: Homebrew, Python 3, various font packages
- **Terminal Support**: Terminal.app, iTerm2, Alacritty
- **Shell Support**: Zsh (primary), Bash compatibility

#### 📦 Package Structure
```
cursive-terminal-setup/
├── scripts/          # Executable tools and demos
├── configs/          # Terminal and editor configurations  
├── themes/           # Color schemes and styling
├── docs/            # Documentation and assets
├── install.sh       # Main installation script
└── LICENSE          # MIT license
```

#### 🎯 Key Features
- **Transform any terminal into a cursive writing experience**
- **Maintain perfect monospace alignment for code**
- **5+ professionally curated cursive fonts**
- **Complete automation for setup and configuration**
- **Visual previews and animated demonstrations**
- **Cross-terminal compatibility**
- **Professional documentation and support**

---

## 📝 Notes

### Version Numbering
- **Major** (X.0.0): Breaking changes, major feature additions
- **Minor** (1.X.0): New fonts, features, backwards-compatible changes  
- **Patch** (1.0.X): Bug fixes, documentation updates, minor improvements

### Supported Platforms
- **Primary**: macOS 12+ (Monterey and later)
- **Tested**: macOS 11+ (Big Sur and later)
- **Future**: Linux support planned for v2.0

### Contributing
See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on:
- Adding new fonts
- Creating themes
- Reporting bugs
- Submitting pull requests

### License
This project is licensed under the MIT License - see [LICENSE](LICENSE) for details.