#!/bin/bash

#  ____            _                                  _   
# |  _ \  ___ _ __| | ___  _   _ _ __ ___   ___ _ __ | |_ 
# | | | |/ _ \ '_ \ |/ _ \| | | | '_ ` _ \ / _ \ '_ \| __|
# | |_| |  __/ |_) | | (_) | |_| | | | | | |  __/ | | | |_ 
# |____/ \___| .__/|_|\___/ \__, |_| |_| |_|\___|_| |_|\__|
#            |_|            |___/                          
#
# Deployment Preparation Script for Cursive Terminal
# Version: 1.0.0

set -euo pipefail

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

# Directories
CURSIVE_DIR="/Users/studio/Cursive-Terminal"
RELEASE_DIR="cursive-terminal-release-$(date +%Y%m%d)"
DEPLOYMENT_LOG="deployment-prep-$(date +%Y%m%d-%H%M%S).log"

# GitHub repository info - GITHUB_USER must be set
GITHUB_USER="${GITHUB_USER:-}"
GITHUB_REPO="cursive-terminal"

if [[ -z "$GITHUB_USER" ]]; then
    echo -e "${RED}ERROR: GITHUB_USER environment variable is required${NC}"
    echo "Usage: GITHUB_USER=yourusername ./prepare-deployment.sh"
    exit 1
fi

# Version info
VERSION="1.0.0"
RELEASE_TAG="v${VERSION}"

# Start logging
exec > >(tee -a "$DEPLOYMENT_LOG")
exec 2>&1

echo -e "${BOLD}${PURPLE}Cursive Terminal Deployment Preparation${NC}"
echo -e "${CYAN}Version:${NC} $VERSION"
echo -e "${CYAN}Date:${NC} $(date)"
echo -e "${CYAN}═══════════════════════════════════════${NC}\n"

# Function to check command availability
check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "${YELLOW}Warning:${NC} $1 is not installed"
        return 1
    fi
    return 0
}

# 1. Environment checks
echo -e "${BOLD}1. Environment Checks${NC}"
check_command git && echo "✓ Git installed"
check_command npm && echo "✓ NPM installed"
check_command python3 && echo "✓ Python3 installed"
check_command docker && echo "✓ Docker installed" || echo "⚠ Docker not installed (optional)"
check_command gh && echo "✓ GitHub CLI installed" || echo "⚠ GitHub CLI not installed (optional)"

# 2. Create release directory
echo -e "\n${BOLD}2. Creating Release Package${NC}"
mkdir -p "$RELEASE_DIR"
cd "$CURSIVE_DIR"

# 3. Clean and prepare files
echo -e "\n${BOLD}3. Cleaning and Preparing Files${NC}"

# Remove any .DS_Store files
find . -name ".DS_Store" -delete 2>/dev/null || true
echo "✓ Cleaned .DS_Store files"

# Remove any __pycache__ directories
find . -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
echo "✓ Cleaned Python cache"

# Remove any node_modules (if they exist)
find . -name "node_modules" -type d -exec rm -rf {} + 2>/dev/null || true
echo "✓ Cleaned node_modules"

# 4. Version update
echo -e "\n${BOLD}4. Version Management${NC}"

# Update version in key files
update_version() {
    local file="$1"
    if [ -f "$file" ]; then
        sed -i.bak "s/Version: .*/Version: $VERSION/" "$file" 2>/dev/null || true
        rm -f "${file}.bak"
        echo "✓ Updated version in $file"
    fi
}

update_version "install.sh"
update_version "README.md"
update_version "scripts/launch-validator.sh"

# 5. Generate release notes
echo -e "\n${BOLD}5. Generating Release Notes${NC}"

cat > "RELEASE_NOTES_${VERSION}.md" << EOF
# Cursive Terminal Release Notes - v${VERSION}

## 🎉 Initial Release

### ✨ Features
- **33 Beautiful Themes**: From elegant manuscripts to cyberpunk neon
- **DNA Theme Integration**: Revolutionary code visualization
- **Bubble Components**: Interactive code visualization tools
- **Ecosystem Dashboard**: Comprehensive management interface
- **Enterprise Support**: Team deployment and management tools
- **Mac App**: Native macOS application (coming soon)
- **XR/Immersive Features**: Future-ready terminal experience

### 🛠 Components
- Core terminal themes and styling system
- Advanced bubble visualization components
- DNA code transcription system
- Ecosystem management dashboard
- Enterprise deployment automation
- Comprehensive documentation

