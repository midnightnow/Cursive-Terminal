# 📸 Theme Demo Generation Instructions

## Overview
Generate beautiful 1-page demo for each of the 33 cursive terminal themes, including screenshots, color palettes, and live examples.

## Step 1: Prepare Environment

```bash
# 1. Navigate to scripts directory
cd /Users/studio/Cursive-Terminal/scripts

# 2. Make scripts executable
chmod +x generate-theme-demos.sh
chmod +x generate-theme-screenshots.sh

# 3. Install dependencies (if needed)
# - iTerm2 or Terminal.app
# - Victor Mono font
# - ImageMagick (for screenshot processing)
brew install imagemagick
```

## Step 2: Generate HTML Demo Pages

```bash
# Generate all theme demo pages
./generate-theme-demos.sh /Users/studio/Cursive-Terminal/docs/themes

# This creates:
# - docs/themes/index.html (main gallery)
# - docs/themes/[theme-name].html (33 individual pages)
```

## Step 3: Create Theme Screenshots

### Automated Screenshot Script
Create `generate-theme-screenshots.sh`:

```bash
#!/bin/bash

# Theme Screenshot Generator
THEMES=(
    "cursive-elegance"
    "cursive-noir"
    "cursive-garden"
    "pirate-scroll"
    "vampires-letter"
    "ocean-mist"
    "sunset-glow"
    "forest-grove"
    "midnight-quill"
    "ancient-papyrus"
    "ivory-parchment"
    "linen-manuscript"
    "calligraphy-scroll"
    "illuminated-manuscript"
    "invisible-ink"
    "rainbow-prism"
    "neon-cyberpunk"
    "tropical-paradise"
    "cotton-candy"
    "aurora-borealis"
    "sunset-festival"
    "office-memo"
    "receipt-paper"
    "carbon-copy"
    "blueprint-tech"
    "legal-document"
    "ditto-spirit"
    "papyrus-scroll"
    "ancient-parchment"
    "linen-sheet"
    "calligraphy-flourish"
    "invisible-ink-revealed"
)

OUTPUT_DIR="/Users/studio/Cursive-Terminal/docs/images/theme-demos"

for theme in "${THEMES[@]}"; do
    echo "📸 Capturing $theme..."
    
    # Create theme directory
    mkdir -p "$OUTPUT_DIR/$theme"
    
    # Apply theme
    source ~/.config/terminal-themes/$theme.sh
    
    # Clear terminal
    clear
    
    # Display demo content
    cat << 'DEMO'
╔════════════════════════════════════════════════════════════════╗
║                  Cursive Terminal Theme Demo                   ║
╚════════════════════════════════════════════════════════════════╝

// JavaScript Example
function createBeautifulCode() {
  const theme = 'cursive-terminal';
  const style = 'italic';
  
  return {
    elegant: true,
    readable: true,
    artistic: true
  };
}

# Python Example
def generate_art():
    """Create beautiful cursive code"""
    colors = ['red', 'green', 'blue']
    for color in colors:
        print(f"Beautiful {color} text")

<!-- HTML Example -->
<div class="cursive-demo">
  <h1>Welcome to Cursive Coding</h1>
  <p>Where every line is a work of art</p>
</div>

$ git status
✓ modified:   src/components/Theme.jsx
✓ new file:   src/themes/cursive.css
? untracked:  docs/demo.md

[SUCCESS] Theme applied successfully!
DEMO
    
    # Wait for terminal to render
    sleep 1
    
    # Take screenshot (macOS)
    # You'll need to use screencapture or similar tool
    # screencapture -x -t png "$OUTPUT_DIR/$theme/demo.png"
    
    # For now, print instruction
    echo "   📷 Please take screenshot and save as:"
    echo "      $OUTPUT_DIR/$theme/demo.png"
    echo "   Press Enter when done..."
    read
done

echo "✅ Screenshot generation complete!"
```

### Manual Screenshot Process

For each theme:

1. **Apply Theme**
   ```bash
   source ~/.config/terminal-themes/vampires-letter.sh
   ```

