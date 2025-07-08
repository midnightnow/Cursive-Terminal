#!/bin/bash
# Showcase GIF Generator for Cursive Terminal Setup
# Creates an animated demo of the cursive terminal in action

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color
BOLD='\033[1m'
ITALIC='\033[3m'

echo -e "${PURPLE}${BOLD}🎬 Cursive Terminal Showcase GIF Generator${NC}"
echo "=============================================="
echo ""

# Check dependencies
check_dependency() {
    if ! command -v $1 &> /dev/null; then
        echo -e "${RED}❌ $1 is not installed${NC}"
        return 1
    else
        echo -e "${GREEN}✅ $1 found${NC}"
        return 0
    fi
}

echo "🔍 Checking dependencies..."
dependencies_ok=true

if ! check_dependency "asciinema"; then
    echo -e "${YELLOW}📦 Install with: brew install asciinema${NC}"
    dependencies_ok=false
fi

if ! check_dependency "agg"; then
    echo -e "${YELLOW}📦 Install with: cargo install --git https://github.com/asciinema/agg${NC}"
    dependencies_ok=false
fi

if [ "$dependencies_ok" = false ]; then
    echo ""
    echo -e "${RED}❌ Missing dependencies. Please install the required tools first.${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}🎥 Recording showcase demo...${NC}"

# Create a temporary script for the demo
cat > /tmp/cursive_demo.sh << 'EOF'
#!/bin/bash

# Demo script for cursive terminal recording
sleep 2

echo -e "\033[1m\033[35m✒️  Welcome to Cursive Terminal Setup!\033[0m"
echo ""
sleep 2

echo -e "This is \033[3mbeautiful cursive text\033[0m in your terminal"
sleep 2

echo ""
echo -e "\033[1mFont comparison:\033[0m"
sleep 1

echo -e "Regular: function fibonacci(n) {"
sleep 1
echo -e "\033[3mCursive:  function fibonacci(n) {\033[0m"
sleep 2

echo ""
echo -e "\033[1mCode example:\033[0m"
sleep 1

cat << 'CODE'
const greeting = "Hello, cursive world!";

// Beautiful cursive comments
function createMagic() {
    return Array.from({length: 5}, (_, i) => 
        `✨ Cursive line ${i + 1}`
    );
}

console.log(createMagic());
CODE

sleep 3

echo ""
echo -e "\033[3mCoding in cursive feels like writing poetry! ✨\033[0m"
sleep 2

echo ""
echo -e "\033[1m\033[32m🎉 Your terminal is now beautifully cursive!\033[0m"
sleep 2
EOF

chmod +x /tmp/cursive_demo.sh

# Record the demo
echo "🔴 Recording... (this will take about 30 seconds)"
asciinema rec /tmp/cursive_demo.cast \
    --title "Cursive Terminal Setup Demo" \
    --command "/tmp/cursive_demo.sh" \
    --overwrite \
    --quiet

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Recording completed${NC}"
else
    echo -e "${RED}❌ Recording failed${NC}"
    exit 1
fi

# Convert to GIF
echo ""
echo -e "${BLUE}🎨 Converting to GIF...${NC}"

# Create docs/images directory if it doesn't exist
mkdir -p docs/images

# Convert with optimized settings for GitHub
agg /tmp/cursive_demo.cast docs/images/cursive_demo.gif \
    --cols 80 \
    --rows 24 \
    --font-size 16 \
    --line-height 1.2 \
    --speed 1.5 \
    --theme monokai

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ GIF created: docs/images/cursive_demo.gif${NC}"
else
    echo -e "${RED}❌ GIF conversion failed${NC}"
    exit 1
fi

# Clean up
rm /tmp/cursive_demo.sh /tmp/cursive_demo.cast

# Update README with GIF
echo ""
echo -e "${BLUE}📝 Updating README with showcase GIF...${NC}"

# Check if README already has a GIF section
if ! grep -q "cursive_demo.gif" README.md; then
    # Create a backup
    cp README.md README.md.backup
    
    # Add GIF section after the main header
    sed -i '' '3i\
\
## 🎬 See It In Action\
\
![Cursive Terminal Demo](docs/images/cursive_demo.gif)\
\
' README.md
    
    echo -e "${GREEN}✅ README updated with showcase GIF${NC}"
else
    echo -e "${YELLOW}ℹ️  README already contains GIF reference${NC}"
fi

echo ""
echo -e "${PURPLE}${BOLD}🎉 Showcase GIF generation complete!${NC}"
echo ""
echo -e "📁 ${BOLD}Files created:${NC}"
echo -e "   • docs/images/cursive_demo.gif"
echo -e "   • README.md (updated)"
echo ""
echo -e "🚀 ${BOLD}Next steps:${NC}"
echo -e "   • git add docs/images/cursive_demo.gif README.md"
echo -e "   • git commit -m '🎬 Add animated showcase demo'"
echo -e "   • git push"
echo ""
echo -e "${GREEN}Your repository now has a beautiful animated demo! ✨${NC}"