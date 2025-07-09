#!/bin/bash

# Theme Screenshot Capture Helper
# Helps you systematically capture screenshots for each theme

set -euo pipefail

# All 33 themes
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

echo "📸 Theme Screenshot Capture Helper"
echo "================================="
echo ""
echo "This script will guide you through capturing screenshots for each theme."
echo "For each theme:"
echo "  1. The theme will be applied"
echo "  2. Demo content will be displayed"
echo "  3. You take a screenshot (Cmd+Shift+4, then Space, click terminal)"
echo "  4. Save as: $OUTPUT_DIR/[theme-name]/demo.png"
echo ""
echo "Press Enter to begin..."
read

# Create output directories
for theme in "${THEMES[@]}"; do
    mkdir -p "$OUTPUT_DIR/$theme"
done

# Function to display demo content
show_demo_content() {
    local theme_name="$1"
    
    clear
    cat << EOF
╔════════════════════════════════════════════════════════════════╗
║                 🎨 $theme_name Theme Demo 🎨                   ║
╚════════════════════════════════════════════════════════════════╝

// Cursive Terminal - Beautiful Code in Italic

function createMagic() {
  const theme = '$theme_name';
  const style = 'italic';
  const font = 'Victor Mono';
  
  return {
    beautiful: true,
    readable: true,
    artistic: true
  };
}

// Example with syntax highlighting
const colors = ['red', 'green', 'blue', 'yellow', 'magenta'];
colors.forEach(color => {
  console.log(\`Beautiful \${color} cursive text\`);
});

# Git status example
$ git status
✓ modified:   src/components/Theme.jsx
✓ new file:   src/themes/$theme_name.css
? untracked:  docs/screenshots/

// Special characters and ligatures
=> != === ++ -- <= >= <> ... :: -> |>

╭─────────────────────────────────────────────────────╮
│ "Code is poetry, and cursive makes it beautiful"    │
╰─────────────────────────────────────────────────────╯

[SUCCESS] Theme '$theme_name' applied successfully! ✨
EOF
}

# Process each theme
for i in "${!THEMES[@]}"; do
    theme="${THEMES[$i]}"
    echo ""
    echo "📸 Theme $((i+1))/33: $theme"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # Apply theme
    if [[ -f ~/.config/terminal-themes/$theme.sh ]]; then
        source ~/.config/terminal-themes/$theme.sh
        echo "✅ Theme applied"
    else
        echo "❌ Theme file not found, skipping..."
        continue
    fi
    
    # Show demo content
    show_demo_content "$theme"
    
    echo ""
    echo "📷 Please take a screenshot now:"
    echo "   1. Press Cmd+Shift+4"
    echo "   2. Press Space"
    echo "   3. Click on the terminal window"
    echo "   4. Save as: $OUTPUT_DIR/$theme/demo.png"
    echo ""
    echo "Press Enter when done (or 's' to skip)..."
    read response
    
    if [[ "$response" == "s" ]]; then
        echo "⏭️  Skipped $theme"
    else
        echo "✅ Screenshot saved for $theme"
    fi
done

echo ""
echo "🎉 Screenshot capture complete!"
echo ""
echo "Next steps:"
echo "1. Review screenshots in: $OUTPUT_DIR"
echo "2. Optimize images: find $OUTPUT_DIR -name '*.png' -exec optipng {} \;"
echo "3. Commit and push to GitHub"
echo "4. Deploy to GitHub Pages"