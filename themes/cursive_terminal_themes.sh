#!/bin/bash

# Cursive Terminal Themes
# Beautiful color schemes that complement cursive fonts

mkdir -p ~/.config/terminal-themes

# Theme 1: Cursive Elegance (Purple/Gold)
cat > ~/.config/terminal-themes/cursive-elegance.sh << 'EOF'
# Cursive Elegance Theme
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Terminal colors
echo -e "\033]10;#E8E3E3\007"  # Foreground: Light gray
echo -e "\033]11;#1A1625\007"  # Background: Deep purple
echo -e "\033]12;#FFD700\007"  # Cursor: Gold

# ANSI Colors
echo -e "\033]4;0;#1A1625\007"   # Black
echo -e "\033]4;1;#FF6B6B\007"   # Red
echo -e "\033]4;2;#4ECDC4\007"   # Green
echo -e "\033]4;3;#FFD700\007"   # Yellow
echo -e "\033]4;4;#6B5B95\007"   # Blue
echo -e "\033]4;5;#C44569\007"   # Magenta
echo -e "\033]4;6;#88D8B0\007"   # Cyan
echo -e "\033]4;7;#E8E3E3\007"   # White
EOF

# Theme 2: Cursive Noir (Black/Silver)
cat > ~/.config/terminal-themes/cursive-noir.sh << 'EOF'
# Cursive Noir Theme
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Terminal colors
echo -e "\033]10;#C0C0C0\007"  # Foreground: Silver
echo -e "\033]11;#0A0A0A\007"  # Background: Near black
echo -e "\033]12;#FFFFFF\007"  # Cursor: White

# ANSI Colors
echo -e "\033]4;0;#0A0A0A\007"   # Black
echo -e "\033]4;1;#DC143C\007"   # Red (Crimson)
echo -e "\033]4;2;#00FF00\007"   # Green (Lime)
echo -e "\033]4;3;#FFD700\007"   # Yellow (Gold)
echo -e "\033]4;4;#4169E1\007"   # Blue (Royal)
echo -e "\033]4;5;#9400D3\007"   # Magenta (Violet)
echo -e "\033]4;6;#00CED1\007"   # Cyan (Dark Turquoise)
echo -e "\033]4;7;#C0C0C0\007"   # White (Silver)
EOF

# Theme 3: Cursive Garden (Green/Brown)
cat > ~/.config/terminal-themes/cursive-garden.sh << 'EOF'
# Cursive Garden Theme
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxegedabagacad

# Terminal colors
echo -e "\033]10;#2D3E2D\007"  # Foreground: Dark green
echo -e "\033]11;#FAF8F3\007"  # Background: Off-white
echo -e "\033]12;#8B4513\007"  # Cursor: Saddle brown

# ANSI Colors
echo -e "\033]4;0;#2D3E2D\007"   # Black (Dark green)
echo -e "\033]4;1;#A0522D\007"   # Red (Sienna)
echo -e "\033]4;2;#228B22\007"   # Green (Forest)
echo -e "\033]4;3;#DAA520\007"   # Yellow (Goldenrod)
echo -e "\033]4;4;#4682B4\007"   # Blue (Steel)
echo -e "\033]4;5;#8B008B\007"   # Magenta (Dark)
echo -e "\033]4;6;#20B2AA\007"   # Cyan (Light Sea)
echo -e "\033]4;7;#FAF8F3\007"   # White (Off-white)
EOF

echo "Cursive themes created in ~/.config/terminal-themes/"
echo ""
echo "To apply a theme, run:"
echo "  source ~/.config/terminal-themes/cursive-elegance.sh"
echo "  source ~/.config/terminal-themes/cursive-noir.sh"
echo "  source ~/.config/terminal-themes/cursive-garden.sh"