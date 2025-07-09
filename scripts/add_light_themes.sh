#!/bin/bash

# Add 6 light/manuscript-inspired themes

echo "📜 Adding 6 light manuscript themes..."

# Create light themes file
cat >> ~/.config/terminal-themes/manuscript_themes.sh << 'EOF'
#!/bin/bash
# Light Manuscript-Inspired Cursive Terminal Themes

# Theme 10: Ancient Papyrus (Cream/Brown)
cat > ~/.config/terminal-themes/ancient-papyrus.sh << 'THEME'
# Ancient Papyrus Theme
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad

# Terminal colors
echo -e "\033]10;#4B3621\007"  # Foreground: Dark brown ink
echo -e "\033]11;#F5E6D3\007"  # Background: Papyrus cream
echo -e "\033]12;#8B4513\007"  # Cursor: Saddle brown

# ANSI Colors
echo -e "\033]4;0;#4B3621\007"   # Black (Brown ink)
echo -e "\033]4;1;#A0522D\007"   # Red (Sienna)
echo -e "\033]4;2;#556B2F\007"   # Green (Dark olive)
echo -e "\033]4;3;#B8860B\007"   # Yellow (Goldenrod)
echo -e "\033]4;4;#483D8B\007"   # Blue (Dark slate)
echo -e "\033]4;5;#8B4789\007"   # Magenta (Orchid)
echo -e "\033]4;6;#4682B4\007"   # Cyan (Steel blue)
echo -e "\033]4;7;#F5E6D3\007"   # White (Papyrus)
THEME

# Theme 11: Royal Parchment (Ivory/Purple)
cat > ~/.config/terminal-themes/royal-parchment.sh << 'THEME'
# Royal Parchment Theme
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad

# Terminal colors
echo -e "\033]10;#4B0082\007"  # Foreground: Indigo ink
echo -e "\033]11;#FFFFF0\007"  # Background: Ivory
echo -e "\033]12;#800080\007"  # Cursor: Royal purple

# ANSI Colors
echo -e "\033]4;0;#4B0082\007"   # Black (Indigo)
echo -e "\033]4;1;#8B008B\007"   # Red (Dark magenta)
echo -e "\033]4;2;#2E8B57\007"   # Green (Sea green)
echo -e "\033]4;3;#DAA520\007"   # Yellow (Goldenrod)
echo -e "\033]4;4;#4169E1\007"   # Blue (Royal blue)
echo -e "\033]4;5;#9370DB\007"   # Magenta (Medium purple)
echo -e "\033]4;6;#20B2AA\007"   # Cyan (Light sea green)
echo -e "\033]4;7;#FFFFF0\007"   # White (Ivory)
THEME

# Theme 12: Fine Linen (Gray/Blue)
cat > ~/.config/terminal-themes/fine-linen.sh << 'THEME'
# Fine Linen Theme
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad

# Terminal colors
echo -e "\033]10;#2F4F4F\007"  # Foreground: Dark slate gray
echo -e "\033]11;#FAF0E6\007"  # Background: Linen
echo -e "\033]12;#708090\007"  # Cursor: Slate gray

# ANSI Colors
echo -e "\033]4;0;#2F4F4F\007"   # Black (Dark slate)
echo -e "\033]4;1;#BC8F8F\007"   # Red (Rosy brown)
echo -e "\033]4;2;#8FBC8F\007"   # Green (Dark sea green)
echo -e "\033]4;3;#F0E68C\007"   # Yellow (Khaki)
echo -e "\033]4;4;#6495ED\007"   # Blue (Cornflower)
echo -e "\033]4;5;#DDA0DD\007"   # Magenta (Plum)
echo -e "\033]4;6;#B0C4DE\007"   # Cyan (Light steel blue)
echo -e "\033]4;7;#FAF0E6\007"   # White (Linen)
THEME

# Theme 13: Calligraphy Master (White/Black)
cat > ~/.config/terminal-themes/calligraphy-master.sh << 'THEME'
# Calligraphy Master Theme
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad

# Terminal colors
echo -e "\033]10;#000000\007"  # Foreground: India ink
echo -e "\033]11;#FDFCFA\007"  # Background: Rice paper white
echo -e "\033]12;#FF0000\007"  # Cursor: Red seal