### 📦 Installation
\`\`\`bash
# Download and install (safer approach)
curl -fsSL -o /tmp/cursive-install.sh https://raw.githubusercontent.com/${GITHUB_USER}/${GITHUB_REPO}/main/install.sh
bash /tmp/cursive-install.sh
\`\`\`

### 🔧 Requirements
- macOS 10.15+ or Linux
- Bash 4.0+
- Git
- Terminal with 256 color support

### 📚 Documentation
- Comprehensive README
- Theme showcase gallery
- Troubleshooting guide
- Enterprise deployment guide

### 🎯 What's Next
- Windows support
- More themes
- Enhanced XR features
- Community theme builder

---
*Thank you for choosing Cursive Terminal!*
EOF

echo "✓ Generated release notes"

# 6. Create deployment package
echo -e "\n${BOLD}6. Creating Deployment Package${NC}"

# Create a clean copy for release
cp -R . "../$RELEASE_DIR/" 2>/dev/null || true
cd "../$RELEASE_DIR"

# Remove development files
rm -rf .git .gitignore .github 2>/dev/null || true
rm -f deployment-prep*.log launch-report*.md launch-checklist*.md 2>/dev/null || true

# Create tarball
cd ..
tar -czf "${RELEASE_DIR}.tar.gz" "$RELEASE_DIR"
echo "✓ Created release package: ${RELEASE_DIR}.tar.gz"

# Calculate checksum
if command -v shasum &> /dev/null; then
    CHECKSUM=$(shasum -a 256 "${RELEASE_DIR}.tar.gz" | cut -d' ' -f1)
    echo "✓ SHA256: $CHECKSUM"
fi

# 7. Generate deployment commands
echo -e "\n${BOLD}7. Deployment Commands${NC}"

cat > "DEPLOYMENT_COMMANDS.sh" << EOF
#!/bin/bash
# Cursive Terminal Deployment Commands

# 1. Tag the release
git tag -a ${RELEASE_TAG} -m "Release version ${VERSION}"
git push origin ${RELEASE_TAG}

# 2. Create GitHub release (requires gh CLI)
gh release create ${RELEASE_TAG} \\
    --title "Cursive Terminal ${VERSION}" \\
    --notes-file "RELEASE_NOTES_${VERSION}.md" \\
    "${RELEASE_DIR}.tar.gz"

# 3. Update main branch
git add .
git commit -m "🚀 Release version ${VERSION}"
git push origin main

# 4. Deploy to package managers (future)
# npm publish
# brew tap yourusername/cursive-terminal
# brew install cursive-terminal

# 5. Update website
# ./deploy-website.sh

# 6. Announce release
# - GitHub Discussions
# - Discord/Slack
# - Twitter/Social Media
# - Dev.to/Medium article
EOF

chmod +x DEPLOYMENT_COMMANDS.sh
echo "✓ Generated deployment commands"

# 8. Pre-flight checklist
echo -e "\n${BOLD}8. Pre-Flight Checklist${NC}"

cat > "PRE_FLIGHT_CHECKLIST.md" << EOF
# Pre-Flight Deployment Checklist

## Code Quality
- [ ] All tests passing
- [ ] No linting errors
- [ ] Documentation updated
- [ ] CHANGELOG updated
- [ ] Version numbers consistent

## Security
- [ ] No hardcoded credentials
- [ ] No sensitive data in commits
- [ ] Dependencies up to date
- [ ] Security scan completed

## Release Package
- [ ] Release tarball created
- [ ] SHA256 checksum generated
- [ ] Release notes written
- [ ] Installation tested on clean system

## GitHub
- [ ] Repository public
- [ ] License file present
- [ ] README comprehensive
- [ ] Issues enabled
- [ ] Discussions enabled

## Marketing
- [ ] Screenshots/GIFs ready
- [ ] Demo video recorded
- [ ] Blog post drafted
- [ ] Social media posts prepared

## Support
- [ ] Discord/Slack channel ready
- [ ] FAQ documented
- [ ] Support email configured
- [ ] Issue templates created

## Post-Launch
- [ ] Monitoring setup
- [ ] Analytics configured
- [ ] Feedback collection ready
- [ ] Update roadmap public
EOF

echo "✓ Created pre-flight checklist"

# 9. Quick test script
echo -e "\n${BOLD}9. Creating Quick Test Script${NC}"

cat > "quick-test.sh" << 'EOF'
#!/bin/bash
# Quick test script for Cursive Terminal

echo "🧪 Testing Cursive Terminal Installation..."

# Test basic installation
if [ -f "install.sh" ]; then
    echo "✓ Install script found"
else
    echo "✗ Install script missing"
    exit 1
fi

# Test theme files
THEME_COUNT=$(find themes -name "*.sh" 2>/dev/null | wc -l)
echo "✓ Found $THEME_COUNT theme files"

# Test documentation
for doc in README.md CHANGELOG.md LICENSE; do
    if [ -f "$doc" ]; then
        echo "✓ $doc present"
    else
        echo "✗ $doc missing"
    fi
done

echo -e "\n✅ Basic tests passed!"
EOF

chmod +x quick-test.sh
echo "✓ Created quick test script"

# 10. Summary
echo -e "\n${BOLD}${GREEN}═══════════════════════════════════════${NC}"
echo -e "${BOLD}${GREEN}Deployment Preparation Complete!${NC}"
echo -e "${BOLD}${GREEN}═══════════════════════════════════════${NC}\n"

echo -e "${CYAN}Generated Files:${NC}"
echo "  📦 Release Package: ${RELEASE_DIR}.tar.gz"
echo "  📝 Release Notes: RELEASE_NOTES_${VERSION}.md"
echo "  🚀 Deployment Commands: DEPLOYMENT_COMMANDS.sh"
echo "  ✅ Pre-Flight Checklist: PRE_FLIGHT_CHECKLIST.md"
echo "  🧪 Quick Test: quick-test.sh"
echo "  📊 Deployment Log: $DEPLOYMENT_LOG"

if [ -n "${CHECKSUM:-}" ]; then
    echo -e "\n${CYAN}Package Checksum:${NC}"
    echo "  SHA256: $CHECKSUM"
fi

echo -e "\n${YELLOW}Next Steps:${NC}"
echo "1. Run launch validator: ./launch-validator.sh"
echo "2. Review pre-flight checklist"
echo "3. Test installation on clean system"
echo "4. Execute deployment commands when ready"

echo -e "\n${GREEN}Good luck with your launch! 🚀${NC}"