2. **Run Demo Content**
   ```bash
   # Option 1: Color demo
   ./colored_text_demo.sh
   
   # Option 2: Code sample
   cat << 'EOF'
   // Vampires Letter Theme
   function darkMagic() {
     const blood = '#FF0033';
     const velvet = '#0B0A0C';
     return `Coding in the shadows...`;
   }
   EOF
   ```

3. **Capture Screenshot**
   - **macOS**: Cmd+Shift+4, then Space, click terminal window
   - **Name**: `theme-name-demo.png`
   - **Save to**: `docs/images/theme-demos/[theme-name]/`

## Step 4: Generate Color Palettes

Create color palette images for each theme:

```python
# generate_color_palettes.py
from PIL import Image, ImageDraw, ImageFont

themes = {
    'vampires-letter': {
        'bg': '#0B0A0C',
        'fg': '#F8F8F8',
        'cursor': '#FF0033',
        'colors': ['#0B0A0C', '#FF0033', '#8B0000', '#B22222', '#4B0082', '#800080', '#DC143C', '#F8F8F8']
    },
    # Add all 33 themes...
}

for theme_name, colors in themes.items():
    # Create 800x200 image
    img = Image.new('RGB', (800, 200), color='white')
    draw = ImageDraw.Draw(img)
    
    # Draw color swatches
    x = 50
    for i, color in enumerate(colors['colors']):
        draw.rectangle([x, 50, x+80, 150], fill=color)
        x += 100
    
    img.save(f'docs/images/theme-demos/{theme_name}/palette.png')
```

## Step 5: Create Demo GIFs

For dynamic demos:

```bash
# Record terminal session
asciinema rec theme-demo.cast

# Apply theme and run demos
source ~/.config/terminal-themes/rainbow-prism.sh
./colored_text_demo.sh

# Stop recording (Ctrl+D)

# Convert to GIF
agg theme-demo.cast theme-demo.gif --theme monokai
```

## Step 6: Optimize Images

```bash
# Optimize all PNGs
find docs/images/theme-demos -name "*.png" -exec optipng {} \;

# Convert to WebP for faster loading
for img in docs/images/theme-demos/*/*.png; do
    cwebp -q 80 "$img" -o "${img%.png}.webp"
done
```

## Step 7: Deploy to GitHub Pages

```bash
# 1. Commit all changes
git add docs/
git commit -m "Add theme gallery with demos for all 33 themes"

# 2. Push to main branch
git push origin main

# 3. Enable GitHub Pages
# Go to Settings > Pages > Source: Deploy from branch (main) > /docs

# 4. Access at:
# https://midnightnow.github.io/Cursive-Terminal/themes/
```

## Quick Commands Summary

```bash
# 1. Generate HTML pages
./generate-theme-demos.sh

# 2. For each theme, capture screenshot:
source ~/.config/terminal-themes/THEME_NAME.sh
clear
./colored_text_demo.sh
# Take screenshot

# 3. Create a batch processor for all themes
for theme in vampires-letter pirate-scroll ocean-mist; do
    echo "Processing $theme..."
    source ~/.config/terminal-themes/$theme.sh
    clear
    echo "Theme: $theme"
    echo "Take screenshot now!"
    read -p "Press Enter when done..."
done

# 4. Deploy
git add -A
git commit -m "Add theme demos"
git push
```

## Theme Demo Content Ideas

1. **Code Samples**: Show syntax highlighting
2. **Git Status**: Demonstrate color coding
3. **Directory Listing**: File type colors
4. **ASCII Art**: Theme-specific art
5. **Color Palette**: All 16 ANSI colors
6. **Special Characters**: Ligatures and symbols

## Marketing Assets

Create these for social media:

1. **Hero Grid**: 6x6 grid of all themes
2. **Before/After**: Monospace vs Cursive
3. **Category Showcases**: One image per category
4. **Animation**: Theme switcher GIF
5. **Code Poetry**: Beautiful code snippets

---

Ready to showcase your 33 beautiful cursive themes! 🎨✨