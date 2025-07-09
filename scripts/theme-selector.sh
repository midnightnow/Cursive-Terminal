#!/bin/bash

# Cursive Terminal Theme Selector
# Interactive theme picker and customizer with live preview

set -euo pipefail

# Colors for the UI
BOLD='\033[1m'
DIM='\033[2m'
ITALIC='\033[3m'
UNDERLINE='\033[4m'
NC='\033[0m' # No Color

# All available themes
ALL_THEMES=(
    "cursive-elegance"
    "cursive-noir"
    "cursive-garden"
    "pirate-scroll"
    "vampires-letter"
    "ocean-mist"
    "sunset-glow"
    "forest-grove"
    "midnight-quill"
    "ancient-papyrus"
    "ivory-parchment"
    "linen-manuscript"
    "calligraphy-scroll"
    "illuminated-manuscript"
    "invisible-ink"
    "rainbow-prism"
    "neon-cyberpunk"
    "tropical-paradise"
    "cotton-candy"
    "aurora-borealis"
    "sunset-festival"
    "office-memo"
    "receipt-paper"
    "carbon-copy"
    "blueprint-tech"
    "legal-document"
    "ditto-spirit"
    "papyrus-scroll"
    "ancient-parchment"
    "linen-sheet"
    "calligraphy-flourish"
    "invisible-ink-revealed"
)

# Theme categories
DARK_THEMES="cursive-elegance cursive-noir cursive-garden pirate-scroll vampires-letter ocean-mist sunset-glow forest-grove midnight-quill"
LIGHT_THEMES="ancient-papyrus ivory-parchment linen-manuscript calligraphy-scroll illuminated-manuscript invisible-ink"
COLORFUL_THEMES="rainbow-prism neon-cyberpunk tropical-paradise cotton-candy aurora-borealis sunset-festival"
BUSINESS_THEMES="office-memo receipt-paper carbon-copy blueprint-tech legal-document ditto-spirit"
FEATHER_THEMES="papyrus-scroll ancient-parchment linen-sheet illuminated-manuscript calligraphy-flourish invisible-ink-revealed"

# Global variables
CURRENT_THEME=""
CURRENT_CATEGORY="all"
PREVIEW_MODE=true
SAVE_TO_PROFILE=false

# Function to clear screen with style
clear_screen() {
    printf '\033[2J\033[H'
}

# Function to print header
print_header() {
    clear_screen
    echo -e "${BOLD}${ITALIC}"
    echo "╔════════════════════════════════════════════════════════════════╗"
    echo "║           🎨 Cursive Terminal Theme Selector 🎨               ║"
    echo "╚════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo
}

# Function to get theme info
get_theme_info() {
    local theme=$1
    case "$theme" in
        "cursive-elegance") echo "✨ Purple/Gold - Sophisticated and elegant" ;;
        "cursive-noir") echo "⚫ Black/Silver - Classic monochrome sophistication" ;;
        "cursive-garden") echo "🌿 Green/Brown - Natural earth tones" ;;
        "pirate-scroll") echo "🏴‍☠️ Brown/Gold - Weather-beaten parchment" ;;
        "vampires-letter") echo "🧛 Black/Red - Dark velvet night" ;;
        "ocean-mist") echo "🌊 Blue/Teal - Deep-sea blues" ;;
        "sunset-glow") echo "🌅 Orange/Pink - Warm sunset colors" ;;
        "forest-grove") echo "🌲 Green/Brown - Deep forest" ;;
        "midnight-quill") echo "🌙 Indigo/Silver - Night sky" ;;
        "ancient-papyrus") echo "📜 Beige/Brown - Aged papyrus" ;;
        "ivory-parchment") echo "🏛️ Ivory/Brown - Smooth ivory" ;;
        "linen-manuscript") echo "🧵 Linen/Slate - Natural texture" ;;
        "calligraphy-scroll") echo "✒️ Cream/Black - Classic calligraphy" ;;
        "illuminated-manuscript") echo "🎨 Blue/Navy - Medieval illuminated" ;;
        "invisible-ink") echo "🔍 Light Gray - Secret messages" ;;
        "rainbow-prism") echo "🌈 Dark/Vibrant - Rainbow highlights" ;;
        "neon-cyberpunk") echo "⚡ Black/Green - Matrix neon" ;;
        "tropical-paradise") echo "🌺 Teal/Orange - Tropical colors" ;;
        "cotton-candy") echo "🍭 Pink/Purple - Soft swirls" ;;
        "aurora-borealis") echo "🌌 Navy/Green - Aurora lights" ;;
        "sunset-festival") echo "🎪 Purple/Orange - Festival vibes" ;;
        "office-memo") echo "📄 White/Blue - Professional" ;;
        "receipt-paper") echo "🧾 Cream/Black - Thermal paper" ;;
        "carbon-copy") echo "📑 Lavender/Purple - Carbon paper" ;;
        "blueprint-tech") echo "📐 Blue/Cyan - Technical blueprint" ;;
        "legal-document") echo "⚖️ White/Brown - Formal legal" ;;
        "ditto-spirit") echo "🖨️ Blue/Purple - Ditto machine" ;;
        "papyrus-scroll") echo "📜 Ochre/Brown - WCAG-AA compliant" ;;
        "ancient-parchment") echo "🦴 Ivory/Sepia - Warm sepia" ;;
        "linen-sheet") echo "🧵 White/Charcoal - Cool white" ;;
        "calligraphy-flourish") echo "✒️ Pearl/Black - High contrast" ;;
        "invisible-ink-revealed") echo "🕵️ Pale Lemon - Easter egg!" ;;
        *) echo "Unknown theme" ;;
    esac
}

