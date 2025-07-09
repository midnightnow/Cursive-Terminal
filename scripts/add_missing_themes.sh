#!/bin/bash

# Add the 6 missing themes to cursive_terminal_themes.sh

echo "🎨 Adding 6 new cursive themes..."

# Create extended themes file
cat >> ~/.config/terminal-themes/extended_themes.sh << 'EOF'
#!/bin/bash
# Extended Cursive Terminal Themes

# Theme 4: Pirate's Scroll (Brown/Gold)
cat > ~/.config/terminal-themes/pirate-scroll.sh << 'THEME'
# Pirate's Scroll Theme
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxegedabagacad

# Terminal colors
echo -e "\033]10;#FFEBCD\007"  # Foreground: Antique white
echo -e "\033]11;#341A0F\007"  # Background: Dark brown (parchment)
echo -e "\033]12;#FFD700\007"  # Cursor: Treasure gold

# ANSI Colors
echo -e "\033]4;0;#341A0F\007"   # Black (Dark brown)
echo -e "\033]4;1;#B22222\007"   # Red (Firebrick)
echo -e "\033]4;2;#8B4513\007"   # Green (Saddle brown)
echo -e "\033]4;3;#FFD700\007"   # Yellow (Gold)
echo -e "\033]4;4;#4682B4\007"   # Blue (Steel blue)
echo -e "\033]4;5;#8B7355\007"   # Magenta (Burlywood)
echo -e "\033]4;6;#5F9EA0\007"   # Cyan (Cadet blue)
echo -e "\033]4;7;#FFEBCD\007"   # White (Blanched almond)
THEME

# Theme 5: Vampire's Letter (Black/Red)
cat > ~/.config/terminal-themes/vampires-letter.sh << 'THEME'
# Vampire's Letter Theme
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Terminal colors
echo -e "\033]10;#F8F8F8\007"  # Foreground: Ghostly white
echo -e "\033]11;#0B0A0C\007"  # Background: Black velvet
echo -e "\033]12;#FF0033\007"  # Cursor: Fresh blood red

# ANSI Colors
echo -e "\033]4;0;#0B0A0C\007"   # Black (Black velvet)
echo -e "\033]4;1;#FF0033\007"   # Red (Blood red)
echo -e "\033]4;2;#8B0000\007"   # Green (Dark red)
echo -e "\033]4;3;#B22222\007"   # Yellow (Firebrick)
echo -e "\033]4;4;#4B0082\007"   # Blue (Indigo)
echo -e "\033]4;5;#800080\007"   # Magenta (Purple)
echo -e "\033]4;6;#DC143C\007"   # Cyan (Crimson)
echo -e "\033]4;7;#F8F8F8\007"   # White (Ghost white)
THEME

# Theme 6: Ocean Mist (Blue/Teal)
cat > ~/.config/terminal-themes/ocean-mist.sh << 'THEME'
# Ocean Mist Theme
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxegedabagacad

# Terminal colors
echo -e "\033]10;#E0F7FA\007"  # Foreground: Light cyan
echo -e "\033]11;#012B36\007"  # Background: Deep ocean
echo -e "\033]12;#00C2D1\007"  # Cursor: Bright cyan

# ANSI Colors
echo -e "\033]4;0;#012B36\007"   # Black (Deep ocean)
echo -e "\033]4;1;#FF6B6B\007"   # Red (Coral)
echo -e "\033]4;2;#4ECDC4\007"   # Green (Mint)
echo -e "\033]4;3;#F7DC6F\007"   # Yellow (Sandy)
echo -e "\033]4;4;#006BA6\007"   # Blue (Ocean blue)
echo -e "\033]4;5;#5B5F97\007"   # Magenta (Storm)
echo -e "\033]4;6;#00C2D1\007"   # Cyan (Turquoise)
echo -e "\033]4;7;#E0F7FA\007"   # White (Sea foam)
THEME

# Theme 7: Sunset Glow (Orange/Pink)
cat > ~/.config/terminal-themes/sunset-glow.sh << 'THEME'
# Sunset Glow Theme
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxegedabagacad

