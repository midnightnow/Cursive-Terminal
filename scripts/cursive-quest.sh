#!/bin/bash

# 🎮 Cursive Quest - An Immersive Text Adventure
# Journey through the Cursive Code Academy to become a Master Cursive Coder

# Game state file
GAME_STATE="$HOME/.cursive-quest/game-state.json"
QUEST_DIR="$HOME/.cursive-quest"
ACHIEVEMENTS_FILE="$QUEST_DIR/achievements.txt"
CURRENT_THEME="cursive-elegance"

# Colors for the game
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
BOLD='\033[1m'
ITALIC='\033[3m'
NC='\033[0m' # No Color

# Initialize game state
init_game() {
    mkdir -p "$QUEST_DIR"
    if [ ! -f "$GAME_STATE" ]; then
        cat > "$GAME_STATE" << EOF
{
    "player_name": "",
    "level": 1,
    "experience": 0,
    "current_location": "entrance",
    "themes_unlocked": ["cursive-elegance"],
    "achievements": [],
    "persona": "neutral",
    "tone_dial": 50,
    "quest_stage": "welcome"
}
EOF
    fi
}

# Clear screen and show title
show_title() {
    clear
    echo -e "${ITALIC}${CYAN}"
    cat << 'EOF'
     ____                   _              ___                  _   
    / ___|   _  _ __  ___  (_) __   __    / _ \  _   _   ___  | |_ 
   | |   | | | || '__|/ __| | | \ \ / /   | | | || | | | / _ \ | __|
   | |___| |_| || |   \__ \ | |  \ V /    | |_| || |_| ||  __/ | |_ 
    \____|\__,_||_|   |___/ |_|   \_/      \__\_\ \__,_| \___|  \__|
                                                                     
             🌟 A Journey Through the Cursive Code Academy 🌟
EOF
    echo -e "${NC}"
    echo
    echo -e "${ITALIC}Press Enter to begin your quest...${NC}"
    read -s
}

# Welcome sequence
welcome_player() {
    clear
    echo -e "${ITALIC}${WHITE}"
    echo "As you approach the grand entrance of the Cursive Code Academy,"
    echo "ancient runes shimmer on the archway, written in the most elegant cursive..."
    echo -e "${NC}"
    sleep 2
    echo
    echo -e "${CYAN}${ITALIC}\"Welcome, seeker of the cursive arts!\""
    echo -e "\"I am the Gatekeeper of Code, guardian of this sacred academy.\""
    echo -e "${NC}"
    sleep 2
    echo
    echo -e "${WHITE}What shall I call you, brave apprentice?${NC}"
    echo -n "> "
    read player_name
    
    # Update game state with player name
    echo "{\"player_name\": \"$player_name\"}" > "$QUEST_DIR/temp.json"
    
    echo
    echo -e "${CYAN}${ITALIC}\"Ah, $player_name! A fine name for a future Cursive Master.\""
    echo -e "\"Before we begin, let me understand your preferred communication style...\""
    echo -e "${NC}"
    sleep 2
}

# Persona selection
select_persona() {
    clear
    echo -e "${BOLD}${YELLOW}Choose Your Persona Guide:${NC}"
    echo
    echo -e "${RED}1) 🏴‍☠️ Pirate Captain${NC} - 'Ahoy! Ready to sail the cursive seas, matey?'"
    echo -e "${MAGENTA}2) 🧛 Vampire Scholar${NC} - 'Welcome to my eternal library of code...'"
    echo -e "${GREEN}3) 🧙 Wizard Mentor${NC} - 'The arcane arts of cursive await, young apprentice.'"
    echo -e "${BLUE}4) ⚙️ Clockwork Engineer${NC} - 'Precision and elegance, perfectly calibrated.'"
    echo -e "${WHITE}5) 📚 Classic Professor${NC} - 'Let us explore the fundamentals together.'"
    echo
    echo -n "Choose your guide (1-5): "
    read choice
    
    case $choice in
        1) persona="pirate"; guide_name="Captain Codebeard";;
        2) persona="vampire"; guide_name="Count Syntaxula";;
        3) persona="wizard"; guide_name="Merlin.js";;
        4) persona="clockwork"; guide_name="Professor Cogsworth";;
        *) persona="professor"; guide_name="Dr. Cursive";;
    esac
    
    echo
    echo -e "${ITALIC}You have chosen ${BOLD}$guide_name${NC}${ITALIC} as your guide!${NC}"
    sleep 2
}

