#!/bin/bash

# Colored Text Demo for Cursive Terminal
# Shows off beautiful colored text rendering with cursive fonts

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

# Bright colors
BRED='\033[1;31m'
BGREEN='\033[1;32m'
BYELLOW='\033[1;33m'
BBLUE='\033[1;34m'
BPURPLE='\033[1;35m'
BCYAN='\033[1;36m'
BWHITE='\033[1;37m'

# Background colors
BG_RED='\033[41m'
BG_GREEN='\033[42m'
BG_YELLOW='\033[43m'
BG_BLUE='\033[44m'
BG_PURPLE='\033[45m'
BG_CYAN='\033[46m'
BG_WHITE='\033[47m'

# Text styles
BOLD='\033[1m'
DIM='\033[2m'
ITALIC='\033[3m'
UNDERLINE='\033[4m'
BLINK='\033[5m'
REVERSE='\033[7m'
HIDDEN='\033[8m'
STRIKETHROUGH='\033[9m'

# Reset
NC='\033[0m' # No Color

clear

echo -e "${BPURPLE}${BOLD}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BPURPLE}${BOLD}║            🎨 Cursive Terminal Color Showcase 🎨               ║${NC}"
echo -e "${BPURPLE}${BOLD}╚════════════════════════════════════════════════════════════════╝${NC}"
echo

echo -e "${ITALIC}Transform your terminal into a colorful cursive experience!${NC}"
echo

# Basic Colors Section
echo -e "${BOLD}${UNDERLINE}Basic Colors:${NC}"
echo -e "${RED}${ITALIC}Red roses are beautiful in cursive${NC}"
echo -e "${GREEN}${ITALIC}Green grass waves in the wind${NC}"
echo -e "${YELLOW}${ITALIC}Yellow sunshine brightens the day${NC}"
echo -e "${BLUE}${ITALIC}Blue oceans stretch to the horizon${NC}"
echo -e "${PURPLE}${ITALIC}Purple mountains majesty${NC}"
echo -e "${CYAN}${ITALIC}Cyan skies after the storm${NC}"
echo

# Bright Colors Section
echo -e "${BOLD}${UNDERLINE}Bright Colors:${NC}"
echo -e "${BRED}${ITALIC}Bright red flames dance${NC}"
echo -e "${BGREEN}${ITALIC}Bright green emeralds sparkle${NC}"
echo -e "${BYELLOW}${ITALIC}Bright yellow stars twinkle${NC}"
echo -e "${BBLUE}${ITALIC}Bright blue diamonds shine${NC}"
echo -e "${BPURPLE}${ITALIC}Bright purple amethysts glow${NC}"
echo -e "${BCYAN}${ITALIC}Bright cyan waters shimmer${NC}"
echo

# Rainbow Text
echo -e "${BOLD}${UNDERLINE}Rainbow Text:${NC}"
echo -e "${RED}R${YELLOW}a${GREEN}i${CYAN}n${BLUE}b${PURPLE}o${RED}w ${ITALIC}${YELLOW}c${GREEN}u${CYAN}r${BLUE}s${PURPLE}i${RED}v${YELLOW}e ${GREEN}t${CYAN}e${BLUE}x${PURPLE}t ${RED}i${YELLOW}s ${GREEN}a${CYAN}m${BLUE}a${PURPLE}z${RED}i${YELLOW}n${GREEN}g${CYAN}!${NC}"
echo

# Text Styles
echo -e "${BOLD}${UNDERLINE}Text Styles:${NC}"
echo -e "${BOLD}${ITALIC}Bold italic cursive text${NC}"
echo -e "${DIM}${ITALIC}Dim subtle cursive whispers${NC}"
echo -e "${UNDERLINE}${ITALIC}Underlined cursive importance${NC}"
echo -e "${REVERSE}${ITALIC} Reversed cursive highlight ${NC}"
echo

# Code Syntax Highlighting
echo -e "${BOLD}${UNDERLINE}Code Syntax Example:${NC}"
echo -e "${PURPLE}function${NC} ${ITALIC}${CYAN}colorfulCursive${NC}${WHITE}() {${NC}"
echo -e "  ${BLUE}const${NC} ${ITALIC}message${NC} = ${GREEN}${ITALIC}'Coding in color with cursive!'${NC};"
echo -e "  ${BLUE}const${NC} ${ITALIC}colors${NC} = [${YELLOW}${ITALIC}'red'${NC}, ${YELLOW}${ITALIC}'green'${NC}, ${YELLOW}${ITALIC}'blue'${NC}];"
echo -e "  ${PURPLE}return${NC} ${ITALIC}colors${NC}.${CYAN}map${NC}(${ITALIC}c${NC} => ${GREEN}\`\${${ITALIC}c${NC}}: beautiful\`${NC});"
echo -e "${WHITE}}${NC}"
echo

