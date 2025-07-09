# 🚀 Quick Start: Cursive Terminal Theme Selector

## One-Line Install

```bash
git clone https://github.com/midnightnow/Cursive-Terminal.git && cd Cursive-Terminal/scripts && ./install-all-themes.sh && ./theme-selector.sh
```

## Step-by-Step Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/midnightnow/Cursive-Terminal.git
cd Cursive-Terminal/scripts
```

### 2. Install All Themes
```bash
./install-all-themes.sh
```
This installs all 33 themes to `~/.config/terminal-themes/`

### 3. Run the Theme Selector

**Option A: Interactive CLI** (Recommended)
```bash
./theme-selector.sh
```

**Option B: Web Interface**
```bash
open theme-selector-web.html
# Or on Linux: xdg-open theme-selector-web.html
```

## 🎨 Available Commands

Once in the CLI theme selector:
- `1-6` - Browse themes by category
- `s` - Search themes
- `r` - Random theme
- `p` - Toggle preview mode
- `q` - Quit

Or type any theme name directly:
- `vampires-letter` - Dark vampire theme
- `pirate-scroll` - Pirate parchment theme
- `ancient-papyrus` - Light manuscript theme
- `rainbow-prism` - Colorful theme

## 💡 Tips

1. **Preview Mode** is on by default - try themes before applying
2. **Save to Profile** - When you find a theme you like, it can save to your shell config
3. **Random Theme** (`r`) - Great way to discover new favorites!

## 🔧 Manual Theme Application

If you prefer to apply themes directly:
```bash
source ~/.config/terminal-themes/vampires-letter.sh
```

## 📋 All 33 Themes

**Dark (9)**: cursive-elegance, cursive-noir, cursive-garden, pirate-scroll, vampires-letter, ocean-mist, sunset-glow, forest-grove, midnight-quill

**Light (6)**: ancient-papyrus, ivory-parchment, linen-manuscript, calligraphy-scroll, illuminated-manuscript, invisible-ink

**Colorful (6)**: rainbow-prism, neon-cyberpunk, tropical-paradise, cotton-candy, aurora-borealis, sunset-festival

**Business (6)**: office-memo, receipt-paper, carbon-copy, blueprint-tech, legal-document, ditto-spirit

**WCAG-AA (6)**: papyrus-scroll, ancient-parchment, linen-sheet, calligraphy-flourish, invisible-ink-revealed

## ⚡ Quick Theme Test

```bash
# Try the vampire theme
source ~/.config/terminal-themes/vampires-letter.sh
echo "🧛 Welcome to the dark side..."

# Try the pirate theme
source ~/.config/terminal-themes/pirate-scroll.sh
echo "🏴‍☠️ Ahoy, matey!"
```

## 🐛 Troubleshooting

If themes don't appear:
1. Make sure you ran `./install-all-themes.sh` first
2. Check that `~/.config/terminal-themes/` exists
3. Ensure your terminal supports ANSI colors

---
Enjoy your cursive terminal experience! ✨