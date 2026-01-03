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

# Function to reset terminal colors to defaults
reset_terminal_colors() {
    print_status "Resetting terminal colors to defaults..."

    # Reset all 256 colors to defaults
    printf '\033]104\007'

    # Reset foreground, background, cursor
    printf '\033]110\007'  # Reset foreground
    printf '\033]111\007'  # Reset background
    printf '\033]112\007'  # Reset cursor color

    # Reset text attributes (bold, italic, underline off)
    printf '\033[0m'

    print_success "Terminal colors reset to defaults"
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

    # Fonts - individual selection
    fonts=("font-victor-mono" "font-cascadia-code" "font-jetbrains-mono" "font-fira-code")
    installed_fonts=()

    for font in "${fonts[@]}"; do
        if brew list --cask "$font" &>/dev/null; then
            installed_fonts+=("$font")
        fi
    done

    if [[ ${#installed_fonts[@]} -gt 0 ]]; then
        echo ""
        echo -e "${YELLOW}Installed fonts:${NC}"
        for i in "${!installed_fonts[@]}"; do
            echo "  [$((i+1))] ${installed_fonts[$i]}"
        done
        echo "  [A] All fonts"
        echo "  [N] None (keep all)"
        echo ""
        read -p "Remove which fonts? (e.g., 1,3 or A or N): " font_choice

        case "$font_choice" in
            [Aa])
                for font in "${installed_fonts[@]}"; do
                    brew uninstall --cask "$font" 2>/dev/null && \
                        print_success "Removed $font" || \
                        print_warning "Failed to remove $font"
                done
                ;;
            [Nn])
                print_warning "Keeping all fonts"
                ;;
            *)
                # Parse comma-separated numbers
                IFS=',' read -ra selections <<< "$font_choice"
                for sel in "${selections[@]}"; do
                    sel=$(echo "$sel" | tr -d ' ')
                    if [[ "$sel" =~ ^[0-9]+$ ]] && [[ $sel -ge 1 ]] && [[ $sel -le ${#installed_fonts[@]} ]]; then
                        font="${installed_fonts[$((sel-1))]}"
                        brew uninstall --cask "$font" 2>/dev/null && \
                            print_success "Removed $font" || \
                            print_warning "Failed to remove $font"
                    fi
                done
                ;;
        esac
    else
        print_warning "No Cursive Terminal fonts found"
    fi

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
        reset_terminal_colors
        ;;
    [Ff]ull|full|FULL)
        remove_zshrc_config
        remove_configs
        reset_terminal_colors
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
echo "Terminal colors have been reset to defaults."
echo ""
echo "To change font back (if italic still showing):"
echo "  • Terminal.app: Cmd+, → Profiles → Text → Font → SF Mono or Menlo"
echo "  • iTerm2: Cmd+, → Profiles → Text → Font → change from Victor Mono"
echo ""
echo "To reinstall later: ./install.sh"
