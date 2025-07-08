#!/bin/bash

# Cursive Terminal Showcase Script
# Demonstrates all the beautiful features

# Colors
GREEN='\e[32m'
BLUE='\e[34m'
PURPLE='\e[35m'
YELLOW='\e[33m'
CYAN='\e[36m'
RESET='\e[0m'
ITALIC='\e[3m'
BOLD='\e[1m'

# Clear screen
clear

# Animated title
echo ""
echo -e "${BOLD}${PURPLE}✒️  Welcome to Cursive Terminal!${RESET}"
sleep 1

# Introduction
echo ""
echo -e "${ITALIC}Transform your terminal into a beautiful writing experience...${RESET}"
sleep 2
echo ""

# Feature demonstrations
features=(
    "📝 Beautiful cursive text rendering"
    "🎨 Syntax highlighting optimized for cursive"
    "💻 Perfect for coding with style"
    "🌈 Custom color themes"
    "⚡ Fast and responsive"
)

for feature in "${features[@]}"; do
    echo -e "${ITALIC}${feature}${RESET}"
    sleep 0.5
done

echo ""
sleep 1

# Code example
echo -e "${BOLD}Code Example:${RESET}"
echo ""
echo -e "${PURPLE}function${RESET} ${ITALIC}cursiveDemo${RESET}() {"
echo -e "  ${GREEN}${ITALIC}// This comment is in beautiful cursive${RESET}"
echo -e "  ${BLUE}const${RESET} message = ${YELLOW}${ITALIC}'Coding has never looked better!'${RESET};"
echo -e "  ${BLUE}console${RESET}.log(message);"
echo -e "}"
echo ""
sleep 2

# Git example
echo -e "${BOLD}Git Integration:${RESET}"
echo ""
echo -e "$ ${ITALIC}git status${RESET}"
echo -e "${GREEN}On branch${RESET} ${ITALIC}main${RESET}"
echo -e "${GREEN}Your branch is up to date with${RESET} ${ITALIC}'origin/main'${RESET}"
echo ""
sleep 2

# ASCII Art in cursive
echo -e "${BOLD}ASCII Art (looks amazing in cursive!):${RESET}"
echo ""
echo -e "${ITALIC}"
cat << 'EOF'
   ____                _           
  / ___|   _ _ __ ___(_)_   _____ 
 | |  | | | | '__/ __| \ \ / / _ \
 | |__| |_| | |  \__ \ |\ V /  __/
  \____\__,_|_|  |___/_| \_/ \___|
                                   
EOF
echo -e "${RESET}"
sleep 2

# Font showcase
echo -e "${BOLD}Available Fonts:${RESET}"
echo ""
fonts=(
    "Victor Mono|⭐ Most cursive with connected letters"
    "Cascadia Code|Elegant and professional"
    "JetBrains Mono|Subtle and readable"
)

for font_info in "${fonts[@]}"; do
    IFS='|' read -r font desc <<< "$font_info"
    echo -e "• ${BOLD}$font${RESET}: ${ITALIC}$desc${RESET}"
    sleep 0.5
done

echo ""
sleep 1

# Call to action
echo -e "${BOLD}${CYAN}Ready to transform your terminal?${RESET}"
echo ""
echo -e "${ITALIC}Run ${BOLD}./quick_setup.sh${RESET}${ITALIC} to get started!${RESET}"
echo ""
echo -e "${PURPLE}Happy cursive coding! ✨${RESET}"
echo ""