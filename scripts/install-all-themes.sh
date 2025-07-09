#!/bin/bash

# Complete theme installer for Cursive Terminal
# Installs all 33 themes

echo "🎨 Installing all 33 Cursive Terminal themes..."

# Create theme directory if it doesn't exist
mkdir -p ~/.config/terminal-themes

# Check if we should run existing installers
if [[ -f add_missing_themes.sh ]]; then
    echo "📦 Installing dark themes..."
    bash add_missing_themes.sh
fi

if [[ -f add_light_themes.sh ]]; then
    echo "📜 Installing light manuscript themes..."
    bash add_light_themes.sh
fi

if [[ -f add_feather_light_themes.sh ]]; then
    echo "🌞 Installing feather-light themes..."
    bash add_feather_light_themes.sh
fi

# Also create any missing theme files directly
echo "🔧 Creating missing theme files..."

# Create colorful themes
cat > ~/.config/terminal-themes/rainbow-prism.sh << 'EOF'
# Rainbow Prism Theme
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxegedabagacad

# Terminal colors
echo -e "\033]10;#FFFFFF\007"  # Foreground: White
echo -e "\033]11;#1A1A1A\007"  # Background: Dark
echo -e "\033]12;#FF00FF\007"  # Cursor: Magenta

# ANSI Colors (Rainbow)
echo -e "\033]4;0;#1A1A1A\007"   # Black
echo -e "\033]4;1;#FF0000\007"   # Red
echo -e "\033]4;2;#00FF00\007"   # Green
echo -e "\033]4;3;#FFFF00\007"   # Yellow
echo -e "\033]4;4;#0000FF\007"   # Blue
echo -e "\033]4;5;#FF00FF\007"   # Magenta
echo -e "\033]4;6;#00FFFF\007"   # Cyan
echo -e "\033]4;7;#FFFFFF\007"   # White
EOF

cat > ~/.config/terminal-themes/neon-cyberpunk.sh << 'EOF'
# Neon Cyberpunk Theme
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxegedabagacad

# Terminal colors
echo -e "\033]10;#00FF00\007"  # Foreground: Neon green
echo -e "\033]11;#000000\007"  # Background: Black
echo -e "\033]12;#00FFFF\007"  # Cursor: Cyan

# ANSI Colors
echo -e "\033]4;0;#000000\007"   # Black
echo -e "\033]4;1;#FF0066\007"   # Red (Hot pink)
echo -e "\033]4;2;#00FF00\007"   # Green (Neon)
echo -e "\033]4;3;#FFFF00\007"   # Yellow
echo -e "\033]4;4;#0099FF\007"   # Blue (Electric)
echo -e "\033]4;5;#FF00FF\007"   # Magenta
echo -e "\033]4;6;#00FFFF\007"   # Cyan
echo -e "\033]4;7;#FFFFFF\007"   # White
EOF

cat > ~/.config/terminal-themes/tropical-paradise.sh << 'EOF'
# Tropical Paradise Theme
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxegedabagacad

# Terminal colors
echo -e "\033]10;#FFFFFF\007"  # Foreground: White
echo -e "\033]11;#006B76\007"  # Background: Teal
echo -e "\033]12;#FF6F61\007"  # Cursor: Coral

# ANSI Colors
echo -e "\033]4;0;#006B76\007"   # Black (Teal)
echo -e "\033]4;1;#FF6F61\007"   # Red (Coral)
echo -e "\033]4;2;#88D8B0\007"   # Green (Mint)
echo -e "\033]4;3;#FFCC5C\007"   # Yellow (Sun)
echo -e "\033]4;4;#00CED1\007"   # Blue (Turquoise)
echo -e "\033]4;5;#FF69B4\007"   # Magenta (Hot pink)
echo -e "\033]4;6;#40E0D0\007"   # Cyan (Turquoise)
echo -e "\033]4;7;#FFFFFF\007"   # White
EOF

cat > ~/.config/terminal-themes/cotton-candy.sh << 'EOF'
# Cotton Candy Theme
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxegedabagacad

# Terminal colors
echo -e "\033]10;#4A0E4E\007"  # Foreground: Deep purple
echo -e "\033]11;#FFE5F1\007"  # Background: Pink white
echo -e "\033]12;#FF69B4\007"  # Cursor: Hot pink