# Terminal colors
echo -e "\033]10;#FFF8E7\007"  # Foreground: Warm cream
echo -e "\033]11;#2E1503\007"  # Background: Dark amber
echo -e "\033]12;#FFA500\007"  # Cursor: Sunset orange

# ANSI Colors
echo -e "\033]4;0;#2E1503\007"   # Black (Dark amber)
echo -e "\033]4;1;#FF4500\007"   # Red (Orange red)
echo -e "\033]4;2;#FF8C00\007"   # Green (Dark orange)
echo -e "\033]4;3;#FFA500\007"   # Yellow (Orange)
echo -e "\033]4;4;#FF69B4\007"   # Blue (Hot pink)
echo -e "\033]4;5;#FF1493\007"   # Magenta (Deep pink)
echo -e "\033]4;6;#FFB347\007"   # Cyan (Apricot)
echo -e "\033]4;7;#FFF8E7\007"   # White (Cosmic latte)
THEME

# Theme 8: Forest Grove (Green/Brown)
cat > ~/.config/terminal-themes/forest-grove.sh << 'THEME'
# Forest Grove Theme
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxegedabagacad

# Terminal colors
echo -e "\033]10;#E8F5E9\007"  # Foreground: Pale green
echo -e "\033]11;#0B190D\007"  # Background: Deep forest
echo -e "\033]12;#8FBC8F\007"  # Cursor: Dark sea green

# ANSI Colors
echo -e "\033]4;0;#0B190D\007"   # Black (Deep forest)
echo -e "\033]4;1;#8B4513\007"   # Red (Saddle brown)
echo -e "\033]4;2;#228B22\007"   # Green (Forest green)
echo -e "\033]4;3;#9ACD32\007"   # Yellow (Yellow green)
echo -e "\033]4;4;#2E8B57\007"   # Blue (Sea green)
echo -e "\033]4;5;#556B2F\007"   # Magenta (Dark olive)
echo -e "\033]4;6;#3CB371\007"   # Cyan (Medium sea green)
echo -e "\033]4;7;#E8F5E9\007"   # White (Honeydew)
THEME

# Theme 9: Midnight Quill (Indigo/Silver)
cat > ~/.config/terminal-themes/midnight-quill.sh << 'THEME'
# Midnight Quill Theme
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxegedabagacad

# Terminal colors
echo -e "\033]10;#EAEAEA\007"  # Foreground: Silver ink
echo -e "\033]11;#0A0F1A\007"  # Background: Midnight blue
echo -e "\033]12;#6A5ACD\007"  # Cursor: Slate blue

# ANSI Colors
echo -e "\033]4;0;#0A0F1A\007"   # Black (Midnight)
echo -e "\033]4;1;#8B008B\007"   # Red (Dark magenta)
echo -e "\033]4;2;#483D8B\007"   # Green (Dark slate blue)
echo -e "\033]4;3;#BDB76B\007"   # Yellow (Dark khaki)
echo -e "\033]4;4;#4169E1\007"   # Blue (Royal blue)
echo -e "\033]4;5;#6A5ACD\007"   # Magenta (Slate blue)
echo -e "\033]4;6;#40E0D0\007"   # Cyan (Turquoise)
echo -e "\033]4;7;#EAEAEA\007"   # White (Platinum)
THEME

echo "✅ Created 6 additional cursive themes!"
echo ""
echo "New themes available:"
echo "  🏴‍☠️ pirate-scroll"
echo "  🧛 vampires-letter"
echo "  🌊 ocean-mist"
echo "  🌅 sunset-glow"
echo "  🌲 forest-grove"
echo "  🌙 midnight-quill"
EOF

# Make the extended themes executable and run it
chmod +x ~/.config/terminal-themes/extended_themes.sh
~/.config/terminal-themes/extended_themes.sh

echo ""
echo "🎨 All 9 cursive themes are now available!"
echo ""
echo "Complete theme list:"
ls -1 ~/.config/terminal-themes/*.sh | grep -v extended | sed 's/.*\///' | sed 's/.sh$//' | nl
echo ""
echo "To activate any theme:"
echo "  source ~/.config/terminal-themes/THEME-NAME.sh"
echo ""
echo "Try the vampire theme you were looking for:"
echo "  source ~/.config/terminal-themes/vampires-letter.sh"