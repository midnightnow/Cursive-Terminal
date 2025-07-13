#!/bin/bash
# Script to publish Cursive Terminal to GitHub

echo "🚀 Publishing Cursive Terminal to GitHub"
echo "========================================"

# Check if we're in the right directory
if [ ! -d ".git" ]; then
    echo "❌ Not in a git repository!"
    exit 1
fi

# Check current remote
echo "📡 Current remote configuration:"
git remote -v

# Create repository on GitHub using their web UI
echo ""
echo "📝 Please create the repository on GitHub:"
echo "1. Open: https://github.com/new"
echo "2. Repository name: cursive-terminal-setup"
echo "3. Description: 🎨 Beautiful cursive fonts for developers - Complete ecosystem with enterprise features, analytics, and community tools"
echo "4. Set as Public"
echo "5. DO NOT initialize with README, .gitignore, or license"
echo "6. Click 'Create repository'"
echo ""
read -p "Press Enter when you've created the repository on GitHub..."

# Push to GitHub
echo ""
echo "🚀 Pushing to GitHub..."
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Successfully published to GitHub!"
    echo "🌐 Your repository is now live at: https://github.com/midnightnow/cursive-terminal-setup"
else
    echo ""
    echo "❌ Push failed. Please check your GitHub authentication."
    echo "You may need to:"
    echo "1. Set up a Personal Access Token: https://github.com/settings/tokens"
    echo "2. Or use SSH: git remote set-url origin git@github.com:midnightnow/cursive-terminal-setup.git"
fi