# ANSI Colors
echo -e "\033]4;0;#FFE5F1\007"   # Black (Pink white)
echo -e "\033]4;1;#FF1493\007"   # Red (Deep pink)
echo -e "\033]4;2;#FF69B4\007"   # Green (Hot pink)
echo -e "\033]4;3;#FFB6C1\007"   # Yellow (Light pink)
echo -e "\033]4;4;#DA70D6\007"   # Blue (Orchid)
echo -e "\033]4;5;#BA55D3\007"   # Magenta (Medium orchid)
echo -e "\033]4;6;#DDA0DD\007"   # Cyan (Plum)
echo -e "\033]4;7;#4A0E4E\007"   # White (Deep purple)
EOF

cat > ~/.config/terminal-themes/aurora-borealis.sh << 'EOF'
# Aurora Borealis Theme
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxegedabagacad

# Terminal colors
echo -e "\033]10;#E8F8F5\007"  # Foreground: Ice white
echo -e "\033]11;#001F3F\007"  # Background: Navy
echo -e "\033]12;#00FF7F\007"  # Cursor: Spring green

# ANSI Colors
echo -e "\033]4;0;#001F3F\007"   # Black (Navy)
echo -e "\033]4;1;#FF1493\007"   # Red (Deep pink)
echo -e "\033]4;2;#00FF7F\007"   # Green (Spring)
echo -e "\033]4;3;#FFD700\007"   # Yellow (Gold)
echo -e "\033]4;4;#4169E1\007"   # Blue (Royal)
echo -e "\033]4;5;#9370DB\007"   # Magenta (Purple)
echo -e "\033]4;6;#00CED1\007"   # Cyan (Dark turquoise)
echo -e "\033]4;7;#E8F8F5\007"   # White (Ice)
EOF

cat > ~/.config/terminal-themes/sunset-festival.sh << 'EOF'
# Sunset Festival Theme
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxegedabagacad

# Terminal colors
echo -e "\033]10;#FFF8DC\007"  # Foreground: Cornsilk
echo -e "\033]11;#4B0082\007"  # Background: Indigo
echo -e "\033]12;#FF8C00\007"  # Cursor: Dark orange

# ANSI Colors
echo -e "\033]4;0;#4B0082\007"   # Black (Indigo)
echo -e "\033]4;1;#FF4500\007"   # Red (Orange red)
echo -e "\033]4;2;#FF8C00\007"   # Green (Dark orange)
echo -e "\033]4;3;#FFA500\007"   # Yellow (Orange)
echo -e "\033]4;4;#FF1493\007"   # Blue (Deep pink)
echo -e "\033]4;5;#FF69B4\007"   # Magenta (Hot pink)
echo -e "\033]4;6;#FFB347\007"   # Cyan (Apricot)
echo -e "\033]4;7;#FFF8DC\007"   # White (Cornsilk)
EOF

# Create business themes
cat > ~/.config/terminal-themes/office-memo.sh << 'EOF'
# Office Memo Theme
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxegedabagacad

# Terminal colors
echo -e "\033]10;#000080\007"  # Foreground: Navy blue
echo -e "\033]11;#FFFFFF\007"  # Background: White
echo -e "\033]12;#0000FF\007"  # Cursor: Blue

# ANSI Colors
echo -e "\033]4;0;#000080\007"   # Black (Navy)
echo -e "\033]4;1;#CC0000\007"   # Red (Dark red)
echo -e "\033]4;2;#006400\007"   # Green (Dark green)
echo -e "\033]4;3;#FFD700\007"   # Yellow (Gold)
echo -e "\033]4;4;#0000FF\007"   # Blue
echo -e "\033]4;5;#4B0082\007"   # Magenta (Indigo)
echo -e "\033]4;6;#008B8B\007"   # Cyan (Dark cyan)
echo -e "\033]4;7;#FFFFFF\007"   # White
EOF

cat > ~/.config/terminal-themes/receipt-paper.sh << 'EOF'
# Receipt Paper Theme
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxegedabagacad

# Terminal colors
echo -e "\033]10;#1C1C1C\007"  # Foreground: Near black
echo -e "\033]11;#F5F5DC\007"  # Background: Beige
echo -e "\033]12;#000000\007"  # Cursor: Black

# ANSI Colors
echo -e "\033]4;0;#1C1C1C\007"   # Black
echo -e "\033]4;1;#8B0000\007"   # Red (Dark red)
echo -e "\033]4;2;#2F4F2F\007"   # Green (Dark green)
echo -e "\033]4;3;#B8860B\007"   # Yellow (Goldenrod)
echo -e "\033]4;4;#191970\007"   # Blue (Midnight)
echo -e "\033]4;5;#4B0082\007"   # Magenta (Indigo)
echo -e "\033]4;6;#2F4F4F\007"   # Cyan (Dark slate)
echo -e "\033]4;7;#F5F5DC\007"   # White (Beige)
EOF