# Function to apply theme
apply_theme() {
    local theme=$1
    if [[ -f ~/.config/terminal-themes/$theme.sh ]]; then
        source ~/.config/terminal-themes/$theme.sh
        CURRENT_THEME=$theme
        return 0
    else
        echo "❌ Theme file not found: $theme"
        return 1
    fi
}

# Function to show theme preview
show_theme_preview() {
    local theme=$1
    echo -e "\n${BOLD}Preview: $(get_theme_info "$theme")${NC}\n"
    
    # Apply theme temporarily
    apply_theme "$theme"
    
    # Show preview content
    echo -e "${ITALIC}Lorem ipsum dolor sit amet, consectetur adipiscing elit.${NC}"
    echo -e "${BOLD}Bold text example${NC} | Regular text | ${DIM}Dimmed text${NC}"
    echo
    echo -e "Code example:"
    echo -e "${ITALIC}function ${BOLD}cursiveDemo${NC}${ITALIC}() {${NC}"
    echo -e "  ${ITALIC}// This is a comment in cursive${NC}"
    echo -e "  const message = ${ITALIC}'Beautiful cursive terminal!'${NC};"
    echo -e "  return message;"
    echo -e "${ITALIC}}${NC}"
    echo
    echo -e "Special characters: -> => != === ++ -- <= >= <> ..."
    echo
}

# Function to list themes by category
list_themes_by_category() {
    local category=$1
    local themes=""
    
    case "$category" in
        "dark") themes="$DARK_THEMES" ;;
        "light") themes="$LIGHT_THEMES" ;;
        "colorful") themes="$COLORFUL_THEMES" ;;
        "business") themes="$BUSINESS_THEMES" ;;
        "feather") themes="$FEATHER_THEMES" ;;
        "all") themes="${ALL_THEMES[@]}" ;;
    esac
    
    # Return unique sorted list
    echo "$themes" | tr ' ' '\n' | sort -u
}

# Function to show category menu
show_category_menu() {
    echo -e "${BOLD}Theme Categories:${NC}"
    echo "  1) All Themes (33)"
    echo "  2) Dark Themes (9)"
    echo "  3) Light Manuscript (6)"
    echo "  4) Colorful Themes (6)"
    echo "  5) Business Documents (6)"
    echo "  6) Feather-Light WCAG (6)"
    echo
    echo -n "Select category [1-6]: "
    read -r choice
    
    case $choice in
        1) CURRENT_CATEGORY="all" ;;
        2) CURRENT_CATEGORY="dark" ;;
        3) CURRENT_CATEGORY="light" ;;
        4) CURRENT_CATEGORY="colorful" ;;
        5) CURRENT_CATEGORY="business" ;;
        6) CURRENT_CATEGORY="feather" ;;
        *) CURRENT_CATEGORY="all" ;;
    esac
}

