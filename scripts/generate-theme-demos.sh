#!/bin/bash

# Theme Demo Generator for Cursive Terminal
# Generates individual demo pages for each theme

set -euo pipefail

# Theme data arrays
declare -a THEMES=(
    "cursive-elegance:✨ Purple/Gold - Sophisticated and elegant:dark:#1a1a2e:#e8e3e3:#ffd700"
    "cursive-noir:⚫ Black/Silver - Classic monochrome sophistication:dark:#0a0a0a:#c0c0c0:#ffffff"
    "cursive-garden:🌿 Green/Brown - Natural earth tones:dark:#1a1f1a:#e0e5d0:#8fbc8f"
    "pirate-scroll:🏴‍☠️ Brown/Gold - Weather-beaten parchment:dark:#341A0F:#FFEBCD:#FFD700"
    "vampires-letter:🧛 Black/Red - Dark velvet night:dark:#0B0A0C:#F8F8F8:#FF0033"
    "ocean-mist:🌊 Blue/Teal - Deep-sea blues:dark:#012B36:#E0F7FA:#00C2D1"
    "sunset-glow:🌅 Orange/Pink - Warm sunset colors:dark:#2E1503:#FFF8E7:#FFA500"
    "forest-grove:🌲 Green/Brown - Deep forest:dark:#0B190D:#E8F5E9:#8FBC8F"
    "midnight-quill:🌙 Indigo/Silver - Night sky:dark:#0A0F1A:#EAEAEA:#6A5ACD"
    "ancient-papyrus:📜 Beige/Brown - Aged papyrus:light:#F5E6D3:#4B3621:#8B4513"
    "ivory-parchment:🏛️ Ivory/Brown - Smooth ivory:light:#FFFFF0:#4B0082:#800080"
    "linen-manuscript:🧵 Linen/Slate - Natural texture:light:#FAF0E6:#2F4F4F:#708090"
    "calligraphy-scroll:✒️ Cream/Black - Classic calligraphy:light:#FDFCFA:#000000:#FF0000"
    "illuminated-manuscript:🎨 Blue/Navy - Medieval illuminated:light:#FFF8DC:#8B4513:#FFD700"
    "invisible-ink:🔍 Light Gray - Secret messages:light:#F8F8FF:#4B0082:#9400D3"
    "rainbow-prism:🌈 Dark/Vibrant - Rainbow highlights:colorful:#1A1A1A:#FFFFFF:#FF00FF"
    "neon-cyberpunk:⚡ Black/Green - Matrix neon:colorful:#000000:#00FF00:#00FFFF"
    "tropical-paradise:🌺 Teal/Orange - Tropical colors:colorful:#006B76:#FFFFFF:#FF6F61"
    "cotton-candy:🍭 Pink/Purple - Soft swirls:colorful:#FFE5F1:#4A0E4E:#FF69B4"
    "aurora-borealis:🌌 Navy/Green - Aurora lights:colorful:#001F3F:#E8F8F5:#00FF7F"
    "sunset-festival:🎪 Purple/Orange - Festival vibes:colorful:#4B0082:#FFF8DC:#FF8C00"
    "office-memo:📄 White/Blue - Professional:business:#FFFFFF:#000080:#0000FF"
    "receipt-paper:🧾 Cream/Black - Thermal paper:business:#F5F5DC:#1C1C1C:#000000"
    "carbon-copy:📑 Lavender/Purple - Carbon paper:business:#E6E6FA:#4B0082:#6A0DAD"
    "blueprint-tech:📐 Blue/Cyan - Technical blueprint:business:#003366:#FFFFFF:#00FFFF"
    "legal-document:⚖️ White/Brown - Formal legal:business:#FFFEF7:#3B2F2F:#8B4513"
    "ditto-spirit:🖨️ Blue/Purple - Ditto machine:business:#E6E6FA:#6A0DAD:#9370DB"
    "papyrus-scroll:📜 Ochre/Brown - WCAG-AA compliant:feather:#F4E4C1:#5A4632:#D7B66D"
    "ancient-parchment:🦴 Ivory/Sepia - Warm sepia:feather:#F8F5EC:#594A36:#D4B483"
    "linen-sheet:🧵 White/Charcoal - Cool white:feather:#FBFAF7:#4F4F4A:#A4B69F"
    "calligraphy-flourish:✒️ Pearl/Black - High contrast:feather:#FCFCFC:#1F1F1F:#7571E6"
    "invisible-ink-revealed:🕵️ Pale Lemon - Easter egg!:feather:#FFFFF2:#FFFFF2:#F7E96B"
)