cat > ~/.config/terminal-themes/carbon-copy.sh << 'EOF'
# Carbon Copy Theme
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxegedabagacad

# Terminal colors
echo -e "\033]10;#4B0082\007"  # Foreground: Indigo
echo -e "\033]11;#E6E6FA\007"  # Background: Lavender
echo -e "\033]12;#6A0DAD\007"  # Cursor: Purple

# ANSI Colors
echo -e "\033]4;0;#4B0082\007"   # Black (Indigo)
echo -e "\033]4;1;#8B008B\007"   # Red (Dark magenta)
echo -e "\033]4;2;#483D8B\007"   # Green (Dark slate blue)
echo -e "\033]4;3;#9370DB\007"   # Yellow (Medium purple)
echo -e "\033]4;4;#6A5ACD\007"   # Blue (Slate blue)
echo -e "\033]4;5;#7B68EE\007"   # Magenta (Medium slate)
echo -e "\033]4;6;#8A2BE2\007"   # Cyan (Blue violet)
echo -e "\033]4;7;#E6E6FA\007"   # White (Lavender)
EOF

cat > ~/.config/terminal-themes/blueprint-tech.sh << 'EOF'
# Blueprint Tech Theme
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxegedabagacad

# Terminal colors
echo -e "\033]10;#FFFFFF\007"  # Foreground: White
echo -e "\033]11;#003366\007"  # Background: Blueprint blue
echo -e "\033]12;#00FFFF\007"  # Cursor: Cyan

# ANSI Colors
echo -e "\033]4;0;#003366\007"   # Black (Blueprint)
echo -e "\033]4;1;#FF6B6B\007"   # Red (Light red)
echo -e "\033]4;2;#4ECDC4\007"   # Green (Teal)
echo -e "\033]4;3;#FFE66D\007"   # Yellow (Light)
echo -e "\033]4;4;#4D94FF\007"   # Blue (Light blue)
echo -e "\033]4;5;#C77DFF\007"   # Magenta (Light purple)
echo -e "\033]4;6;#00FFFF\007"   # Cyan
echo -e "\033]4;7;#FFFFFF\007"   # White
EOF

cat > ~/.config/terminal-themes/legal-document.sh << 'EOF'
# Legal Document Theme
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxegedabagacad

# Terminal colors
echo -e "\033]10;#3B2F2F\007"  # Foreground: Dark brown
echo -e "\033]11;#FFFEF7\007"  # Background: Legal white
echo -e "\033]12;#8B4513\007"  # Cursor: Saddle brown

# ANSI Colors
echo -e "\033]4;0;#3B2F2F\007"   # Black (Dark brown)
echo -e "\033]4;1;#8B0000\007"   # Red (Dark red)
echo -e "\033]4;2;#556B2F\007"   # Green (Dark olive)
echo -e "\033]4;3;#B8860B\007"   # Yellow (Goldenrod)
echo -e "\033]4;4;#483D8B\007"   # Blue (Dark slate)
echo -e "\033]4;5;#8B4789\007"   # Magenta (Orchid)
echo -e "\033]4;6;#4682B4\007"   # Cyan (Steel blue)
echo -e "\033]4;7;#FFFEF7\007"   # White (Legal)
EOF

cat > ~/.config/terminal-themes/ditto-spirit.sh << 'EOF'
# Ditto Spirit Theme
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxegedabagacad

# Terminal colors
echo -e "\033]10;#6A0DAD\007"  # Foreground: Purple
echo -e "\033]11;#E6E6FA\007"  # Background: Lavender
echo -e "\033]12;#9370DB\007"  # Cursor: Medium purple

# ANSI Colors
echo -e "\033]4;0;#6A0DAD\007"   # Black (Purple)
echo -e "\033]4;1;#8B008B\007"   # Red (Dark magenta)
echo -e "\033]4;2;#4B0082\007"   # Green (Indigo)
echo -e "\033]4;3;#9370DB\007"   # Yellow (Medium purple)
echo -e "\033]4;4;#6495ED\007"   # Blue (Cornflower)
echo -e "\033]4;5;#7B68EE\007"   # Magenta (Medium slate)
echo -e "\033]4;6;#87CEEB\007"   # Cyan (Sky blue)
echo -e "\033]4;7;#E6E6FA\007"   # White (Lavender)
EOF

echo "✅ All themes installed!"
echo ""
echo "📊 Theme count:"
ls ~/.config/terminal-themes/*.sh | grep -v -E "extended|manuscript" | wc -l | xargs echo "   Total theme files:"
echo ""
echo "🎨 You can now run: ./theme-selector.sh"