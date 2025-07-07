#!/bin/bash

echo "✒️  Cursive Terminal Quick Setup"
echo "================================"
echo ""

# Install fonts
echo "📦 Installing cursive fonts..."
brew install font-victor-mono font-cascadia-code font-jetbrains-mono 2>/dev/null || {
    echo "❌ Homebrew not found. Please install fonts manually."
}

# Copy configs
echo "📁 Setting up configurations..."
mkdir -p ~/.config/nvim
cp configs/cursive_neovim_config.lua ~/.config/nvim/cursive.lua 2>/dev/null

# Run demo
echo ""
echo "✅ Setup complete! Now:"
echo "1. Set your terminal font to 'Victor Mono Italic'"
echo "2. Run: ./scripts/cursive_font_demo.sh"
echo ""