# Output directory
OUTPUT_DIR="${1:-/Users/studio/Cursive-Terminal/docs/themes}"
TEMPLATE_FILE="theme-demo-template.html"

# Create output directory
mkdir -p "$OUTPUT_DIR"

echo "🎨 Generating theme demo pages..."

# Function to generate a single theme page
generate_theme_page() {
    local theme_data="$1"
    IFS=':' read -r theme_name display_name category bg_color fg_color cursor_color <<< "$theme_data"
    
    echo "  📄 Generating: $theme_name.html"
    
    # Prepare contrast info based on category
    local contrast_info=""
    case "$category" in
        "dark")
            contrast_info="Optimized for low-light environments with gentle contrast"
            ;;
        "light")
            contrast_info="High readability in bright environments"
            ;;
        "colorful")
            contrast_info="Vibrant colors balanced for visual comfort"
            ;;
        "business")
            contrast_info="Professional appearance with optimal readability"
            ;;
        "feather")
            contrast_info="WCAG-AA compliant with contrast ratio ≥ 4.5:1"
            ;;
    esac
    
    # Generate the HTML file
    sed -e "s/{{THEME_NAME}}/$theme_name/g" \
        -e "s/{{THEME_DISPLAY_NAME}}/$display_name/g" \
        -e "s/{{THEME_DESCRIPTION}}/${display_name#* }/g" \
        -e "s/{{THEME_CATEGORY}}/$category themes/g" \
        -e "s/{{BG_COLOR}}/$bg_color/g" \
        -e "s/{{FG_COLOR}}/$fg_color/g" \
        -e "s/{{CURSOR_COLOR}}/$cursor_color/g" \
        -e "s/{{CONTRAST_INFO}}/$contrast_info/g" \
        -e "s/{{COLOR_0}}/#000000/g" \
        -e "s/{{COLOR_1}}/#FF0000/g" \
        -e "s/{{COLOR_2}}/#00FF00/g" \
        -e "s/{{COLOR_3}}/#FFFF00/g" \
        -e "s/{{COLOR_4}}/#0000FF/g" \
        -e "s/{{COLOR_5}}/#FF00FF/g" \
        -e "s/{{COLOR_6}}/#00FFFF/g" \
        -e "s/{{COLOR_7}}/#FFFFFF/g" \
        -e "s|{{SCREENSHOTS}}|<div class=\"screenshot\"><img src=\"../images/theme-demos/$theme_name/demo.png\" alt=\"$display_name demo\"></div>|g" \
        "$TEMPLATE_FILE" > "$OUTPUT_DIR/$theme_name.html"
}

# Generate pages for all themes
for theme_data in "${THEMES[@]}"; do
    generate_theme_page "$theme_data"
done

