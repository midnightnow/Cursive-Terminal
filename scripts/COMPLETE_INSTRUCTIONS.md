# 📚 Complete Cursive Terminal Instructions

## 🚀 Installation from GitHub

### Method 1: Quick One-Liner
```bash
git clone https://github.com/midnightnow/Cursive-Terminal.git && cd Cursive-Terminal/scripts && ./install-all-themes.sh && ./theme-selector.sh
```

### Method 2: Step by Step
```bash
# 1. Clone the repository
git clone https://github.com/midnightnow/Cursive-Terminal.git

# 2. Navigate to scripts directory
cd Cursive-Terminal/scripts

# 3. Make scripts executable (if needed)
chmod +x *.sh

# 4. Install all 33 themes
./install-all-themes.sh

# 5. Run the theme selector
./theme-selector.sh
```

## 🎨 Using the Theme Selector

### CLI Theme Selector Commands
When you run `./theme-selector.sh`, you'll see:

```
Main Menu:
  1) All Themes (33)
  2) Dark Themes (9)
  3) Light Manuscript (6)
  4) Colorful Themes (6)
  5) Business Documents (6)
  6) Feather-Light WCAG (6)

  s) Search themes
  r) Random theme
  p) Toggle preview mode (currently: true)
  h) Help
  q) Quit
```

### How to Use:
- **Type 1-6**: Browse specific category
- **Type 's'**: Search for themes by name or description
- **Type 'r'**: Get a random theme (fun way to explore!)
- **Type 'p'**: Toggle preview mode on/off
- **Type theme name**: Apply directly (e.g., type `vampires-letter`)
- **Type 'q'**: Quit the selector

### Example Usage Flow:
```bash
# Start selector
./theme-selector.sh

# Type '2' for dark themes
2

# You'll see:
ancient-papyrus    cursive-elegance   cursive-garden
cursive-noir       forest-grove       midnight-quill
ocean-mist         pirate-scroll      sunset-glow
vampires-letter

# Type a theme name
vampires-letter

# Preview appears, then:
Apply this theme? [y/N]: y
Save to profile? [y/N]: y
```

## 🎭 All 33 Available Themes

### Dark Themes (9)
1. **cursive-elegance** - ✨ Purple/Gold - Sophisticated and elegant
2. **cursive-noir** - ⚫ Black/Silver - Classic monochrome sophistication
3. **cursive-garden** - 🌿 Green/Brown - Natural earth tones
4. **pirate-scroll** - 🏴‍☠️ Brown/Gold - Weather-beaten parchment
5. **vampires-letter** - 🧛 Black/Red - Dark velvet night
6. **ocean-mist** - 🌊 Blue/Teal - Deep-sea blues
7. **sunset-glow** - 🌅 Orange/Pink - Warm sunset colors
8. **forest-grove** - 🌲 Green/Brown - Deep forest
9. **midnight-quill** - 🌙 Indigo/Silver - Night sky

### Light Manuscript Themes (6)
1. **ancient-papyrus** - 📜 Beige/Brown - Aged papyrus
2. **ivory-parchment** - 🏛️ Ivory/Brown - Smooth ivory
3. **linen-manuscript** - 🧵 Linen/Slate - Natural texture
4. **calligraphy-scroll** - ✒️ Cream/Black - Classic calligraphy
5. **illuminated-manuscript** - 🎨 Blue/Navy - Medieval illuminated
6. **invisible-ink** - 🔍 Light Gray - Secret messages

### Colorful Themes (6)
1. **rainbow-prism** - 🌈 Dark/Vibrant - Rainbow highlights
2. **neon-cyberpunk** - ⚡ Black/Green - Matrix neon
3. **tropical-paradise** - 🌺 Teal/Orange - Tropical colors
4. **cotton-candy** - 🍭 Pink/Purple - Soft swirls
5. **aurora-borealis** - 🌌 Navy/Green - Aurora lights
6. **sunset-festival** - 🎪 Purple/Orange - Festival vibes

### Business Document Themes (6)
1. **office-memo** - 📄 White/Blue - Professional
2. **receipt-paper** - 🧾 Cream/Black - Thermal paper
3. **carbon-copy** - 📑 Lavender/Purple - Carbon paper
4. **blueprint-tech** - 📐 Blue/Cyan - Technical blueprint
5. **legal-document** - ⚖️ White/Brown - Formal legal
6. **ditto-spirit** - 🖨️ Blue/Purple - Ditto machine

