#!/bin/bash

# Cursive Font Demo Script
# Shows different text styles and features

echo "==================================="
echo "    CURSIVE FONT SHOWCASE          "
echo "==================================="
echo ""

# Regular text
echo "Regular monospace text looks like this."
echo ""

# Italic text (shows cursive in Victor Mono)
echo -e "\e[3mThis text is italic - in Victor Mono it's beautifully cursive!\e[0m"
echo ""

# Bold + Italic
echo -e "\e[1;3mBold and italic combined for emphasis\e[0m"
echo ""

# Code examples
echo "Code with cursive comments:"
echo -e "function greet() {"
echo -e "  \e[3m// This comment appears in cursive\e[0m"
echo -e "  console.log('Hello, World!');"
echo -e "}"
echo ""

# Colored cursive
echo "Colored cursive text:"
echo -e "\e[32;3mGreen cursive text\e[0m"
echo -e "\e[34;3mBlue cursive text\e[0m"
echo -e "\e[35;3mPurple cursive text\e[0m"
echo ""

# ASCII art with cursive
echo -e "\e[3m"
cat << 'EOF'
   ___                  _           
  / __\   _ _ __ ___(_)_   _____ 
 / / | | | | '__/ __| \ \ / / _ \
/ /__| |_| | |  \__ \ |\ V /  __/
\____/\__,_|_|  |___/_| \_/ \___|
                                  
EOF
echo -e "\e[0m"

# Comparison
echo "Font Comparison:"
echo "==============="
echo "Normal:  The quick brown fox jumps over the lazy dog"
echo -e "\e[3mCursive: The quick brown fox jumps over the lazy dog\e[0m"
echo ""

# Programming ligatures (if supported)
echo "Programming ligatures:"
echo "-> => != === ++ -- <= >= <> ..."
echo ""

echo "To see the full cursive effect, make sure you're using:"
echo "• Victor Mono Italic"
echo "• Cascadia Code Italic"
echo "• Or any cursive monospace font"