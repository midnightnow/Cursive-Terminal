#!/bin/bash

# ============================================================================
# Cursive Terminal - Installation Script
# Beautiful cursive fonts and themes for your terminal
# https://github.com/midnightnow/Cursive-Terminal
# ============================================================================

set -e

VERSION="2.0.0"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
ITALIC='\033[3m'
NC='\033[0m'

# Logging functions
print_status() { echo -e "${BLUE}==>${NC} $1"; }
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_header() { echo -e "\n${BOLD}${CYAN}$1${NC}\n"; }

# Installation tracking
INSTALLED_FONTS=()
INSTALLED_TOOLS=()
ERRORS=()

# ============================================================================
# Pre-flight Checks
# ============================================================================

check_os() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "This script is designed for macOS"
        print_warning "Linux/Windows users: See README.md for manual installation"
        exit 1
    fi
}

check_homebrew() {
    if ! command -v brew &>/dev/null; then
        print_error "Homebrew not found!"
        echo ""
        echo "Install Homebrew first:"
        echo '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
        echo ""
        exit 1
    fi
    print_success "Homebrew found"
}

# ============================================================================
# Installation Functions
# ============================================================================

install_font() {
    local font="$1"
    if brew list --cask "$font" &>/dev/null; then
        print_success "$font (already installed)"
    else
        if brew install --cask "$font" &>/dev/null; then
            print_success "$font"
            INSTALLED_FONTS+=("$font")
        else
            print_warning "Failed to install $font"
            ERRORS+=("Font: $font")
        fi
    fi
}

install_tool() {
    local tool="$1"
    if brew list "$tool" &>/dev/null; then
        print_success "$tool (already installed)"
    else
        if brew install "$tool" &>/dev/null; then
            print_success "$tool"
            INSTALLED_TOOLS+=("$tool")
        else
            print_warning "Failed to install $tool"
            ERRORS+=("Tool: $tool")
        fi
    fi
}

install_fonts() {
    print_header "Installing Cursive Fonts"

    install_font "font-victor-mono"      # Best cursive italics
    install_font "font-cascadia-code"    # Microsoft's modern font
    install_font "font-jetbrains-mono"   # Developer favorite
    install_font "font-fira-code"        # Mozilla's coding font
}

install_tools() {
    print_header "Installing Terminal Tools"

    install_tool "starship"              # Beautiful prompt
    install_tool "bat"                   # Syntax-highlighted cat
    install_tool "eza"                   # Modern ls with icons
    install_tool "figlet"                # ASCII art text
    install_tool "lolcat"                # Rainbow output
    install_tool "zsh-syntax-highlighting"
}

install_themes() {
    print_header "Installing Themes"

    mkdir -p ~/.config/terminal-themes

    if [[ -f "$SCRIPT_DIR/themes/cursive_terminal_themes.sh" ]]; then
        bash "$SCRIPT_DIR/themes/cursive_terminal_themes.sh"
        print_success "33 terminal themes installed"
    else
        print_warning "Theme file not found"
    fi
}

install_configs() {
    print_header "Installing Configurations"

    # Neovim config
    if [[ -f "$SCRIPT_DIR/configs/cursive_neovim_config.lua" ]]; then
        mkdir -p ~/.config/nvim
        cp "$SCRIPT_DIR/configs/cursive_neovim_config.lua" ~/.config/nvim/cursive.lua
        print_success "Neovim cursive config"
    fi

    # Starship config
    if [[ -f "$SCRIPT_DIR/configs/starship.toml" ]]; then
        mkdir -p ~/.config
        cp "$SCRIPT_DIR/configs/starship.toml" ~/.config/starship.toml
        print_success "Starship prompt config"
    fi
}

