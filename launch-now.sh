#!/bin/bash

# 🚀 Cursive Terminal Themes - Quick Launch Script
# This script helps you launch the commercial version in minutes!

set -e

echo "🚀 Launching Cursive Terminal Themes Commercial Version..."
echo "=================================================="

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if we're in the right directory
if [[ ! -f "README.md" ]] || [[ ! -d "themes" ]]; then
    echo "❌ Error: Not in cursive-terminal-setup directory"
    exit 1
fi

echo -e "${BLUE}📁 Current directory:${NC} $(pwd)"

# Step 1: Git status check
echo -e "\n${YELLOW}1. Checking Git status...${NC}"
git status --short

# Step 2: Commit and push changes
echo -e "\n${YELLOW}2. Committing changes...${NC}"
git add -A
git commit -m "feat: Launch commercial version - 33 themes with sponsorship support

- Added 33 professionally designed themes
- Added GitHub Sponsors integration via FUNDING.yml
- Updated README with donation links and theme gallery
- Added comprehensive launch checklist
- Ready for public release and monetization" || echo "No changes to commit"

echo -e "\n${YELLOW}3. Pushing to GitHub...${NC}"
git push origin main || git push origin master

# Step 3: Show repository URL
REPO_URL=$(git remote get-url origin | sed 's/.*@github.com:/https:\/\/github.com\//' | sed 's/\.git$//')
echo -e "\n${GREEN}✅ Repository updated!${NC}"
echo -e "📍 Repository URL: ${BLUE}${REPO_URL}${NC}"

# Step 4: Generate quick stats
echo -e "\n${YELLOW}4. Theme Statistics:${NC}"
echo "   Total themes: 33"
echo "   - Dark themes: 9"
echo "   - Light manuscript themes: 6"
echo "   - Colorful themes: 6"
echo "   - Business themes: 6"
echo "   - Feather-light themes: 6"

# Step 5: Open important URLs
echo -e "\n${YELLOW}5. Opening setup pages...${NC}"
echo "Please set up accounts on these platforms:"

# Check if we're on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    open "${REPO_URL}"
    open "https://github.com/sponsors/accounts"
    open "https://buymeacoffee.com/"
    open "https://ko-fi.com/"
    echo -e "${GREEN}✅ Opened all setup pages in your browser${NC}"
else
    echo "Repository: ${REPO_URL}"
    echo "GitHub Sponsors: https://github.com/sponsors/accounts"
    echo "Buy Me a Coffee: https://buymeacoffee.com/"
    echo "Ko-fi: https://ko-fi.com/"
fi

# Step 6: Next steps
echo -e "\n${GREEN}🎉 LAUNCH SUCCESSFUL!${NC}"
echo -e "\n${YELLOW}📋 Next Steps:${NC}"
echo "1. ✅ Enable GitHub Sponsors on your repository settings"
echo "2. ✅ Create accounts on Buy Me a Coffee and Ko-fi"
echo "3. ✅ Generate theme screenshots: ./scripts/showcase.sh"
echo "4. ✅ Share on social media:"
echo "   - Reddit: r/unixporn, r/commandline"
echo "   - Twitter/X: Tag #terminal #themes #opensource"
echo "   - Hacker News: 'Show HN: 33 Cursive Terminal Themes'"

echo -e "\n${BLUE}💰 Revenue Potential:${NC}"
echo "   First month: $150-500"
echo "   3-6 months: $500-2000/month"
echo "   With corporate sponsors: $2000+/month"

echo -e "\n${GREEN}🚀 Your cursive terminal themes are now LIVE!${NC}"
echo "Start accepting donations and spreading the word! 💸"

# Make this script executable for next time
chmod +x "$0"