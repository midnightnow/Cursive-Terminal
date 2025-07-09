#!/bin/bash

# Create a theme grid showcase image using ImageMagick

OUTPUT_DIR="/Users/studio/Cursive-Terminal/docs/images"
THEME_DIR="/Users/studio/Cursive-Terminal/docs/images/theme-demos"

echo "🎨 Creating theme grid showcase..."

# Check if ImageMagick is installed
if ! command -v montage &> /dev/null; then
    echo "❌ ImageMagick not found. Install with: brew install imagemagick"
    exit 1
fi

# Create a 6x6 grid of theme screenshots
# First, let's create a list of all theme images
THEME_IMAGES=""
THEMES=(
    "vampires-letter"
    "pirate-scroll"
    "cursive-elegance"
    "ocean-mist"
    "ancient-papyrus"
    "rainbow-prism"
    "cursive-noir"
    "sunset-glow"
    "calligraphy-scroll"
    "neon-cyberpunk"
    "forest-grove"
    "tropical-paradise"
    "midnight-quill"
    "illuminated-manuscript"
    "cotton-candy"
    "cursive-garden"
    "ivory-parchment"
    "aurora-borealis"
    "office-memo"
    "linen-manuscript"
    "sunset-festival"
    "receipt-paper"
    "invisible-ink"
    "blueprint-tech"
    "carbon-copy"
    "papyrus-scroll"
    "legal-document"
    "ancient-parchment"
    "ditto-spirit"
    "linen-sheet"
    "calligraphy-flourish"
    "invisible-ink-revealed"
    "cursive-elegance"  # Fill remaining spots
)

# Collect existing images
for theme in "${THEMES[@]}"; do
    if [[ -f "$THEME_DIR/$theme/demo.png" ]]; then
        THEME_IMAGES="$THEME_IMAGES $THEME_DIR/$theme/demo.png"
    fi
done

# Create the montage
echo "📸 Creating 6x5 grid montage..."
montage $THEME_IMAGES \
    -geometry 400x250+5+5 \
    -tile 6x5 \
    -background "#0a0a0a" \
    -bordercolor "#333333" \
    -border 1 \
    -shadow \
    "$OUTPUT_DIR/theme-gallery-grid.png"

echo "✅ Theme grid created: $OUTPUT_DIR/theme-gallery-grid.png"

# Create smaller preview grids for README
echo "📸 Creating feature preview grids..."

# Dark themes preview (3x1)
montage \
    "$THEME_DIR/vampires-letter/demo.png" \
    "$THEME_DIR/pirate-scroll/demo.png" \
    "$THEME_DIR/midnight-quill/demo.png" \
    -geometry 300x200+5+5 \
    -tile 3x1 \
    -background "#0a0a0a" \
    "$OUTPUT_DIR/dark-themes-preview.png"

# Light themes preview (3x1)
montage \
    "$THEME_DIR/ancient-papyrus/demo.png" \
    "$THEME_DIR/calligraphy-scroll/demo.png" \
    "$THEME_DIR/illuminated-manuscript/demo.png" \
    -geometry 300x200+5+5 \
    -tile 3x1 \
    -background "#f5f5f5" \
    "$OUTPUT_DIR/light-themes-preview.png"

# Colorful themes preview (3x1)
montage \
    "$THEME_DIR/rainbow-prism/demo.png" \
    "$THEME_DIR/neon-cyberpunk/demo.png" \
    "$THEME_DIR/tropical-paradise/demo.png" \
    -geometry 300x200+5+5 \
    -tile 3x1 \
    -background "#1a1a1a" \
    "$OUTPUT_DIR/colorful-themes-preview.png"

echo "✅ All theme showcases created!"
echo ""
echo "Created files:"
echo "  - theme-gallery-grid.png (Full 6x5 grid)"
echo "  - dark-themes-preview.png (3 dark themes)"
echo "  - light-themes-preview.png (3 light themes)"
echo "  - colorful-themes-preview.png (3 colorful themes)"