# Tutorial: Theme Selection
theme_tutorial() {
    clear
    echo -e "${BOLD}${CYAN}Chapter 1: The Hall of Themes${NC}"
    echo
    
    case $persona in
        pirate)
            echo -e "${ITALIC}Captain Codebeard bellows:${NC}"
            echo -e "${RED}\"Arr! First lesson, ye landlubber - choosing yer colors!\""
            echo -e "\"In these waters, a pirate's theme be their flag!\""
            ;;
        vampire)
            echo -e "${ITALIC}Count Syntaxula whispers:${NC}"
            echo -e "${MAGENTA}\"In the darkness, we must choose our palette wisely...\""
            echo -e "\"Each theme holds ancient power over the terminal's soul.\""
            ;;
        wizard)
            echo -e "${ITALIC}Merlin.js proclaims:${NC}"
            echo -e "${BLUE}\"Behold! The mystical themes that transform your reality!\""
            echo -e "\"Each one imbued with its own magical properties.\""
            ;;
        *)
            echo -e "${ITALIC}Your guide explains:${NC}"
            echo -e "${WHITE}\"Let's explore the beautiful themes available to you.\""
            echo -e "\"Each theme transforms your coding experience uniquely.\""
            ;;
    esac
    
    echo
    sleep 2
    echo -e "${YELLOW}Would you like to explore the Theme Gallery? (y/n)${NC}"
    read -n 1 explore
    echo
    
    if [[ $explore == "y" ]]; then
        echo -e "${GREEN}Launching Theme Selector...${NC}"
        sleep 1
        # Check if theme selector exists
        if [ -f "./theme-selector.sh" ]; then
            ./theme-selector.sh
        else
            echo -e "${YELLOW}Theme selector not found. Let me show you available themes:${NC}"
            echo
            echo "🌑 Dark Themes: Cursive Elegance, Vampire's Letter, Pirate's Scroll"
            echo "🌅 Light Themes: Ancient Papyrus, Parchment Note, Calligraphy Practice"
            echo "🌈 Colorful Themes: Rainbow Prism, Neon Sign, Ocean Depths"
            echo
            echo -e "${ITALIC}To install themes, run: ./install-all-themes.sh${NC}"
        fi
        
        echo
        echo -e "${GREEN}✨ Achievement Unlocked: Theme Explorer!${NC}"
        echo "Theme Explorer" >> "$ACHIEVEMENTS_FILE"
    fi
}

# Tutorial: Git Integration
git_tutorial() {
    clear
    echo -e "${BOLD}${CYAN}Chapter 2: The Repository Sanctum${NC}"
    echo
    
    case $persona in
        pirate)
            echo -e "${RED}\"Now we learn to stash our treasure in git's hold!\""
            echo -e "\"Every good pirate needs a proper treasure map!\""
            ;;
        vampire)
            echo -e "${MAGENTA}\"Version control... immortality for your code.\""
            echo -e "\"Like me, your work shall live forever in git's embrace.\""
            ;;
        *)
            echo -e "${WHITE}\"Time to learn about version control with git.\""
            echo -e "\"This is how we preserve and share our cursive creations.\""
            ;;
    esac
    
    echo
    sleep 2
    echo -e "${YELLOW}Let's create your first cursive git commit!${NC}"
    echo
    echo -e "${ITALIC}Tutorial: Beautiful Commit Messages${NC}"
    echo "1. Always use cursive-style emojis: 🎨 ✨ 🌟 📜"
    echo "2. Write descriptive, poetic commit messages"
    echo "3. Example: '🎨 Add elegant cursive styling to main interface'"
    echo
    echo -e "${GREEN}Practice writing a commit message:${NC}"
    echo -n "> "
    read commit_msg
    echo
    echo -e "${GREEN}✨ Achievement Unlocked: Git Poet!${NC}"
    echo "Git Poet" >> "$ACHIEVEMENTS_FILE"
}