# Generate the main index page
cat > "$OUTPUT_DIR/index.html" << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cursive Terminal Themes Gallery</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Victor+Mono:ital,wght@0,400;0,700;1,400;1,700&display=swap');
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: #0a0a0a;
            color: #e0e0e0;
            line-height: 1.6;
        }
        
        .hero {
            background: linear-gradient(135deg, #1a1a2e 0%, #0a0a0a 100%);
            padding: 80px 20px;
            text-align: center;
            border-bottom: 2px solid #ffd700;
        }
        
        .hero h1 {
            font-family: 'Victor Mono', monospace;
            font-style: italic;
            font-size: 4em;
            margin-bottom: 20px;
            background: linear-gradient(45deg, #ffd700, #ff6b6b, #4ecdc4, #45b7d1);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: gradient 3s ease infinite;
        }
        
        @keyframes gradient {
            0%, 100% { filter: hue-rotate(0deg); }
            50% { filter: hue-rotate(30deg); }
        }
        
        .filters {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin: 40px 0;
            flex-wrap: wrap;
        }
        
        .filter-btn {
            padding: 10px 20px;
            border: 2px solid #333;
            background: transparent;
            color: #e0e0e0;
            border-radius: 25px;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 14px;
        }
        
        .filter-btn:hover, .filter-btn.active {
            border-color: #ffd700;
            color: #ffd700;
            transform: translateY(-2px);
        }
        
        .themes-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 30px;
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        
        .theme-card {
            background: rgba(255,255,255,0.05);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
            display: block;
        }
        
        .theme-card:hover {
            transform: translateY(-5px);
            border-color: #ffd700;
            box-shadow: 0 10px 30px rgba(255,215,0,0.2);
        }
        
        .theme-preview {
            height: 200px;
            padding: 20px;
            font-family: 'Victor Mono', monospace;
            font-style: italic;
            font-size: 14px;
            position: relative;
            overflow: hidden;
        }
        
        .theme-info {
            padding: 20px;
            background: rgba(0,0,0,0.5);
        }
        
        .theme-name {
            font-size: 1.2em;
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .theme-description {
            font-size: 0.9em;
            opacity: 0.8;
        }
        
        .color-dots {
            position: absolute;
            bottom: 10px;
            right: 10px;
            display: flex;
            gap: 5px;
        }
        
        .color-dot {
            width: 20px;
            height: 20px;
            border-radius: 50%;
            border: 2px solid rgba(255,255,255,0.3);
        }
    </style>
</head>
<body>
    <header class="hero">
        <h1>Cursive Terminal Themes</h1>
        <p style="font-size: 1.2em; opacity: 0.9;">33 Beautiful Themes for Your Cursive Coding Experience</p>
    </header>
    
    <div class="filters">
        <button class="filter-btn active" data-filter="all">All Themes (33)</button>
        <button class="filter-btn" data-filter="dark">Dark (9)</button>
        <button class="filter-btn" data-filter="light">Light (6)</button>
        <button class="filter-btn" data-filter="colorful">Colorful (6)</button>
        <button class="filter-btn" data-filter="business">Business (6)</button>
        <button class="filter-btn" data-filter="feather">WCAG-AA (6)</button>
    </div>
    
    <main class="themes-grid" id="themesGrid">
        <!-- Theme cards will be generated here -->
    </main>
    
    <script>
        const themes = [
EOF

# Add theme data to index
for theme_data in "${THEMES[@]}"; do
    IFS=':' read -r theme_name display_name category bg_color fg_color cursor_color <<< "$theme_data"
    cat >> "$OUTPUT_DIR/index.html" << EOF
            {
                name: '$theme_name',
                displayName: '$display_name',
                category: '$category',
                bgColor: '$bg_color',
                fgColor: '$fg_color',
                cursorColor: '$cursor_color'
            },
EOF
done

# Complete the index page
cat >> "$OUTPUT_DIR/index.html" << 'EOF'
        ];
        
        const themesGrid = document.getElementById('themesGrid');
        const filterBtns = document.querySelectorAll('.filter-btn');
        
        function createThemeCard(theme) {
            return `
                <a href="${theme.name}.html" class="theme-card" data-category="${theme.category}">
                    <div class="theme-preview" style="background: ${theme.bgColor}; color: ${theme.fgColor};">
                        <div>// ${theme.displayName.split(' ')[0]}</div>
                        <div>function <span style="color: ${theme.cursorColor}">demo</span>() {</div>
                        <div>  return 'Beautiful cursive code';</div>
                        <div>}</div>
                        <div class="color-dots">
                            <div class="color-dot" style="background: ${theme.bgColor}"></div>
                            <div class="color-dot" style="background: ${theme.fgColor}"></div>
                            <div class="color-dot" style="background: ${theme.cursorColor}"></div>
                        </div>
                    </div>
                    <div class="theme-info">
                        <div class="theme-name">${theme.displayName.split(' ')[0]}</div>
                        <div class="theme-description">${theme.displayName.substring(theme.displayName.indexOf(' ') + 1)}</div>
                    </div>
                </a>
            `;
        }
        
        function renderThemes(filter = 'all') {
            const filteredThemes = filter === 'all' 
                ? themes 
                : themes.filter(t => t.category === filter);
            
            themesGrid.innerHTML = filteredThemes.map(createThemeCard).join('');
        }
        
        filterBtns.forEach(btn => {
            btn.addEventListener('click', () => {
                filterBtns.forEach(b => b.classList.remove('active'));
                btn.classList.add('active');
                renderThemes(btn.dataset.filter);
            });
        });
        
        // Initial render
        renderThemes();
    </script>
</body>
</html>
EOF

echo "✅ Generated ${#THEMES[@]} theme demo pages"
echo "📁 Output directory: $OUTPUT_DIR"
echo ""
echo "Next steps:"
echo "1. Generate screenshots for each theme"
echo "2. Place screenshots in docs/images/theme-demos/[theme-name]/"
echo "3. Deploy to GitHub Pages"