### Feather-Light WCAG Themes (6)
1. **papyrus-scroll** - 📜 Ochre/Brown - WCAG-AA compliant
2. **ancient-parchment** - 🦴 Ivory/Sepia - Warm sepia
3. **linen-sheet** - 🧵 White/Charcoal - Cool white
4. **calligraphy-flourish** - ✒️ Pearl/Black - High contrast
5. **illuminated-manuscript** - ✨ Cream/Gold - Gold leaf cursor
6. **invisible-ink-revealed** - 🕵️ Pale Lemon - Easter egg!

## 🛠️ Manual Theme Application

If you prefer to apply themes directly without the selector:

```bash
# Apply a specific theme
source ~/.config/terminal-themes/vampires-letter.sh

# Try different themes quickly
source ~/.config/terminal-themes/pirate-scroll.sh
echo "🏴‍☠️ Ahoy! This be pirate text!"

source ~/.config/terminal-themes/rainbow-prism.sh
echo "🌈 Taste the rainbow!"

source ~/.config/terminal-themes/ancient-papyrus.sh
echo "📜 Ancient wisdom flows..."
```

## 🌈 Running the Color Demo

To see all color capabilities:
```bash
./colored_text_demo.sh
```

This shows:
- Basic ANSI colors (red, green, blue, etc.)
- Bright/bold colors
- Rainbow text effects
- Text styles (bold, dim, underlined, reversed)
- Code syntax highlighting examples
- Git status color examples
- Background colors
- 256-color palette
- True color gradients
- ASCII art in color
- Box drawing characters
- Programming ligatures

## 💾 Making Themes Permanent

### Option 1: Use Theme Selector
When you find a theme you like, the selector asks:
```
Save to profile? [y/N]: y
```
This adds it to your shell config file.

### Option 2: Manual Addition
Add to your `~/.zshrc` or `~/.bashrc`:
```bash
# Cursive Terminal Theme
source ~/.config/terminal-themes/vampires-letter.sh
```

### Option 3: Create an Alias
Add to your shell config:
```bash
# Theme shortcuts
alias vampire='source ~/.config/terminal-themes/vampires-letter.sh'
alias pirate='source ~/.config/terminal-themes/pirate-scroll.sh'
alias rainbow='source ~/.config/terminal-themes/rainbow-prism.sh'
```

Then just type `vampire`, `pirate`, or `rainbow` to switch!

## 🎯 Pro Tips

1. **Random Theme Discovery**
   ```bash
   # Press 'r' in the selector for surprise themes!
   ```

2. **Quick Theme Testing**
   ```bash
   # Create a test loop
   for theme in vampires-letter pirate-scroll rainbow-prism; do
     source ~/.config/terminal-themes/$theme.sh
     echo "Testing $theme theme..."
     sleep 2
   done
   ```

3. **Theme of the Day**
   Add to your shell config:
   ```bash
   # Random theme on terminal start
   themes=(vampires-letter pirate-scroll ocean-mist rainbow-prism)
   random_theme=${themes[$RANDOM % ${#themes[@]}]}
   source ~/.config/terminal-themes/$random_theme.sh
   echo "Today's theme: $random_theme"
   ```

## 🔧 Troubleshooting

### Themes Not Found
```bash
# Check if themes are installed
ls ~/.config/terminal-themes/

# If empty, run:
./install-all-themes.sh
```

### Colors Not Showing
1. Ensure your terminal supports ANSI colors
2. Check terminal preferences for "ANSI Colors" option
3. Try a different terminal (iTerm2, Alacritty, etc.)

### Script Permission Errors
```bash
chmod +x *.sh
```

### Theme Not Persisting
Make sure you:
1. Saved to profile when prompted, OR
2. Added source line to correct file (~/.zshrc for zsh, ~/.bashrc for bash)
3. Restarted terminal or ran `source ~/.zshrc`

## 📱 Web Interface

For a visual theme picker:
```bash
open theme-selector-web.html
# Or: xdg-open theme-selector-web.html (Linux)
```

Features:
- Visual grid of all themes
- Live preview panel
- Click to apply
- Customization sliders
- Export theme settings

## 🎉 Quick Start Examples

```bash
# 1. See what's available
./theme-selector.sh
# Press 'h' for help

# 2. Try random themes
# Press 'r' repeatedly

# 3. Search for specific style
# Press 's', type "dark"

# 4. Apply favorite directly
# Type: vampires-letter

# 5. Browse categories
# Press '2' for all dark themes

# 6. Run color demo
./colored_text_demo.sh
```

---

Enjoy your cursive terminal experience! Every command becomes a work of art. ✨