# Function to show theme grid
show_theme_grid() {
    local themes=($(list_themes_by_category "$CURRENT_CATEGORY"))
    local cols=3
    local count=0
    
    echo -e "\n${BOLD}Available Themes:${NC}"
    echo
    
    for theme in "${themes[@]}"; do
        # Print theme name with padding
        printf "%-25s" "$theme"
        ((count++))
        
        # New line after every 3 themes
        if (( count % cols == 0 )); then
            echo
        fi
    done
    
    # Final newline if needed
    if (( count % cols != 0 )); then
        echo
    fi
    echo
}

# Function to search themes
search_themes() {
    echo -n "Search themes: "
    read -r search_term
    
    echo -e "\n${BOLD}Search Results:${NC}"
    for theme in "${ALL_THEMES[@]}"; do
        local info=$(get_theme_info "$theme")
        if [[ "$theme" =~ $search_term ]] || [[ "${info,,}" =~ ${search_term,,} ]]; then
            echo "  - $theme: $info"
        fi
    done
    echo
}

# Function to customize theme
customize_theme() {
    local theme=$1
    
    echo -e "\n${BOLD}Customizing: $theme${NC}"
    echo "This feature allows you to tweak theme colors."
    echo
    echo "1) Adjust background darkness/lightness"
    echo "2) Adjust text contrast"
    echo "3) Adjust accent color intensity"
    echo "4) Reset to defaults"
    echo
    echo -n "Select option [1-4]: "
    read -r choice
    
    case $choice in
        1)
            echo "Background adjustment: Use ↑/↓ keys (not implemented in bash)"
            echo "This would adjust the background color in a full app"
            ;;
        2)
            echo "Text contrast: Use ↑/↓ keys (not implemented in bash)"
            echo "This would adjust text contrast in a full app"
            ;;
        3)
            echo "Accent intensity: Use ↑/↓ keys (not implemented in bash)"
            echo "This would adjust accent colors in a full app"
            ;;
        4)
            apply_theme "$theme"
            echo "✅ Reset to default settings"
            ;;
    esac
}

# Function to save theme preference
save_theme_preference() {
    local theme=$1
    local shell_rc=""
    
    # Detect shell configuration file
    if [[ -n "$ZSH_VERSION" ]]; then
        shell_rc="$HOME/.zshrc"
    elif [[ -n "$BASH_VERSION" ]]; then
        shell_rc="$HOME/.bashrc"
    else
        shell_rc="$HOME/.profile"
    fi
    
    echo -e "\n${BOLD}Save Theme Preference${NC}"
    echo "Add this theme to your shell startup? ($shell_rc)"
    echo -n "Save to profile? [y/N]: "
    read -r confirm
    
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        # Remove old theme source lines
        sed -i.bak '/^source.*terminal-themes.*\.sh$/d' "$shell_rc"
        
        # Add new theme source
        echo "" >> "$shell_rc"
        echo "# Cursive Terminal Theme (added by theme-selector)" >> "$shell_rc"
        echo "source ~/.config/terminal-themes/$theme.sh" >> "$shell_rc"
        
        echo "✅ Theme saved to $shell_rc"
        echo "   Restart your terminal or run: source $shell_rc"
    fi
}

# Function to show main menu
show_main_menu() {
    echo -e "${BOLD}Main Menu:${NC}"
    echo "  1) All Themes (33)"
    echo "  2) Dark Themes (9)"
    echo "  3) Light Manuscript (6)"
    echo "  4) Colorful Themes (6)"
    echo "  5) Business Documents (6)"
    echo "  6) Feather-Light WCAG (6)"
    echo
    echo "  s) Search themes"
    echo "  r) Random theme"
    echo "  p) Toggle preview mode (currently: $PREVIEW_MODE)"
    echo "  h) Help"
    echo "  q) Quit"
    echo
    echo -n "Enter choice or theme name: "
}