configure_shell() {
    print_header "Configuring Shell"

    local ZSHRC="$HOME/.zshrc"
    local MARKER="# ===== CURSIVE TERMINAL SETUP ====="

    # Skip if already configured
    if grep -q "$MARKER" "$ZSHRC" 2>/dev/null; then
        print_warning "Shell already configured (skipping)"
        return 0
    fi

    # Backup existing config
    if [[ -f "$ZSHRC" ]]; then
        cp "$ZSHRC" "${ZSHRC}.backup-$(date +%Y%m%d-%H%M%S)"
        print_success "Backed up existing .zshrc"
    fi

    # Add our configuration
    cat >> "$ZSHRC" << 'ZSHRC_CONFIG'

# ===== CURSIVE TERMINAL SETUP =====
# Installed by Cursive Terminal (https://github.com/midnightnow/Cursive-Terminal)
# To uninstall: ./uninstall.sh

# Starship prompt (beautiful, fast, customizable)
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi

# Syntax highlighting for commands
[[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enhanced aliases with icons and colors
if command -v eza &>/dev/null; then
    alias ls='eza --icons --git'
    alias ll='eza --icons --git -l'
    alias la='eza --icons --git -la'
    alias tree='eza --icons --tree'
fi

if command -v bat &>/dev/null; then
    alias cat='bat --style=auto'
fi

# Cursive Terminal demo commands
export CURSIVE_TERMINAL_HOME="${CURSIVE_TERMINAL_HOME:-$HOME/Cursive-Terminal}"
alias cursive-demo='$CURSIVE_TERMINAL_HOME/scripts/cursive_font_demo.sh'
alias cursive-fonts='$CURSIVE_TERMINAL_HOME/scripts/font_comparison.sh'
alias cursive-showcase='$CURSIVE_TERMINAL_HOME/scripts/showcase.sh'
alias cursive-themes='$CURSIVE_TERMINAL_HOME/scripts/theme-selector.sh'

# Quick cursive test
alias test-cursive='echo -e "Regular text \e[3mBeautiful cursive italics\e[0m back to regular"'

# ===== END CURSIVE TERMINAL =====
ZSHRC_CONFIG

    # Set the installation path
    sed -i '' "s|\${CURSIVE_TERMINAL_HOME:-\$HOME/Cursive-Terminal}|$SCRIPT_DIR|g" "$ZSHRC"

    print_success "Shell configuration added to .zshrc"
}

make_scripts_executable() {
    print_status "Making scripts executable..."
    chmod +x "$SCRIPT_DIR"/*.sh 2>/dev/null || true
    chmod +x "$SCRIPT_DIR"/scripts/*.sh 2>/dev/null || true
    print_success "Scripts are executable"
}

# ============================================================================
# Installation Modes
# ============================================================================

show_menu() {
    clear
    echo -e "${BOLD}${CYAN}"
    echo "  ╔═══════════════════════════════════════════════════════════╗"
    echo "  ║                                                           ║"
    echo -e "  ║   ${ITALIC}✒️  Cursive Terminal Installer${NC}${BOLD}${CYAN}                         ║"
    echo "  ║                                                           ║"
    echo "  ║   Beautiful cursive fonts & themes for your terminal      ║"
    echo "  ║                                                           ║"
    echo "  ╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo ""
    echo "  Choose installation mode:"
    echo ""
    echo -e "    ${GREEN}1)${NC} Full Install     - Fonts, tools, themes, and shell config"
    echo -e "    ${BLUE}2)${NC} Minimal Install  - Fonts and themes only (no brew tools)"
    echo -e "    ${YELLOW}3)${NC} Themes Only      - Just install the 33 terminal themes"
    echo -e "    ${DIM}4) Uninstall       - Remove Cursive Terminal${NC}"
    echo ""
    echo -e "    ${DIM}q) Quit${NC}"
    echo ""
}

install_full() {
    print_header "Full Installation"
    check_homebrew
    install_fonts
    install_tools
    install_themes
    install_configs
    configure_shell
    make_scripts_executable
}

install_minimal() {
    print_header "Minimal Installation"
    check_homebrew
    install_fonts
    install_themes
    configure_shell
    make_scripts_executable
}

install_themes_only() {
    print_header "Themes Only Installation"
    install_themes
    make_scripts_executable
    print_success "Themes installed to ~/.config/terminal-themes/"
    echo ""
    echo "Apply a theme with:"
    echo "  source ~/.config/terminal-themes/cursive-elegance.sh"
}

show_summary() {
    echo ""
    print_header "Installation Complete!"

    if [[ ${#INSTALLED_FONTS[@]} -gt 0 ]]; then
        echo -e "${GREEN}Fonts installed:${NC} ${INSTALLED_FONTS[*]}"
    fi

    if [[ ${#INSTALLED_TOOLS[@]} -gt 0 ]]; then
        echo -e "${GREEN}Tools installed:${NC} ${INSTALLED_TOOLS[*]}"
    fi

    if [[ ${#ERRORS[@]} -gt 0 ]]; then
        echo ""
        echo -e "${YELLOW}Warnings:${NC}"
        for err in "${ERRORS[@]}"; do
            echo "  - $err"
        done
    fi

    echo ""
    echo -e "${BOLD}Next steps:${NC}"
    echo "  1. Restart your terminal (or run: source ~/.zshrc)"
    echo "  2. Set terminal font to 'Victor Mono' (italic variant)"
    echo "  3. Try: cursive-showcase"
    echo ""
    echo -e "${BOLD}Available commands:${NC}"
    echo "  cursive-demo      Test cursive font rendering"
    echo "  cursive-fonts     Compare installed fonts"
    echo "  cursive-showcase  Full feature demonstration"
    echo "  cursive-themes    Interactive theme selector"
    echo "  test-cursive      Quick cursive test"
    echo ""
    echo -e "${DIM}To uninstall: ./uninstall.sh${NC}"
    echo ""
}

# ============================================================================
# Main
# ============================================================================

main() {
    check_os

    # Handle command-line arguments
    case "${1:-}" in
        --full|-f)
            install_full
            show_summary
            exit 0
            ;;
        --minimal|-m)
            install_minimal
            show_summary
            exit 0
            ;;
        --themes|-t)
            install_themes_only
            exit 0
            ;;
        --uninstall|-u)
            exec "$SCRIPT_DIR/uninstall.sh"
            ;;
        --help|-h)
            echo "Cursive Terminal Installer v$VERSION"
            echo ""
            echo "Usage: ./install.sh [option]"
            echo ""
            echo "Options:"
            echo "  --full, -f      Full installation (fonts, tools, themes, config)"
            echo "  --minimal, -m   Minimal installation (fonts, themes only)"
            echo "  --themes, -t    Install themes only"
            echo "  --uninstall, -u Run uninstaller"
            echo "  --help, -h      Show this help"
            echo ""
            echo "Without options, shows interactive menu."
            exit 0
            ;;
        "")
            # Interactive mode
            ;;
        *)
            print_error "Unknown option: $1"
            echo "Run './install.sh --help' for usage"
            exit 1
            ;;
    esac

    # Interactive menu
    show_menu
    read -p "  Enter choice [1-4, q]: " choice

    case "$choice" in
        1)
            install_full
            show_summary
            ;;
        2)
            install_minimal
            show_summary
            ;;
        3)
            install_themes_only
            ;;
        4)
            exec "$SCRIPT_DIR/uninstall.sh"
            ;;
        q|Q)
            echo "Installation cancelled."
            exit 0
            ;;
        *)
            print_error "Invalid choice"
            exit 1
            ;;
    esac
}

main "$@"
