#!/bin/bash

# Complete Cursive Terminal Installation Script
# Installs all fonts, tools, and configurations

set -e  # Exit on error

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Functions
print_status() {
    echo -e "${BLUE}==>${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Header
clear
echo "✒️  Cursive Terminal Complete Setup"
echo "==================================="
echo ""

# Check for Homebrew
print_status "Checking for Homebrew..."
if ! command -v brew &> /dev/null; then
    print_error "Homebrew not found!"
    echo "Please install Homebrew first:"
    echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi
print_success "Homebrew found"

# Install fonts
print_status "Installing cursive fonts..."
fonts=(
    "font-victor-mono"
    "font-cascadia-code"
    "font-jetbrains-mono"
    "font-fira-code"
)

for font in "${fonts[@]}"; do
    if brew list --cask "$font" &> /dev/null; then
        print_success "$font already installed"
    else
        print_status "Installing $font..."
        brew install --cask "$font" || print_warning "Failed to install $font"
    fi
done

# Install terminal tools
print_status "Installing terminal enhancement tools..."
tools=(
    "starship"    # Beautiful prompt
    "bat"         # Better cat with syntax highlighting
    "eza"         # Better ls with icons
    "figlet"      # ASCII art text
    "lolcat"      # Rainbow colors
)

for tool in "${tools[@]}"; do
    if brew list "$tool" &> /dev/null; then
        print_success "$tool already installed"
    else
        print_status "Installing $tool..."
        brew install "$tool" || print_warning "Failed to install $tool"
    fi
done

# Install zsh-syntax-highlighting
print_status "Installing zsh syntax highlighting..."
if [[ ! -d "/opt/homebrew/share/zsh-syntax-highlighting" ]]; then
    brew install zsh-syntax-highlighting
    print_success "zsh-syntax-highlighting installed"
else
    print_success "zsh-syntax-highlighting already installed"
fi

# Create config directories
print_status "Creating configuration directories..."
mkdir -p ~/.config/terminal-themes
mkdir -p ~/.config/nvim

# Copy configurations
print_status "Installing configurations..."

# Copy themes
if [[ -f "themes/cursive_terminal_themes.sh" ]]; then
    ./themes/cursive_terminal_themes.sh
    print_success "Terminal themes installed"
fi

# Copy Neovim config
if [[ -f "configs/cursive_neovim_config.lua" ]]; then
    cp configs/cursive_neovim_config.lua ~/.config/nvim/cursive.lua
    print_success "Neovim configuration installed"
fi

# Copy Starship config
if [[ -f "configs/starship.toml" ]]; then
    cp configs/starship.toml ~/.config/starship.toml
    print_success "Starship configuration installed"
fi

# Setup shell configuration
print_status "Configuring shell..."

# Backup existing .zshrc
if [[ -f ~/.zshrc ]]; then
    cp ~/.zshrc ~/.zshrc.backup-$(date +%Y%m%d-%H%M%S)
    print_success "Backed up existing .zshrc"
fi

# Add cursive configurations to .zshrc
if ! grep -q "CURSIVE TERMINAL SETUP" ~/.zshrc 2>/dev/null; then
    cat >> ~/.zshrc << 'EOF'

# ===== CURSIVE TERMINAL SETUP =====
# Beautiful cursive terminal environment

# Starship prompt
eval "$(starship init zsh)"

# Syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# Enhanced aliases
alias ls='eza --icons --git'
alias ll='eza --icons --git -l'
alias la='eza --icons --git -la'
alias cat='bat'

# Cursive demos
alias cursive-demo='~/cursive-terminal-setup/scripts/cursive_font_demo.sh'
alias font-compare='~/cursive-terminal-setup/scripts/font_comparison.sh'
alias cursive-showcase='~/cursive-terminal-setup/scripts/showcase.sh'

# Quick font test
alias test-cursive='echo -e "Regular text \e[3mBeautiful cursive text\e[0m back to regular"'

EOF
    print_success "Shell configuration added"
else
    print_warning "Cursive configuration already exists in .zshrc"
fi

# Make all scripts executable
chmod +x scripts/*.sh 2>/dev/null

# Final setup
echo ""
print_success "Installation complete!"
echo ""
echo "🎯 Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Set your terminal font to 'Victor Mono Italic'"
echo "  3. Run 'cursive-showcase' to see the magic!"
echo ""
echo "📚 Available commands:"
echo "  • cursive-demo     - Test cursive rendering"
echo "  • font-compare     - Compare different fonts"
echo "  • cursive-showcase - Full feature demonstration"
echo ""
echo "Enjoy your beautiful cursive terminal! ✨"