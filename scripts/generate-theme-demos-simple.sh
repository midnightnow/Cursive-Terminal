#!/bin/bash

# Simple Theme Demo Generator for Cursive Terminal
set -euo pipefail

# Output directory
OUTPUT_DIR="${1:-/Users/studio/Cursive-Terminal/docs/themes}"
mkdir -p "$OUTPUT_DIR"

echo "🎨 Generating theme demo pages..."

# Create a simple function to generate each theme page
generate_theme_page() {
    local theme_name="$1"
    local display_name="$2"
    local category="$3"
    local bg_color="$4"
    local fg_color="$5"
    local cursor_color="$6"
    
    echo "  📄 Generating: $theme_name.html"
    
    # Read template and replace placeholders
    cat /Users/studio/Cursive-Terminal/scripts/theme-demo-template.html | \
    sed "s/{{THEME_NAME}}/$theme_name/g" | \
    sed "s/{{THEME_DISPLAY_NAME}}/$display_name/g" | \
    sed "s/{{THEME_DESCRIPTION}}/${display_name#* }/g" | \
    sed "s/{{THEME_CATEGORY}}/$category themes/g" | \
    sed "s/{{BG_COLOR}}/$bg_color/g" | \
    sed "s/{{FG_COLOR}}/$fg_color/g" | \
    sed "s/{{CURSOR_COLOR}}/$cursor_color/g" | \
    sed "s/{{CONTRAST_INFO}}/Optimized for comfortable viewing/g" | \
    sed "s/{{COLOR_0}}/#000000/g" | \
    sed "s/{{COLOR_1}}/#FF0000/g" | \
    sed "s/{{COLOR_2}}/#00FF00/g" | \
    sed "s/{{COLOR_3}}/#FFFF00/g" | \
    sed "s/{{COLOR_4}}/#0000FF/g" | \
    sed "s/{{COLOR_5}}/#FF00FF/g" | \
    sed "s/{{COLOR_6}}/#00FFFF/g" | \
    sed "s/{{COLOR_7}}/#FFFFFF/g" | \
    sed "s|{{SCREENSHOTS}}|<div class=\"screenshot\"><img src=\"../images/theme-demos/$theme_name/demo.png\" alt=\"$display_name demo\"></div>|g" \
    > "$OUTPUT_DIR/$theme_name.html"
}

# Generate all theme pages
generate_theme_page "cursive-elegance" "✨ Cursive Elegance" "dark" "#1a1a2e" "#e8e3e3" "#ffd700"
generate_theme_page "cursive-noir" "⚫ Cursive Noir" "dark" "#0a0a0a" "#c0c0c0" "#ffffff"
generate_theme_page "cursive-garden" "🌿 Cursive Garden" "dark" "#1a1f1a" "#e0e5d0" "#8fbc8f"
generate_theme_page "pirate-scroll" "🏴‍☠️ Pirate Scroll" "dark" "#341A0F" "#FFEBCD" "#FFD700"
generate_theme_page "vampires-letter" "🧛 Vampires Letter" "dark" "#0B0A0C" "#F8F8F8" "#FF0033"
generate_theme_page "ocean-mist" "🌊 Ocean Mist" "dark" "#012B36" "#E0F7FA" "#00C2D1"
generate_theme_page "sunset-glow" "🌅 Sunset Glow" "dark" "#2E1503" "#FFF8E7" "#FFA500"
generate_theme_page "forest-grove" "🌲 Forest Grove" "dark" "#0B190D" "#E8F5E9" "#8FBC8F"
generate_theme_page "midnight-quill" "🌙 Midnight Quill" "dark" "#0A0F1A" "#EAEAEA" "#6A5ACD"
generate_theme_page "ancient-papyrus" "📜 Ancient Papyrus" "light" "#F5E6D3" "#4B3621" "#8B4513"
generate_theme_page "ivory-parchment" "🏛️ Ivory Parchment" "light" "#FFFFF0" "#4B0082" "#800080"
generate_theme_page "linen-manuscript" "🧵 Linen Manuscript" "light" "#FAF0E6" "#2F4F4F" "#708090"
generate_theme_page "calligraphy-scroll" "✒️ Calligraphy Scroll" "light" "#FDFCFA" "#000000" "#FF0000"
generate_theme_page "illuminated-manuscript" "🎨 Illuminated Manuscript" "light" "#FFF8DC" "#8B4513" "#FFD700"
generate_theme_page "invisible-ink" "🔍 Invisible Ink" "light" "#F8F8FF" "#4B0082" "#9400D3"
generate_theme_page "rainbow-prism" "🌈 Rainbow Prism" "colorful" "#1A1A1A" "#FFFFFF" "#FF00FF"
generate_theme_page "neon-cyberpunk" "⚡ Neon Cyberpunk" "colorful" "#000000" "#00FF00" "#00FFFF"
generate_theme_page "tropical-paradise" "🌺 Tropical Paradise" "colorful" "#006B76" "#FFFFFF" "#FF6F61"
generate_theme_page "cotton-candy" "🍭 Cotton Candy" "colorful" "#FFE5F1" "#4A0E4E" "#FF69B4"
generate_theme_page "aurora-borealis" "🌌 Aurora Borealis" "colorful" "#001F3F" "#E8F8F5" "#00FF7F"
generate_theme_page "sunset-festival" "🎪 Sunset Festival" "colorful" "#4B0082" "#FFF8DC" "#FF8C00"
generate_theme_page "office-memo" "📄 Office Memo" "business" "#FFFFFF" "#000080" "#0000FF"
generate_theme_page "receipt-paper" "🧾 Receipt Paper" "business" "#F5F5DC" "#1C1C1C" "#000000"
generate_theme_page "carbon-copy" "📑 Carbon Copy" "business" "#E6E6FA" "#4B0082" "#6A0DAD"
generate_theme_page "blueprint-tech" "📐 Blueprint Tech" "business" "#003366" "#FFFFFF" "#00FFFF"
generate_theme_page "legal-document" "⚖️ Legal Document" "business" "#FFFEF7" "#3B2F2F" "#8B4513"
generate_theme_page "ditto-spirit" "🖨️ Ditto Spirit" "business" "#E6E6FA" "#6A0DAD" "#9370DB"
generate_theme_page "papyrus-scroll" "📜 Papyrus Scroll WCAG" "feather" "#F4E4C1" "#5A4632" "#D7B66D"
generate_theme_page "ancient-parchment" "🦴 Ancient Parchment WCAG" "feather" "#F8F5EC" "#594A36" "#D4B483"
generate_theme_page "linen-sheet" "🧵 Linen Sheet WCAG" "feather" "#FBFAF7" "#4F4F4A" "#A4B69F"
generate_theme_page "calligraphy-flourish" "✒️ Calligraphy Flourish" "feather" "#FCFCFC" "#1F1F1F" "#7571E6"
generate_theme_page "invisible-ink-revealed" "🕵️ Invisible Ink Revealed" "feather" "#FFFFF2" "#FFFFF2" "#F7E96B"

echo "✅ Generated theme demo pages"
echo "📁 Output directory: $OUTPUT_DIR"