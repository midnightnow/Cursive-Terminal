# ✒️ Cursive Terminal Setup

> Transform your boring monospace terminal into a beautiful cursive writing experience!

![Victor Mono Cursive](https://raw.githubusercontent.com/rubjo/victor-mono/master/public/header.gif)

## 🎨 What is this?

This repository contains everything you need to set up a **fully cursive terminal** on macOS. Imagine coding in elegant, flowing script while maintaining perfect monospace alignment!

## ✨ Features

- **5+ Cursive Monospace Fonts**: Victor Mono, Cascadia Code, JetBrains Mono, and more
- **Custom Terminal Themes**: Beautiful color schemes optimized for cursive fonts
- **Enhanced Syntax Highlighting**: Make comments and strings extra beautiful
- **Font Generation Tools**: Create your own oblique/cursive variants
- **Complete Configuration**: iTerm2 profiles, Neovim configs, and more

## 🚀 Quick Start

```bash
# Clone this repository
git clone https://github.com/yourusername/cursive-terminal-setup.git
cd cursive-terminal-setup

# Run the quick setup
./quick_setup.sh

# Test cursive rendering
./scripts/cursive_font_demo.sh
```

## 📦 What's Included

```
cursive-terminal-setup/
├── scripts/
│   ├── cursive_font_demo.sh      # Demo script showing cursive features
│   ├── create_oblique_font.py    # Create custom slanted fonts
│   └── quick_setup.sh            # Quick installation script
├── themes/
│   └── cursive_terminal_themes.sh # Beautiful terminal color themes
├── configs/
│   ├── cursive_iterm_profile.json # iTerm2 profile with cursive settings
│   ├── cursive_neovim_config.lua  # Neovim configuration for cursive
│   └── starship.toml              # Starship prompt with cursive styling
└── docs/
    └── full_setup_guide.md        # Comprehensive setup instructions
```

## 🎯 Recommended Fonts

### Victor Mono (⭐ Most Cursive)
The star of the show! Features beautiful semi-connected cursive italics.
```bash
brew install font-victor-mono
```

### Other Great Options
- **Cascadia Code**: Microsoft's elegant cursive italics
- **JetBrains Mono**: Subtle cursive for long coding sessions
- **Fira Code**: Not cursive, but amazing ligatures

## 🖥️ Terminal Setup

### For Terminal.app
1. Press `⌘,` to open preferences
2. Go to Profiles → Text
3. Change font to "Victor Mono" → "Italic"

### For iTerm2
1. Press `⌘,` to open preferences
2. Go to Profiles → Text → Font
3. Select "Victor Mono Italic"
4. Or import our custom profile: `configs/cursive_iterm_profile.json`

## 🌈 Usage Examples

### Test Cursive Rendering
```bash
echo -e "Regular text \e[3mThis appears in beautiful cursive!\e[0m"
```

### Full Cursive Mode
Set Victor Mono Italic as your main terminal font to make EVERYTHING cursive!

## 📸 Screenshots

<details>
<summary>Click to see terminal screenshots</summary>

### Code Comments in Cursive
```javascript
// This comment appears in beautiful flowing script
const message = "Even strings can be cursive!";
```

### Git Output
Git commands show metadata in elegant cursive italics.

### Man Pages
Manual pages render with cursive emphasis for readability.

</details>

## 🛠️ Advanced Setup

### Create Your Own Oblique Font
```bash
python scripts/create_oblique_font.py /path/to/font.ttf output.ttf
```

### Custom Themes
Apply beautiful color themes optimized for cursive:
```bash
source themes/cursive-elegance.sh
source themes/cursive-noir.sh
source themes/cursive-garden.sh
```

## 🤝 Contributing

Found a new cursive monospace font? Have a beautiful theme? PRs welcome!

1. Fork this repository
2. Add your enhancement
3. Submit a pull request

## 📝 License

MIT - Because beautiful terminals should be free!

## 🙏 Acknowledgments

- [Victor Mono](https://rubjo.github.io/victor-mono/) by Rune Bjørnerås
- [Cascadia Code](https://github.com/microsoft/cascadia-code) by Microsoft
- [JetBrains Mono](https://www.jetbrains.com/lp/mono/) by JetBrains
- Created with the help of Claude Code

---

**⚡ Fun Fact**: You're joining an elite group of developers who code entirely in cursive! Welcome to the club! ✨

Made with ❤️ and a love for beautiful typography.