# Function to show help
show_help() {
    clear_screen
    echo -e "${BOLD}Theme Selector Help${NC}"
    echo
    echo "NAVIGATION:"
    echo "  - Type a theme name directly to apply it"
    echo "  - Use menu options to browse and search"
    echo "  - Press Enter to refresh the display"
    echo
    echo "THEME CATEGORIES:"
    echo "  - Dark: Classic dark backgrounds"
    echo "  - Light: Manuscript-inspired light themes"
    echo "  - Colorful: Vibrant, energetic themes"
    echo "  - Business: Professional document styles"
    echo "  - Feather-Light: WCAG-AA compliant high contrast"
    echo
    echo "FEATURES:"
    echo "  - Live preview of themes"
    echo "  - Save themes to shell profile"
    echo "  - Search by name or description"
    echo "  - Random theme selection"
    echo
    echo "Press Enter to continue..."
    read -r
}

# Function to select random theme
select_random_theme() {
    local random_index=$((RANDOM % ${#ALL_THEMES[@]}))
    local random_theme="${ALL_THEMES[$random_index]}"
    
    echo -e "\n${BOLD}Random Theme Selected:${NC}"
    echo "  $(get_theme_info "$random_theme")"
    
    if [[ "$PREVIEW_MODE" == true ]]; then
        show_theme_preview "$random_theme"
    else
        apply_theme "$random_theme"
    fi
    
    echo -n "Keep this theme? [y/N]: "
    read -r confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        CURRENT_THEME="$random_theme"
        save_theme_preference "$random_theme"
    fi
}

# Function to check if theme exists
theme_exists() {
    local theme=$1
    for t in "${ALL_THEMES[@]}"; do
        if [[ "$t" == "$theme" ]]; then
            return 0
        fi
    done
    return 1
}

# Main program loop
main() {
    # Check if theme directory exists
    if [[ ! -d ~/.config/terminal-themes ]]; then
        echo "❌ Error: Theme directory not found at ~/.config/terminal-themes"
        echo "   Please run the theme installation script first."
        exit 1
    fi
    
    # Main loop
    while true; do
        print_header
        
        if [[ -n "$CURRENT_THEME" ]]; then
            echo -e "Current theme: ${BOLD}$(get_theme_info "$CURRENT_THEME")${NC}"
            echo
        fi
        
        show_main_menu
        read -r choice
        
        case "$choice" in
            1)
                CURRENT_CATEGORY="all"
                show_theme_grid
                echo -n "Select theme name (or press Enter to go back): "
                read -r theme_choice
                if [[ -n "$theme_choice" ]] && theme_exists "$theme_choice"; then
                    if [[ "$PREVIEW_MODE" == true ]]; then
                        show_theme_preview "$theme_choice"
                        echo -n "Apply this theme? [y/N]: "
                        read -r confirm
                        if [[ "$confirm" =~ ^[Yy]$ ]]; then
                            CURRENT_THEME="$theme_choice"
                            save_theme_preference "$theme_choice"
                        fi
                    else
                        apply_theme "$theme_choice"
                        CURRENT_THEME="$theme_choice"
                    fi
                fi
                ;;
            
            2)
                CURRENT_CATEGORY="dark"
                show_theme_grid
                echo -n "Select theme name (or press Enter to go back): "
                read -r theme_choice
                if [[ -n "$theme_choice" ]] && theme_exists "$theme_choice"; then
                    if [[ "$PREVIEW_MODE" == true ]]; then
                        show_theme_preview "$theme_choice"
                        echo -n "Apply this theme? [y/N]: "
                        read -r confirm
                        if [[ "$confirm" =~ ^[Yy]$ ]]; then
                            CURRENT_THEME="$theme_choice"
                            save_theme_preference "$theme_choice"
                        fi
                    else
                        apply_theme "$theme_choice"
                        CURRENT_THEME="$theme_choice"
                    fi
                fi
                ;;
            
            3)
                CURRENT_CATEGORY="light"
                show_theme_grid
                echo -n "Select theme name (or press Enter to go back): "
                read -r theme_choice
                if [[ -n "$theme_choice" ]] && theme_exists "$theme_choice"; then
                    if [[ "$PREVIEW_MODE" == true ]]; then
                        show_theme_preview "$theme_choice"
                        echo -n "Apply this theme? [y/N]: "
                        read -r confirm
                        if [[ "$confirm" =~ ^[Yy]$ ]]; then
                            CURRENT_THEME="$theme_choice"
                            save_theme_preference "$theme_choice"
                        fi
                    else
                        apply_theme "$theme_choice"
                        CURRENT_THEME="$theme_choice"
                    fi
                fi
                ;;
            
            4)
                CURRENT_CATEGORY="colorful"
                show_theme_grid
                echo -n "Select theme name (or press Enter to go back): "
                read -r theme_choice
                if [[ -n "$theme_choice" ]] && theme_exists "$theme_choice"; then
                    if [[ "$PREVIEW_MODE" == true ]]; then
                        show_theme_preview "$theme_choice"
                        echo -n "Apply this theme? [y/N]: "
                        read -r confirm
                        if [[ "$confirm" =~ ^[Yy]$ ]]; then
                            CURRENT_THEME="$theme_choice"
                            save_theme_preference "$theme_choice"
                        fi
                    else
                        apply_theme "$theme_choice"
                        CURRENT_THEME="$theme_choice"
                    fi
                fi
                ;;
            
            5)
                CURRENT_CATEGORY="business"
                show_theme_grid
                echo -n "Select theme name (or press Enter to go back): "
                read -r theme_choice
                if [[ -n "$theme_choice" ]] && theme_exists "$theme_choice"; then
                    if [[ "$PREVIEW_MODE" == true ]]; then
                        show_theme_preview "$theme_choice"
                        echo -n "Apply this theme? [y/N]: "
                        read -r confirm
                        if [[ "$confirm" =~ ^[Yy]$ ]]; then
                            CURRENT_THEME="$theme_choice"
                            save_theme_preference "$theme_choice"
                        fi
                    else
                        apply_theme "$theme_choice"
                        CURRENT_THEME="$theme_choice"
                    fi
                fi
                ;;
            
            6)
                CURRENT_CATEGORY="feather"
                show_theme_grid
                echo -n "Select theme name (or press Enter to go back): "
                read -r theme_choice
                if [[ -n "$theme_choice" ]] && theme_exists "$theme_choice"; then
                    if [[ "$PREVIEW_MODE" == true ]]; then
                        show_theme_preview "$theme_choice"
                        echo -n "Apply this theme? [y/N]: "
                        read -r confirm
                        if [[ "$confirm" =~ ^[Yy]$ ]]; then
                            CURRENT_THEME="$theme_choice"
                            save_theme_preference "$theme_choice"
                        fi
                    else
                        apply_theme "$theme_choice"
                        CURRENT_THEME="$theme_choice"
                    fi
                fi
                ;;
            
            s|S)
                search_themes
                echo -n "Press Enter to continue..."
                read -r
                ;;
            
            r|R)
                select_random_theme
                ;;
            
            p|P)
                if [[ "$PREVIEW_MODE" == true ]]; then
                    PREVIEW_MODE=false
                else
                    PREVIEW_MODE=true
                fi
                echo "Preview mode: $PREVIEW_MODE"
                sleep 1
                ;;
            
            h|H)
                show_help
                ;;
            
            q|Q)
                echo -e "\n${ITALIC}Thanks for using Cursive Terminal Theme Selector!${NC}"
                exit 0
                ;;
            
            "")
                # Just refresh on Enter
                continue
                ;;
            
            *)
                # Check if it's a valid theme name
                if theme_exists "$choice"; then
                    if [[ "$PREVIEW_MODE" == true ]]; then
                        show_theme_preview "$choice"
                        echo -n "Apply this theme? [y/N]: "
                        read -r confirm
                        if [[ "$confirm" =~ ^[Yy]$ ]]; then
                            CURRENT_THEME="$choice"
                            save_theme_preference "$choice"
                        fi
                    else
                        apply_theme "$choice"
                        CURRENT_THEME="$choice"
                        echo "✅ Applied theme: $choice"
                        sleep 1
                    fi
                else
                    echo "❌ Invalid choice: $choice"
                    sleep 1
                fi
                ;;
        esac
    done
}

# Run the main program
main "$@"