#!/bin/bash

# Font Comparison Script
# Shows the same text in different fonts for easy comparison

clear

echo "✒️  CURSIVE FONT COMPARISON"
echo "=========================="
echo ""
echo "To see the differences, change your terminal font to each one:"
echo ""

# Test text samples
SAMPLE_TEXT="The quick brown fox jumps over the lazy dog"
CODE_SAMPLE="const greeting = 'Hello, Cursive World!';"
SYMBOLS="-> => != === ++ -- <= >= <> ..."

# Function to display font test
show_font() {
    local font_name=$1
    local description=$2
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🔤 $font_name"
    echo "   $description"
    echo ""
    echo "   Regular: $SAMPLE_TEXT"
    echo -e "   \e[3mItalic:  $SAMPLE_TEXT\e[0m"
    echo -e "   \e[1mBold:    $SAMPLE_TEXT\e[0m"
    echo -e "   \e[1;3mBold It: $SAMPLE_TEXT\e[0m"
    echo ""
    echo -e "   Code: \e[3m$CODE_SAMPLE\e[0m"
    echo "   Symbols: $SYMBOLS"
    echo ""
}

# Display all fonts
show_font "Victor Mono" "⭐ Most cursive - beautiful semi-connected script"
show_font "Cascadia Code" "Elegant cursive with clean ligatures"
show_font "JetBrains Mono" "Subtle cursive, great for long coding"
show_font "Fira Code" "Not cursive but amazing ligatures"
show_font "SF Mono Oblique" "Custom slanted (created with our script)"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "💡 TIP: Set each font in your terminal preferences"
echo "        to see the actual rendering differences!"
echo ""
echo "🎯 For full cursive: Use the Italic variant as main font"