# Tutorial: AI Integration
ai_tutorial() {
    clear
    echo -e "${BOLD}${CYAN}Chapter 3: The AI Familiar${NC}"
    echo
    
    case $persona in
        pirate)
            echo -e "${RED}\"Even pirates need a clever parrot! Meet yer AI matey!\""
            ;;
        vampire)
            echo -e "${MAGENTA}\"My eternal companion... an intelligence beyond mortal ken.\""
            ;;
        wizard)
            echo -e "${BLUE}\"Behold! A magical familiar to assist in your incantations!\""
            ;;
        *)
            echo -e "${WHITE}\"Let me introduce you to your AI coding assistant.\""
            ;;
    esac
    
    echo
    sleep 2
    echo -e "${YELLOW}Your AI assistant can help you:${NC}"
    echo "• Generate cursive code with style"
    echo "• Explain complex concepts poetically"
    echo "• Suggest elegant refactoring"
    echo "• Create beautiful documentation"
    echo
    echo -e "${ITALIC}Try asking: 'Make this code more elegant'${NC}"
    echo
    echo -e "${GREEN}✨ Achievement Unlocked: AI Whisperer!${NC}"
    echo "AI Whisperer" >> "$ACHIEVEMENTS_FILE"
}

# Community & Ecosystem
explore_ecosystem() {
    clear
    echo -e "${BOLD}${CYAN}Chapter 4: The Cursive Community${NC}"
    echo
    echo -e "${ITALIC}You've reached the Community Square!${NC}"
    echo
    sleep 1
    echo -e "${YELLOW}🏛️ Community Docks:${NC}"
    echo
    echo "📺 YouTube Channel: Cursive tutorials and showcases"
    echo "💝 Patreon: Support the cursive movement"
    echo "💬 Discord: Chat with fellow cursive coders"
    echo "📚 Documentation: cursive-code.dev"
    echo "🛍️ Theme Marketplace: Buy/sell custom themes"
    echo
    echo -e "${GREEN}Which dock would you like to visit?${NC}"
    echo "1) YouTube Channel - Watch tutorials"
    echo "2) Patreon - View membership tiers"
    echo "3) Discord - Join the community"
    echo "4) Documentation - Read the guides"
    echo "5) Marketplace - Browse themes"
    echo
    echo -n "Choose (1-5): "
    read dock_choice
    
    case $dock_choice in
        1) echo -e "${CYAN}Opening YouTube channel...${NC}"
           echo "🎥 Latest video: 'Master Cursive Coding in 10 Minutes'";;
        2) show_patreon_tiers;;
        3) echo -e "${CYAN}Discord invite: discord.gg/cursivecode${NC}";;
        4) echo -e "${CYAN}Docs available at: https://docs.cursive-code.dev${NC}";;
        5) show_marketplace;;
    esac
    
    echo
    echo -e "${GREEN}✨ Achievement Unlocked: Community Explorer!${NC}"
    echo "Community Explorer" >> "$ACHIEVEMENTS_FILE"
}

# Show Patreon tiers
show_patreon_tiers() {
    echo
    echo -e "${BOLD}${YELLOW}Cursive Code Patreon Tiers:${NC}"
    echo
    echo -e "${WHITE}📜 Apprentice Scribe ($5/month)${NC}"
    echo "  • Early access to new themes"
    echo "  • Monthly cursive font pack"
    echo "  • Discord bronze role"
    echo
    echo -e "${CYAN}🖋️ Journeyman Calligrapher ($15/month)${NC}"
    echo "  • Everything in Apprentice"
    echo "  • Custom theme requests"
    echo "  • AI assistant priority"
    echo "  • Discord silver role"
    echo
    echo -e "${MAGENTA}✨ Master Illuminator ($50/month)${NC}"
    echo "  • Everything in Journeyman"
    echo "  • 1-on-1 cursive coding session"
    echo "  • Name in credits"
    echo "  • Custom emoji pack"
    echo "  • Discord gold role"
}

# Show marketplace
show_marketplace() {
    echo
    echo -e "${BOLD}${YELLOW}Theme Marketplace:${NC}"
    echo
    echo "🌟 Featured Themes:"
    echo "  • 'Sakura Dreams' by @miyuki - $4.99 ⭐⭐⭐⭐⭐"
    echo "  • 'Steampunk Gears' by @cogmaster - $6.99 ⭐⭐⭐⭐"
    echo "  • 'Aurora Borealis' by @northcoder - $5.99 ⭐⭐⭐⭐⭐"
    echo
    echo "💰 Your theme sales: $0.00 (Create your first theme!)"
}

