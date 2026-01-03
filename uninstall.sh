#!/bin/bash

# Cursive Terminal Uninstall Script
# Cleanly removes all Cursive Terminal components

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_status() { echo -e "${BLUE}==>${NC} $1"; }
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }

# Header
clear
echo "✒️  Cursive Terminal Uninstaller"
echo "================================"
echo ""

# Confirm
echo -e "${YELLOW}This will remove Cursive Terminal configurations.${NC}"
echo ""
read -p "Remove configs only? [Y/n/full] (full = also remove brew packages): " choice
choice=${choice:-Y}

# Function to remove zshrc section
remove_zshrc_config() {
    if [[ -f ~/.zshrc ]]; then
        if grep -q "CURSIVE TERMINAL SETUP" ~/.zshrc; then
            # Backup first
            cp ~/.zshrc ~/.zshrc.pre-uninstall-$(date +%Y%m%d-%H%M%S)
            print_success "Backed up .zshrc"

            # Remove the cursive section (from marker to next blank line or EOF)
            sed -i '' '/# ===== CURSIVE TERMINAL SETUP =====/,/^# =====/d' ~/.zshrc 2>/dev/null || \
            sed -i '' '/# ===== CURSIVE TERMINAL SETUP =====/,$d' ~/.zshrc
            print_success "Removed Cursive Terminal config from .zshrc"
        else
            print_warning "No Cursive Terminal config found in .zshrc"
        fi
    fi
}

# Function to remove config files
remove_configs() {
    print_status "Removing configuration files..."

    # Terminal themes
    if [[ -d ~/.config/terminal-themes ]]; then
        rm -rf ~/.config/terminal-themes
        print_success "Removed ~/.config/terminal-themes"
    fi

    # Neovim cursive config
    if [[ -f ~/.config/nvim/cursive.lua ]]; then
        rm -f ~/.config/nvim/cursive.lua
        print_success "Removed ~/.config/nvim/cursive.lua"
    fi

    # Starship config (only if it's ours)
    if [[ -f ~/.config/starship.toml ]]; then
        if grep -q "Cursive Terminal" ~/.config/starship.toml 2>/dev/null; then
            rm -f ~/.config/starship.toml
            print_success "Removed ~/.config/starship.toml"
        else
            print_warning "Keeping ~/.config/starship.toml (custom config detected)"
        fi
    fi
}

# Function to remove brew packages
remove_brew_packages() {
    print_status "Removing Homebrew packages..."

    # Fonts
    fonts=("font-victor-mono" "font-cascadia-code" "font-jetbrains-mono" "font-fira-code")
    for font in "${fonts[@]}"; do
        if brew list --cask "$font" &>/dev/null; then
            brew uninstall --cask "$font" 2>/dev/null && \
                print_success "Removed $font" || \
                print_warning "Failed to remove $font"
        fi
    done

    # Tools (ask first since user might want to keep them)
    tools=("starship" "bat" "eza" "figlet" "lolcat" "zsh-syntax-highlighting")
    echo ""
    echo -e "${YELLOW}The following tools were installed by Cursive Terminal:${NC}"
    for tool in "${tools[@]}"; do
        if brew list "$tool" &>/dev/null; then
            echo "  - $tool"
        fi
    done
    echo ""
    read -p "Remove these tools? [y/N]: " remove_tools

    if [[ "$remove_tools" =~ ^[Yy]$ ]]; then
        for tool in "${tools[@]}"; do
            if brew list "$tool" &>/dev/null; then
                brew uninstall "$tool" 2>/dev/null && \
                    print_success "Removed $tool" || \
                    print_warning "Failed to remove $tool"
            fi
        done
    else
        print_warning "Keeping CLI tools"
    fi
}

# Execute based on choice
case "$choice" in
    [Yy]*)
        remove_zshrc_config
        remove_configs
        ;;
    [Ff]ull|full|FULL)
        remove_zshrc_config
        remove_configs
        remove_brew_packages
        ;;
    [Nn]*)
        echo "Uninstall cancelled."
        exit 0
        ;;
    *)
        remove_zshrc_config
        remove_configs
        ;;
esac

# Done
echo ""
print_success "Uninstall complete!"
echo ""
echo "To finish cleanup:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Reset your terminal font to default if desired"
echo ""
echo "To reinstall later: ./install.sh"
