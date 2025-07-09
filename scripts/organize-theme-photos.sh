#!/bin/bash

# Organize theme photos into proper directory structure

SOURCE_DIR="/Users/studio/Cursive-Terminal/docs/Theme Photos"
TARGET_DIR="/Users/studio/Cursive-Terminal/docs/images/theme-demos"

echo "📸 Organizing theme photos..."

# Map of display names to theme names
declare -A THEME_MAP=(
    ["Ancient Papyrus"]="ancient-papyrus"
    ["Ancient Parchment"]="ancient-parchment"
    ["Aurora Borealis"]="aurora-borealis"
    ["Calligraphy Flourish"]="calligraphy-flourish"
    ["Calligraphy Scroll"]="calligraphy-scroll"
    ["Carbon Copy"]="carbon-copy"
    ["Cursive Elegance"]="cursive-elegance"
    ["Cursive Garden"]="cursive-garden"
    ["Cursive Noir"]="cursive-noir"
    ["Ditto Spirit"]="ditto-spirit"
    ["Illuminated Manuscript"]="illuminated-manuscript"
    ["Invisible Ink"]="invisible-ink"
    ["Invisible Ink Revealed"]="invisible-ink-revealed"
    ["Ivory Parchment"]="ivory-parchment"
    ["Legal Document"]="legal-document"
    ["Linen Manuscript"]="linen-manuscript"
    ["Midnight Quill"]="midnight-quill"
    ["Neon Cyberpunk"]="neon-cyberpunk"
    ["Ocean Mist"]="ocean-mist"
    ["Office Memo"]="office-memo"
    ["Papyrus Scroll"]="papyrus-scroll"
    ["Pirate Scroll"]="pirate-scroll"
    ["Rainbow Prism"]="rainbow-prism"
    ["Receipt Paper"]="receipt-paper"
    ["Sunset Festival"]="sunset-festival"
    ["Sunset Glow"]="sunset-glow"
    ["Tropical Paradise"]="tropical-paradise"
    ["Vampire's Letter"]="vampires-letter"
)

# Create target directories and copy files
for display_name in "${!THEME_MAP[@]}"; do
    theme_name="${THEME_MAP[$display_name]}"
    source_file="$SOURCE_DIR/$display_name.png"
    target_dir="$TARGET_DIR/$theme_name"
    
    if [[ -f "$source_file" ]]; then
        mkdir -p "$target_dir"
        cp "$source_file" "$target_dir/demo.png"
        echo "✅ Copied: $display_name -> $theme_name/demo.png"
    else
        echo "❌ Not found: $source_file"
    fi
done

# Check for any missing themes
echo ""
echo "📊 Summary:"
echo "Total themes expected: 33"
echo "Photos found: $(ls "$SOURCE_DIR"/*.png 2>/dev/null | wc -l)"
echo ""

# List any photos not mapped
echo "🔍 Checking for unmapped photos..."
for photo in "$SOURCE_DIR"/*.png; do
    basename_photo=$(basename "$photo" .png)
    found=false
    for display_name in "${!THEME_MAP[@]}"; do
        if [[ "$basename_photo" == "$display_name" ]]; then
            found=true
            break
        fi
    done
    if [[ "$found" == "false" ]]; then
        echo "⚠️  Unmapped photo: $basename_photo"
    fi
done

echo ""
echo "✅ Photo organization complete!"
echo "📁 Photos organized in: $TARGET_DIR"