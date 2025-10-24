# ❓ Frequently Asked Questions (FAQ)

Quick answers to common questions about Cursive Terminal.

## 📋 Table of Contents

- [General Questions](#general-questions)
- [Installation & Setup](#installation--setup)
- [Fonts](#fonts)
- [Themes](#themes)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [Advanced Usage](#advanced-usage)

---

## General Questions

### What is Cursive Terminal?

Cursive Terminal is a comprehensive theming and font system that transforms your terminal into a beautiful cursive writing experience. It includes:
- 33 professionally designed color themes
- Support for 5+ cursive monospace fonts
- Complete configuration files for popular terminals and editors
- 40+ utility scripts for installation, demos, and customization

### Why would I want cursive text in my terminal?

Cursive fonts add elegance and aesthetic beauty to your coding environment. They can:
- Make long coding sessions more visually pleasant
- Create beautiful terminal demos and screenshots
- Add personality to your development environment
- Help emphasize comments and documentation in code

### Is this project free?

Yes! Cursive Terminal is completely free and open source under the MIT License. However, we accept donations and sponsorships to support continued development.

### What platforms are supported?

Currently:
- **Primary Support**: macOS 12+ (Monterey and later)
- **Tested**: macOS 11+ (Big Sur and later)
- **Future**: Linux and Windows support planned

---

## Installation & Setup

### How do I install Cursive Terminal?

**Quick Setup** (recommended for most users):
```bash
git clone https://github.com/midnightnow/Cursive-Terminal.git
cd Cursive-Terminal
./quick_setup.sh
```

**Full Installation** (includes font installation):
```bash
./install.sh
```

See [README.md](README.md#-quick-start) for detailed instructions.

### Do I need Homebrew?

- **Quick Setup**: No, themes can be installed without Homebrew
- **Full Installation**: Yes, for automatic font installation
- **Manual**: You can install fonts manually without Homebrew

### Which terminal apps are supported?

- ✅ **Terminal.app** (macOS built-in)
- ✅ **iTerm2** (recommended)
- ✅ **Alacritty** (partial support)
- 🔄 **Windows Terminal** (planned)
- 🔄 **Linux terminals** (planned)

### How long does installation take?

- **Quick Setup**: ~30 seconds (theme installation only)
- **Full Installation**: 5-10 minutes (includes font downloads)

---

## Fonts

### Which cursive font should I use?

**For maximum cursive effect**: **Victor Mono Italic** (most cursive)
```bash
brew install font-victor-mono
```

**Other great options**:
- **Cascadia Code Italic**: Elegant, Microsoft-designed
- **JetBrains Mono Italic**: Subtle cursive, easy on eyes
- **Fira Code**: Excellent ligatures (not cursive but pairs well)

See [SCRIPTS_REFERENCE.md](SCRIPTS_REFERENCE.md#font_comparisonsh) for font comparison.

### How do I make everything cursive?

Set your terminal's **main font** to an italic variant:
- ❌ Wrong: "Victor Mono Regular"
- ✅ Correct: "Victor Mono Italic"

This makes all text appear in cursive by default.

### I installed the font but don't see it in my terminal

**Solutions**:
1. Fully quit your terminal app (⌘Q) and reopen
2. Check Font Book app to verify installation
3. Try reinstalling: `brew reinstall font-victor-mono`
4. Restart your computer if still not visible

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for more font issues.

### Can I use cursive fonts with my editor?

Yes! We provide configurations for:
- **Neovim**: `configs/cursive_neovim_config.lua`
- **VS Code**: Works with any font, just set in settings
- **Vim**: Similar to Neovim configuration

### Do cursive fonts break code alignment?

No! All recommended fonts are **monospace**, meaning they maintain perfect character alignment essential for code.

---

## Themes

### How many themes are included?

**33 themes** across 5 categories:
- 9 Dark themes
- 6 Light manuscript themes
- 6 Colorful themes
- 6 Business document themes
- 6 Feather-light (WCAG-AA accessible) themes

### How do I browse all themes?

**Interactive selector**:
```bash
./scripts/theme-selector.sh
```

**Visual showcase**:
```bash
./scripts/showcase-all-themes.sh
```

**Web browser**:
```bash
open scripts/theme-selector-web.html
```

### How do I apply a theme?

After running `quick_setup.sh`:
```bash
source ~/.config/terminal-themes/cursive-elegance.sh
```

Or use the interactive selector:
```bash
./scripts/theme-selector.sh
```

### Can I create my own theme?

Absolutely! See [DEVELOPMENT.md](DEVELOPMENT.md#adding-a-new-theme) for a complete guide.

Basic template:
```bash
# Set background and foreground
printf '\033]11;#BACKGROUND\007'
printf '\033]10;#FOREGROUND\007'

# Set ANSI colors 0-15
printf '\033]4;0;#000000\007'  # Black
printf '\033]4;1;#FF0000\007'  # Red
# ... etc
```

### How do I make a theme permanent?

Add to your shell profile (`~/.zshrc` or `~/.bashrc`):
```bash
# Apply Cursive Elegance theme on startup
source ~/.config/terminal-themes/cursive-elegance.sh
```

### Are the light themes accessible?

Yes! All "Feather-Light" themes meet **WCAG-AA** accessibility standards (4.5:1 contrast ratio minimum):
- Papyrus Scroll (5.21:1)
- Linen Sheet (7.89:1)
- Calligraphy Flourish (19.56:1)
- And 3 more

---

## Troubleshooting

### I don't see any cursive text

**Most common cause**: You selected the regular font variant instead of italic.

**Solution**: Change terminal font from "Victor Mono" to "Victor Mono **Italic**"

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md#-i-dont-see-any-cursive-text) for detailed steps.

### Colors look wrong or washed out

**Possible causes**:
1. Terminal color profile conflicts
2. TERM variable not set correctly
3. Theme not applied

**Solutions**:
```bash
# Set TERM variable
export TERM=xterm-256color

# Re-apply theme
source ~/.config/terminal-themes/your-theme.sh
```

### Only some text is cursive

This is expected behavior if you selected the **regular** font variant. All text formatted as *italic* will appear cursive.

To make **everything** cursive, set the main font to the italic variant.

### Theme selector says "Theme directory not found"

**Solution**: Run the quick setup first:
```bash
./quick_setup.sh
```

This creates `~/.config/terminal-themes/` with all 33 themes.

### Where can I get more help?

1. **Check existing documentation**:
   - [TROUBLESHOOTING.md](TROUBLESHOOTING.md) - Common issues
   - [DEVELOPMENT.md](DEVELOPMENT.md) - Technical details
   - [SCRIPTS_REFERENCE.md](SCRIPTS_REFERENCE.md) - Script help

2. **Search GitHub Issues**: Someone may have had the same problem

3. **Create a new issue**: Provide details about your setup

---

## Contributing

### How can I contribute?

Many ways to help!
- **Add new fonts**: Support for additional cursive fonts
- **Create themes**: Design new color schemes
- **Improve docs**: Tutorials, guides, translations
- **Fix bugs**: Check GitHub issues
- **Share**: Star the repo, tell others

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

### I found a bug. What should I do?

1. Check if it's already reported in [GitHub Issues](https://github.com/midnightnow/Cursive-Terminal/issues)
2. If not, create a new issue with:
   - Your macOS version
   - Terminal app and version
   - Steps to reproduce
   - Screenshots (if visual issue)

### Can I submit my custom theme?

Yes! We love community themes. To submit:
1. Fork the repository
2. Add your theme to `themes/cursive_terminal_themes.sh`
3. Test it thoroughly
4. Submit a pull request with screenshots

See [DEVELOPMENT.md](DEVELOPMENT.md#adding-a-new-theme) for the theme structure.

### Do I need to know programming to contribute?

Not at all! You can contribute by:
- Creating themes (just color codes)
- Writing documentation
- Making tutorials or videos
- Reporting bugs
- Suggesting features

---

## Advanced Usage

### Can I use these themes with tmux?

Yes! Add to your `~/.tmux.conf`:
```bash
# Source theme before starting tmux
set-option -g default-command "source ~/.config/terminal-themes/your-theme.sh && $SHELL"
```

### Can I integrate with Starship prompt?

Yes! We provide a configuration:
```bash
cp configs/starship.toml ~/.config/starship.toml
```

### How do I generate font preview images?

```bash
python scripts/font_preview_generator.py
```

Requires: `pip install Pillow`

Generates PNG previews in `docs/images/`

### Can I create animated GIF demos?

Yes! Use our GIF generator:
```bash
./scripts/showcase_gif_generator.sh
```

Requires:
```bash
brew install asciinema
cargo install --git https://github.com/asciinema/agg
```

### How do I create a custom slanted font?

Use our oblique font generator:
```bash
python scripts/create_oblique_font.py input.ttf output.ttf
```

This creates a slanted version of any monospace font.

### Can I use this in CI/CD or Docker?

Yes, but with limitations:
- Themes work (color codes)
- Font rendering requires a GUI environment
- Useful for generating colored terminal output in logs

### Where are the theme files stored?

After `quick_setup.sh`:
```
~/.config/terminal-themes/
├── cursive-elegance.sh
├── cursive-noir.sh
├── ocean-mist.sh
└── ... (30 more themes)
```

### How do I uninstall?

```bash
# Remove theme files
rm -rf ~/.config/terminal-themes

# Remove font (if installed via Homebrew)
brew uninstall font-victor-mono

# Remove cloned repository
cd ..
rm -rf Cursive-Terminal
```

---

## 💡 Still Have Questions?

- **Check the docs**: [Full documentation list](README.md#-documentation)
- **Search issues**: [GitHub Issues](https://github.com/midnightnow/Cursive-Terminal/issues)
- **Ask on Discussions**: [GitHub Discussions](https://github.com/midnightnow/Cursive-Terminal/discussions)
- **Read the code**: All scripts are well-commented!

---

**Happy cursive coding!** ✨

*Last updated: October 24, 2024*