# ANSI Colors
echo -e "\033]4;0;#000000\007"   # Black (India ink)
echo -e "\033]4;1;#DC143C\007"   # Red (Crimson)
echo -e "\033]4;2;#006400\007"   # Green (Dark green)
echo -e "\033]4;3;#FFD700\007"   # Yellow (Gold)
echo -e "\033]4;4;#000080\007"   # Blue (Navy)
echo -e "\033]4;5;#800080\007"   # Magenta (Purple)
echo -e "\033]4;6;#008B8B\007"   # Cyan (Dark cyan)
echo -e "\033]4;7;#FDFCFA\007"   # White (Rice paper)
THEME

# Theme 14: Illuminated Manuscript (Gold/Cream)
cat > ~/.config/terminal-themes/illuminated-manuscript.sh << 'THEME'
# Illuminated Manuscript Theme
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad

# Terminal colors
echo -e "\033]10;#8B4513\007"  # Foreground: Saddle brown
echo -e "\033]11;#FFF8DC\007"  # Background: Cornsilk
echo -e "\033]12;#FFD700\007"  # Cursor: Gold leaf

# ANSI Colors
echo -e "\033]4;0;#8B4513\007"   # Black (Saddle brown)
echo -e "\033]4;1;#B22222\007"   # Red (Firebrick)
echo -e "\033]4;2;#228B22\007"   # Green (Forest)
echo -e "\033]4;3;#FFD700\007"   # Yellow (Gold)
echo -e "\033]4;4;#4169E1\007"   # Blue (Royal)
echo -e "\033]4;5;#8B008B\007"   # Magenta (Dark)
echo -e "\033]4;6;#5F9EA0\007"   # Cyan (Cadet)
echo -e "\033]4;7;#FFF8DC\007"   # White (Cornsilk)
THEME

# Theme 15: Invisible Ink Revealed (UV/White)
cat > ~/.config/terminal-themes/invisible-ink.sh << 'THEME'
# Invisible Ink Revealed Theme
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad

# Terminal colors
echo -e "\033]10;#4B0082\007"  # Foreground: UV purple (revealed ink)
echo -e "\033]11;#F8F8FF\007"  # Background: Ghost white
echo -e "\033]12;#9400D3\007"  # Cursor: Violet (UV light)

# ANSI Colors
echo -e "\033]4;0;#4B0082\007"   # Black (Indigo)
echo -e "\033]4;1;#8A2BE2\007"   # Red (Blue violet)
echo -e "\033]4;2;#6A0DAD\007"   # Green (Purple)
echo -e "\033]4;3;#7B68EE\007"   # Yellow (Medium slate blue)
echo -e "\033]4;4;#6495ED\007"   # Blue (Cornflower)
echo -e "\033]4;5;#9370DB\007"   # Magenta (Medium purple)
echo -e "\033]4;6;#87CEEB\007"   # Cyan (Sky blue)
echo -e "\033]4;7;#F8F8FF\007"   # White (Ghost white)
THEME

echo "✅ Created 6 light manuscript themes!"
echo ""
echo "New light themes available:"
echo "  📜 ancient-papyrus"
echo "  👑 royal-parchment" 
echo "  🎋 fine-linen"
echo "  ✒️  calligraphy-master"
echo "  🌟 illuminated-manuscript"
echo "  👻 invisible-ink"
EOF

# Make the manuscript themes executable and run it
chmod +x ~/.config/terminal-themes/manuscript_themes.sh
~/.config/terminal-themes/manuscript_themes.sh

echo ""
echo "📚 All 15 cursive themes are now available!"
echo "   (9 original + 6 new light themes)"
echo ""
echo "Complete theme list:"
ls -1 ~/.config/terminal-themes/*.sh | grep -v -E "extended|manuscript" | sed 's/.*\///' | sed 's/.sh$//' | nl
echo ""
echo "Light themes for elegant manuscript-style coding:"
echo "  source ~/.config/terminal-themes/ancient-papyrus.sh"
echo "  source ~/.config/terminal-themes/royal-parchment.sh"
echo "  source ~/.config/terminal-themes/fine-linen.sh"
echo "  source ~/.config/terminal-themes/calligraphy-master.sh"
echo "  source ~/.config/terminal-themes/illuminated-manuscript.sh"
echo "  source ~/.config/terminal-themes/invisible-ink.sh"