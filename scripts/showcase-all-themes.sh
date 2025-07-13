#!/bin/bash

# Showcase all 33 Cursive Terminal themes
# This creates a visual demonstration of every theme

echo "🎨 Cursive Terminal - 33 Beautiful Themes Showcase"
echo "=================================================="

# Sample text for demonstration
show_theme_demo() {
    local theme_name="$1"
    local theme_file="$2"
    
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🎨 Theme: $theme_name"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # Apply the theme
    if [[ -f "$theme_file" ]]; then
        source "$theme_file"
        
        # Show sample text in cursive
        echo -e "\033[3m# This is how your code looks in $theme_name theme\033[0m"
        echo -e "\033[1;3mfunction \033[0;3mcreateBeautifulCode\033[0m() {"
        echo -e "  \033[3mconst message = \033[0;33m\"Coding in cursive is elegant!\"\033[0;3m;\033[0m"
        echo -e "  \033[36;3mreturn\033[0m \033[3mmessage;\033[0m"
        echo -e "}"
        
        # Show color palette
        echo ""
        echo -e "Colors: \033[31m●\033[0m \033[32m●\033[0m \033[33m●\033[0m \033[34m●\033[0m \033[35m●\033[0m \033[36m●\033[0m \033[37m●\033[0m"
        
        sleep 0.5
    else
        echo "⚠️  Theme file not found: $theme_file"
    fi
}

# Create theme directory if needed
mkdir -p ~/.config/terminal-themes

# Install all themes first
echo "📦 Installing all 33 themes..."
bash ./install-all-themes.sh >/dev/null 2>&1

echo ""
echo "🌟 Starting theme showcase..."
echo "Press Ctrl+C to stop at any time"
sleep 2

# Dark Themes (9)
echo -e "\n\033[1m=== DARK THEMES (9) ===\033[0m"
show_theme_demo "Cursive Elegance (Purple/Gold)" ~/.config/terminal-themes/cursive-elegance.sh
show_theme_demo "Cursive Noir (Black/Silver)" ~/.config/terminal-themes/cursive-noir.sh
show_theme_demo "Cursive Garden (Green/Brown)" ~/.config/terminal-themes/cursive-garden.sh
show_theme_demo "Pirate's Scroll (Brown/Gold)" ~/.config/terminal-themes/pirate-scroll.sh
show_theme_demo "Vampire's Letter (Black/Red)" ~/.config/terminal-themes/vampires-letter.sh
show_theme_demo "Ocean Mist (Blue/Teal)" ~/.config/terminal-themes/ocean-mist.sh
show_theme_demo "Sunset Glow (Orange/Pink)" ~/.config/terminal-themes/sunset-glow.sh
show_theme_demo "Forest Grove (Green/Brown)" ~/.config/terminal-themes/forest-grove.sh
show_theme_demo "Midnight Quill (Indigo/Silver)" ~/.config/terminal-themes/midnight-quill.sh

# Light Manuscript Themes (6)
echo -e "\n\033[1m=== LIGHT MANUSCRIPT THEMES (6) ===\033[0m"
show_theme_demo "Ancient Papyrus (Cream/Brown)" ~/.config/terminal-themes/ancient-papyrus.sh
show_theme_demo "Royal Parchment (Ivory/Purple)" ~/.config/terminal-themes/royal-parchment.sh
show_theme_demo "Fine Linen (Gray/Blue)" ~/.config/terminal-themes/fine-linen.sh
show_theme_demo "Calligraphy Master (White/Black)" ~/.config/terminal-themes/calligraphy-master.sh
show_theme_demo "Illuminated Manuscript (Gold/Cream)" ~/.config/terminal-themes/illuminated-manuscript.sh
show_theme_demo "Invisible Ink (UV/White)" ~/.config/terminal-themes/invisible-ink.sh

# Colorful Themes (6)
echo -e "\n\033[1m=== COLORFUL THEMES (6) ===\033[0m"
show_theme_demo "Rainbow Prism (Full Spectrum)" ~/.config/terminal-themes/rainbow-prism.sh
show_theme_demo "Neon Cyberpunk (Neon Green/Pink)" ~/.config/terminal-themes/neon-cyberpunk.sh
show_theme_demo "Tropical Paradise (Teal/Coral)" ~/.config/terminal-themes/tropical-paradise.sh
show_theme_demo "Cotton Candy (Pink/Purple)" ~/.config/terminal-themes/cotton-candy.sh
show_theme_demo "Aurora Borealis (Navy/Green)" ~/.config/terminal-themes/aurora-borealis.sh
show_theme_demo "Sunset Festival (Indigo/Orange)" ~/.config/terminal-themes/sunset-festival.sh

# Business Document Themes (6)
echo -e "\n\033[1m=== BUSINESS DOCUMENT THEMES (6) ===\033[0m"
show_theme_demo "Office Memo (Navy/White)" ~/.config/terminal-themes/office-memo.sh
show_theme_demo "Receipt Paper (Black/Beige)" ~/.config/terminal-themes/receipt-paper.sh
show_theme_demo "Carbon Copy (Indigo/Lavender)" ~/.config/terminal-themes/carbon-copy.sh
show_theme_demo "Blueprint Tech (White/Blue)" ~/.config/terminal-themes/blueprint-tech.sh
show_theme_demo "Legal Document (Brown/White)" ~/.config/terminal-themes/legal-document.sh
show_theme_demo "Ditto Spirit (Purple/Lavender)" ~/.config/terminal-themes/ditto-spirit.sh

# Feather-Light Themes (6)
echo -e "\n\033[1m=== FEATHER-LIGHT THEMES (6) - WCAG-AA COMPLIANT ===\033[0m"
show_theme_demo "Papyrus Scroll (Ochre/Brown)" ~/.config/terminal-themes/papyrus-scroll.sh
show_theme_demo "Ancient Parchment (Ivory/Sepia)" ~/.config/terminal-themes/ancient-parchment.sh
show_theme_demo "Linen Sheet (White/Charcoal)" ~/.config/terminal-themes/linen-sheet.sh
show_theme_demo "Illuminated Manuscript (Cream/Gold)" ~/.config/terminal-themes/illuminated-manuscript.sh
show_theme_demo "Calligraphy Flourish (Pearl/Black)" ~/.config/terminal-themes/calligraphy-flourish.sh
show_theme_demo "Invisible Ink (Easter Egg!)" ~/.config/terminal-themes/invisible-ink.sh

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Showcase complete! All 33 themes demonstrated."
echo ""
echo "💡 To use any theme permanently, add to your shell profile:"
echo "   echo 'source ~/.config/terminal-themes/THEME-NAME.sh' >> ~/.zshrc"
echo ""
echo "🎯 Next steps:"
echo "   1. Choose your favorite theme"
echo "   2. Run: ./theme-selector.sh for interactive selection"
echo "   3. Support development: https://github.com/sponsors/midnightnow"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"