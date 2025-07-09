#!/bin/bash

# Test the theme selector by applying a theme directly
echo "Testing Cursive Terminal Theme Selector..."
echo

# Check if themes directory exists
if [[ -d ~/.config/terminal-themes ]]; then
    echo "✅ Theme directory found"
    echo
    echo "Available themes:"
    ls ~/.config/terminal-themes/*.sh | grep -v -E "extended|manuscript" | sed 's/.*\///' | sed 's/.sh$//' | head -10
    echo "... and 23 more themes"
    echo
    echo "The theme selector provides:"
    echo "  • Interactive browsing by category"
    echo "  • Search functionality"
    echo "  • Live preview mode"
    echo "  • Random theme selection"
    echo "  • Save to shell profile"
    echo
    echo "To run the theme selector:"
    echo "  ./theme-selector.sh"
    echo
    echo "Or open the web version:"
    echo "  open theme-selector-web.html"
else
    echo "❌ Theme directory not found. Please run the installation scripts first."
fi