# Final graduation ceremony
graduation_ceremony() {
    clear
    echo -e "${BOLD}${CYAN}🎓 Graduation Ceremony 🎓${NC}"
    echo
    echo -e "${ITALIC}You've completed your journey through Cursive Quest!${NC}"
    echo
    sleep 2
    
    # Check achievements
    local achievement_count=0
    if [ -f "$ACHIEVEMENTS_FILE" ]; then
        achievement_count=$(wc -l < "$ACHIEVEMENTS_FILE")
    fi
    
    echo -e "${YELLOW}Achievements Earned: $achievement_count${NC}"
    echo
    
    if [ -f "$ACHIEVEMENTS_FILE" ]; then
        echo -e "${GREEN}Your Achievements:${NC}"
        cat "$ACHIEVEMENTS_FILE" | sort | uniq | while read achievement; do
            echo "  ✨ $achievement"
        done
    fi
    
    echo
    echo -e "${BOLD}${MAGENTA}You are now a Certified Cursive Coder!${NC}"
    echo
    echo -e "${ITALIC}Your guide speaks one last time:${NC}"
    
    case $persona in
        pirate)
            echo -e "${RED}\"Ye've proven yerself a true cursive captain!\""
            echo -e "\"May the wind fill yer sails and yer code be ever elegant!\""
            ;;
        vampire)
            echo -e "${MAGENTA}\"You have mastered the dark arts of cursive...\""
            echo -e "\"May your code live eternal, as beautiful as the night.\""
            ;;
        wizard)
            echo -e "${BLUE}\"The prophecy is fulfilled! A new Cursive Master rises!\""
            echo -e "\"May your spells always compile and your bugs be few.\""
            ;;
        *)
            echo -e "${WHITE}\"Congratulations on completing your cursive journey!\""
            echo -e "\"May your code always be as beautiful as it is functional.\""
            ;;
    esac
    
    echo
    echo -e "${CYAN}🌟 Welcome to the Cursive Code Community! 🌟${NC}"
    echo
    echo -e "${ITALIC}Type 'cursive-quest --continue' to explore more features${NC}"
    echo -e "${ITALIC}Type 'cursive-quest --reset' to play again with a different persona${NC}"
}

# Bonus: Tone Dial Tutorial
tone_dial_tutorial() {
    clear
    echo -e "${BOLD}${CYAN}Bonus Chapter: The Tone Dial${NC}"
    echo
    echo -e "${ITALIC}Your guide demonstrates the mystical Tone Dial...${NC}"
    echo
    echo -e "${YELLOW}Current tone setting: 50%${NC}"
    echo
    echo "Try these commands:"
    echo "  • 'dial pirate 100%' - Maximum pirate speak!"
    echo "  • 'dial vampire 25%' - Subtle gothic hints"
    echo "  • 'dial wizard 75%' - Mostly magical"
    echo "  • 'speak plainly' - Reset to normal"
    echo
    echo -n "Try a command: "
    read tone_command
    echo
    echo -e "${GREEN}Tone adjusted! Your guide now speaks differently...${NC}"
    
    if [[ $tone_command == *"pirate 100"* ]]; then
        echo -e "${RED}\"ARRR! Now that be more like it, ye scurvy dog!\""
        echo -e "\"Me cursive be flowin' like rum from a barrel!\""
    elif [[ $tone_command == *"vampire 25"* ]]; then
        echo -e "${MAGENTA}\"A touch of darkness... most agreeable.\""
    elif [[ $tone_command == "speak plainly" ]]; then
        echo -e "${WHITE}\"Returning to standard communication protocols.\""
    fi
    
    echo
    echo -e "${GREEN}✨ Achievement Unlocked: Tone Master!${NC}"
    echo "Tone Master" >> "$ACHIEVEMENTS_FILE"
}

# Main game flow
main_quest() {
    welcome_player
    select_persona
    theme_tutorial
    git_tutorial
    ai_tutorial
    explore_ecosystem
    tone_dial_tutorial
    graduation_ceremony
}

# Command line options
case "$1" in
    --continue)
        echo "Loading your saved game..."
        explore_ecosystem
        ;;
    --reset)
        rm -rf "$QUEST_DIR"
        echo "Game reset! Starting fresh..."
        sleep 1
        init_game
        show_title
        main_quest
        ;;
    --achievements)
        if [ -f "$ACHIEVEMENTS_FILE" ]; then
            echo -e "${BOLD}${YELLOW}Your Achievements:${NC}"
            cat "$ACHIEVEMENTS_FILE" | sort | uniq | while read achievement; do
                echo "  ✨ $achievement"
            done
        else
            echo "No achievements yet! Start your quest!"
        fi
        ;;
    *)
        init_game
        show_title
        main_quest
        ;;
esac