# Git Status Colors
echo -e "${BOLD}${UNDERLINE}Git Status Colors:${NC}"
echo -e "${GREEN}${ITALIC}✓ modified:   src/components/Header.jsx${NC}"
echo -e "${GREEN}${ITALIC}✓ new file:   src/utils/colors.js${NC}"
echo -e "${RED}${ITALIC}✗ deleted:    old/deprecated.css${NC}"
echo -e "${YELLOW}${ITALIC}? untracked:  notes.md${NC}"
echo

# Background Colors
echo -e "${BOLD}${UNDERLINE}Background Colors:${NC}"
echo -e "${BG_RED}${WHITE}${ITALIC} Emergency Alert ${NC} ${ITALIC}Critical system message${NC}"
echo -e "${BG_GREEN}${WHITE}${ITALIC} Success ${NC} ${ITALIC}Operation completed successfully${NC}"
echo -e "${BG_YELLOW}${BLACK}${ITALIC} Warning ${NC} ${ITALIC}Please review before proceeding${NC}"
echo -e "${BG_BLUE}${WHITE}${ITALIC} Info ${NC} ${ITALIC}Important information${NC}"
echo -e "${BG_PURPLE}${WHITE}${ITALIC} Special ${NC} ${ITALIC}Featured content${NC}"
echo

# Gradient Effect
echo -e "${BOLD}${UNDERLINE}Gradient Effect:${NC}"
for i in {0..5}; do
    case $i in
        0) echo -ne "\033[38;5;196m" ;;
        1) echo -ne "\033[38;5;202m" ;;
        2) echo -ne "\033[38;5;208m" ;;
        3) echo -ne "\033[38;5;214m" ;;
        4) echo -ne "\033[38;5;220m" ;;
        5) echo -ne "\033[38;5;226m" ;;
    esac
    echo -ne "${ITALIC}Sunset "
done
echo -e "${NC}"

# 256 Color Mode
echo
echo -e "${BOLD}${UNDERLINE}256 Color Palette Sample:${NC}"
for i in {16..51}; do
    echo -ne "\033[38;5;${i}m${ITALIC}◆${NC}"
done
echo

# True Color (24-bit) Example
echo
echo -e "${BOLD}${UNDERLINE}True Color Gradient:${NC}"
for i in {0..79}; do
    r=$((255 - i * 3))
    g=$((i * 3))
    b=$((128))
    echo -ne "\033[38;2;${r};${g};${b}m${ITALIC}█${NC}"
done
echo -e "\n"

# ASCII Art in Color
echo -e "${BOLD}${UNDERLINE}Colored ASCII Art:${NC}"
echo -e "${CYAN}${ITALIC}   ____                _           ${NC}"
echo -e "${BLUE}${ITALIC}  / ___|   _ _ __ ___(_)_   _____ ${NC}"
echo -e "${PURPLE}${ITALIC} | |  | | | | '__/ __| \\ \\ / / _ \\${NC}"
echo -e "${RED}${ITALIC} | |__| |_| | |  \\__ \\ |\\ V /  __/${NC}"
echo -e "${YELLOW}${ITALIC}  \\____\\__,_|_|  |___/_| \\_/ \\___|${NC}"
echo

# Box Drawing with Colors
echo -e "${BOLD}${UNDERLINE}Colored Box Drawing:${NC}"
echo -e "${GREEN}┌─────────────────────────────┐${NC}"
echo -e "${GREEN}│${NC} ${ITALIC}${CYAN}Beautiful cursive text${NC}      ${GREEN}│${NC}"
echo -e "${GREEN}│${NC} ${ITALIC}${PURPLE}in a colorful box${NC}          ${GREEN}│${NC}"
echo -e "${GREEN}└─────────────────────────────┘${NC}"
echo

# Programming Ligatures in Color
echo -e "${BOLD}${UNDERLINE}Colored Programming Ligatures:${NC}"
echo -e "${BLUE}=>${NC} ${ITALIC}Arrow functions${NC}"
echo -e "${RED}!=${NC} ${ITALIC}Not equal${NC}"
echo -e "${GREEN}===${NC} ${ITALIC}Strict equality${NC}"
echo -e "${YELLOW}++${NC} ${ITALIC}Increment${NC}"
echo -e "${PURPLE}--${NC} ${ITALIC}Decrement${NC}"
echo -e "${CYAN}<=${NC} ${ITALIC}Less than or equal${NC}"
echo -e "${BRED}>=${NC} ${ITALIC}Greater than or equal${NC}"
echo -e "${BGREEN}<>${NC} ${ITALIC}Not equal (alternative)${NC}"
echo -e "${BYELLOW}...${NC} ${ITALIC}Spread operator${NC}"
echo

# Final Message
echo -e "${BOLD}${BPURPLE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}${BPURPLE}║${NC}  ${ITALIC}For best results, use Victor Mono or Cascadia Code Italic${NC}   ${BOLD}${BPURPLE}║${NC}"
echo -e "${BOLD}${BPURPLE}╚════════════════════════════════════════════════════════════════╝${NC}"
echo
echo -e "${ITALIC}${DIM}Run ${NC}${BOLD}./colored_text_demo.sh${NC}${ITALIC}${DIM} anytime to see this showcase${NC}"
echo