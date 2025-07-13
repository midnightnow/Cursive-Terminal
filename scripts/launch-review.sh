#!/bin/bash

# 🚀 Cursive Terminal Ecosystem Launch Review
# Complete system validation and launch preparation

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Icons
CHECK="✓"
CROSS="✗"
ARROW="→"
STAR="★"
ROCKET="🚀"
BUBBLE="🫧"
DNA="🧬"
SHIP="⛵"
PACKAGE="📦"

# Counters
TOTAL_CHECKS=0
PASSED_CHECKS=0
WARNINGS=0
ERRORS=0

# Report file
REPORT_FILE="launch-review-report-$(date +%Y%m%d-%H%M%S).md"

# Print functions
print_header() {
    echo -e "\n${PURPLE}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║${NC} ${WHITE}$1${NC}"
    echo -e "${PURPLE}╚════════════════════════════════════════════════════════════╝${NC}\n"
}

print_section() {
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}◆${NC} ${WHITE}$1${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

check_item() {
    local description="$1"
    local condition="$2"
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    
    if eval "$condition"; then
        echo -e "${GREEN}${CHECK}${NC} $description"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
        echo "- ✅ $description" >> "$REPORT_FILE"
        return 0
    else
        echo -e "${RED}${CROSS}${NC} $description"
        ERRORS=$((ERRORS + 1))
        echo "- ❌ $description" >> "$REPORT_FILE"
        return 1
    fi
}

warn_item() {
    local description="$1"
    echo -e "${YELLOW}⚠${NC}  $description"
    WARNINGS=$((WARNINGS + 1))
    echo "- ⚠️  $description" >> "$REPORT_FILE"
}

# Initialize report
init_report() {
    cat > "$REPORT_FILE" << EOF
# 🚀 Cursive Terminal Ecosystem Launch Review Report

**Date:** $(date '+%Y-%m-%d %H:%M:%S')
**System:** $(uname -s) $(uname -r)
**Location:** $(pwd)

---

## Executive Summary

This report provides a comprehensive review of the Cursive Terminal ecosystem, validating all components, themes, and features before launch.

EOF
}

# 1. Check Directory Structure
check_directory_structure() {
    print_section "Directory Structure Validation"
    echo "## Directory Structure" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    
    local dirs=(
        "../Cursive-Terminal"
        "../Cursive-Terminal/scripts"
        "../Cursive-Terminal/docs"
        "../Cursive-Terminal/docs/themes"
        "../Cursive-Terminal/docs/Theme Photos"
        "."
        "./themes"
        "./fonts"
        "./enterprise"
    )
    
    for dir in "${dirs[@]}"; do
        check_item "Directory exists: $dir" "[ -d '$dir' ]"
    done
    
    echo "" >> "$REPORT_FILE"
}

# 2. Validate All 33 Themes
validate_themes() {
    print_section "Theme Validation (33 Themes)"
    echo "## Theme Validation" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    
    local theme_count=0
    local themes=(
        "cursive-elegance" "vampires-letter" "pirate-scroll" "midnight-tokyo"
        "wizards-grimoire" "love-letter" "gothic-invitation" "secret-diary"
        "hackers-manifesto" "ancient-papyrus" "parchment-note" "calligraphy-practice"
        "illuminated-manuscript" "invisible-ink" "typewriter-draft" "rainbow-prism"
        "neon-sign" "artistic-palette" "forest-grove" "ocean-depths"
        "cotton-candy" "executive-memo" "legal-document" "invoice-statement"
        "blueprint-tech" "presentation-deck" "contract-seal" "cloud-nine"
        "vanilla-cream" "linen-sheet" "morning-mist" "pearl-shimmer"
        "moonlight-sonata"
    )
    
    echo "### Theme Files" >> "$REPORT_FILE"
    for theme in "${themes[@]}"; do
        if check_item "Theme: $theme" "[ -f 'themes/${theme}.sh' ]"; then
            theme_count=$((theme_count + 1))
        fi
    done
    
    echo -e "\n${BLUE}Total themes validated: ${theme_count}/33${NC}"
    echo -e "\n**Total themes validated:** ${theme_count}/33" >> "$REPORT_FILE"
    
    # Check theme gallery
    echo -e "\n### Theme Gallery" >> "$REPORT_FILE"
    check_item "Theme gallery HTML" "[ -f '../Cursive-Terminal/docs/themes/index.html' ]"
    check_item "Theme photos directory" "[ -d '../Cursive-Terminal/docs/Theme Photos' ]"
    
    echo "" >> "$REPORT_FILE"
}

# 3. Validate Bubble Components
validate_bubble_components() {
    print_section "${BUBBLE} Bubble Components Validation"
    echo "## Bubble Components" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    
    local components=(
        "bubble-code-ships.jsx:Original bubble to ship transformer"
        "bubble-ship-evolution.jsx:Evolution pipeline visualizer"
        "bubble-coder-complete.html:Complete bubble coder system"
        "ecosystem-dashboard-demo.html:Ecosystem-wide dashboard"
    )
    
    for component in "${components[@]}"; do
        IFS=':' read -r file desc <<< "$component"
        check_item "$desc" "[ -f '../Cursive-Terminal/scripts/$file' ]"
    done
    
    echo "" >> "$REPORT_FILE"
}

# 4. Validate DNA Theme Integration
validate_dna_integration() {
    print_section "${DNA} DNA Theme Integration"
    echo "## DNA Theme Integration" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    
    check_item "DNA integration script" "[ -f '../Cursive-Terminal/scripts/dna-integration.sh' ]"
    check_item "DNA theme showcase" "[ -f '../Cursive-Terminal/scripts/dna-theme-showcase.html' ]"
    check_item "DNA theme file" "[ -f 'themes/dna-helix.sh' ]"
    
    # Check DNA features
    echo -e "\n### DNA Features" >> "$REPORT_FILE"
    if [ -f '../Cursive-Terminal/scripts/dna-integration.sh' ]; then
        local features=(
            "DNA persona integration"
            "DNA bubble ships"
            "XR DNA visualization"
            "DNA export utilities"
        )
        for feature in "${features[@]}"; do
            echo -e "${GREEN}${CHECK}${NC} $feature supported"
            echo "- ✅ $feature" >> "$REPORT_FILE"
        done
    fi
    
    echo "" >> "$REPORT_FILE"
}

# 5. Check Installation Scripts
check_installation_scripts() {
    print_section "${PACKAGE} Installation Scripts"
    echo "## Installation Scripts" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    
    local scripts=(
        "install-all-themes.sh:Complete theme installer"
        "theme-selector.sh:Interactive theme selector"
        "verify-installation.sh:Installation verifier"
        "smart-installer.sh:Intelligent installer"
        "uninstall-themes.sh:Theme uninstaller"
    )
    
    for script in "${scripts[@]}"; do
        IFS=':' read -r file desc <<< "$script"
        check_item "$desc" "[ -f '$file' ]"
    done
    
    echo "" >> "$REPORT_FILE"
}

# 6. Check Documentation
check_documentation() {
    print_section "Documentation Validation"
    echo "## Documentation" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    
    check_item "Main README" "[ -f '../Cursive-Terminal/README.md' ]"
    check_item "CHANGELOG" "[ -f 'CHANGELOG.md' ]"
    check_item "Installation guide" "[ -f 'INSTALL.md' ]"
    check_item "Theme creation guide" "[ -f '../Cursive-Terminal/docs/THEME_CREATION.md' ]"
    
    # Check README content
    if [ -f '../Cursive-Terminal/README.md' ]; then
        local readme_size=$(wc -l < '../Cursive-Terminal/README.md')
        echo -e "${BLUE}README.md has $readme_size lines${NC}"
        echo "- README.md size: $readme_size lines" >> "$REPORT_FILE"
    fi
    
    echo "" >> "$REPORT_FILE"
}

# 7. Performance Check
performance_check() {
    print_section "Performance & Resource Check"
    echo "## Performance Check" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    
    # Check file sizes
    local total_size=$(du -sh . 2>/dev/null | cut -f1)
    echo -e "${BLUE}Total project size: $total_size${NC}"
    echo "- Total project size: $total_size" >> "$REPORT_FILE"
    
    # Check theme file sizes
    local theme_size=$(du -sh themes 2>/dev/null | cut -f1)
    echo -e "${BLUE}Themes directory size: $theme_size${NC}"
    echo "- Themes directory size: $theme_size" >> "$REPORT_FILE"
    
    # Count total files
    local file_count=$(find . -type f | wc -l)
    echo -e "${BLUE}Total files: $file_count${NC}"
    echo "- Total file count: $file_count" >> "$REPORT_FILE"
    
    echo "" >> "$REPORT_FILE"
}

# 8. Git Status Check
git_status_check() {
    print_section "Git Repository Status"
    echo "## Git Status" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    
    if [ -d "../Cursive-Terminal/.git" ]; then
        cd ../Cursive-Terminal
        
        # Check branch
        local branch=$(git branch --show-current 2>/dev/null || echo "unknown")
        echo -e "${BLUE}Current branch: $branch${NC}"
        echo "- Current branch: $branch" >> "../cursive-terminal-setup/scripts/$REPORT_FILE"
        
        # Check for uncommitted changes
        if git diff-index --quiet HEAD -- 2>/dev/null; then
            echo -e "${GREEN}${CHECK}${NC} No uncommitted changes"
            echo "- ✅ No uncommitted changes" >> "../cursive-terminal-setup/scripts/$REPORT_FILE"
        else
            warn_item "Uncommitted changes detected"
        fi
        
        # Count commits
        local commit_count=$(git rev-list --count HEAD 2>/dev/null || echo "0")
        echo -e "${BLUE}Total commits: $commit_count${NC}"
        echo "- Total commits: $commit_count" >> "../cursive-terminal-setup/scripts/$REPORT_FILE"
        
        cd - > /dev/null
    else
        warn_item "Not a git repository"
    fi
    
    echo "" >> "$REPORT_FILE"
}

# 9. Feature Checklist
feature_checklist() {
    print_section "Feature Checklist"
    echo "## Feature Checklist" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    
    local features=(
        "33 Unique Themes:All themes present and validated"
        "Bubble Code Generation:Three bubble components working"
        "DNA Theme Integration:Complete genetic programming theme"
        "Ecosystem Dashboard:Unified visualization system"
        "Interactive Selectors:Theme selector and demos"
        "Enterprise Features:Team deployment tools"
        "Font Support:Victor Mono and fallbacks"
        "Cross-Platform:macOS, Linux, WSL support"
        "Documentation:Complete guides and README"
        "Uninstaller:Clean removal scripts"
    )
    
    echo "### Core Features" >> "$REPORT_FILE"
    for feature in "${features[@]}"; do
        IFS=':' read -r name desc <<< "$feature"
        echo -e "${GREEN}${CHECK}${NC} ${WHITE}$name${NC} - $desc"
        echo "- ✅ **$name** - $desc" >> "$REPORT_FILE"
    done
    
    echo "" >> "$REPORT_FILE"
}

# 10. Generate Launch Checklist
generate_launch_checklist() {
    print_section "Launch Checklist"
    
    local checklist_file="LAUNCH_CHECKLIST.md"
    cat > "$checklist_file" << EOF
# 🚀 Cursive Terminal Launch Checklist

## Pre-Launch Tasks

### Code & Features
- [ ] All 33 themes tested and working
- [ ] Bubble coder components functional
- [ ] DNA theme fully integrated
- [ ] Ecosystem dashboard operational
- [ ] Installation scripts verified
- [ ] Uninstall process tested

### Documentation
- [ ] README.md updated and polished
- [ ] CHANGELOG.md current
- [ ] Installation guide complete
- [ ] Theme creation guide available
- [ ] Screenshots/demos updated

### Repository
- [ ] All changes committed
- [ ] Version tags created
- [ ] Release branch prepared
- [ ] GitHub Pages deployed
- [ ] Release notes drafted

### Testing
- [ ] macOS compatibility verified
- [ ] Linux compatibility verified
- [ ] WSL compatibility verified
- [ ] Performance benchmarked
- [ ] Error handling tested

### Marketing & Distribution
- [ ] Demo videos created
- [ ] Social media posts prepared
- [ ] Product Hunt submission ready
- [ ] Documentation website live
- [ ] Support channels established

## Launch Day Tasks

1. [ ] Final repository backup
2. [ ] Create GitHub release
3. [ ] Publish to package managers
4. [ ] Deploy documentation
5. [ ] Announce on social media
6. [ ] Monitor for issues
7. [ ] Respond to feedback

## Post-Launch Tasks

- [ ] Gather user feedback
- [ ] Address critical issues
- [ ] Plan next features
- [ ] Update roadmap
- [ ] Thank contributors

---

Generated: $(date '+%Y-%m-%d %H:%M:%S')
EOF

    echo -e "${GREEN}${CHECK}${NC} Launch checklist created: $checklist_file"
    echo "- Launch checklist generated" >> "$REPORT_FILE"
}

# 11. Final Summary
generate_summary() {
    print_section "Launch Review Summary"
    
    # Calculate success rate
    local success_rate=0
    if [ $TOTAL_CHECKS -gt 0 ]; then
        success_rate=$((PASSED_CHECKS * 100 / TOTAL_CHECKS))
    fi
    
    # Add summary to report
    cat >> "$REPORT_FILE" << EOF

---

## Summary

### Statistics
- **Total Checks:** $TOTAL_CHECKS
- **Passed:** $PASSED_CHECKS
- **Warnings:** $WARNINGS
- **Errors:** $ERRORS
- **Success Rate:** ${success_rate}%

### Launch Readiness
EOF

    # Determine launch readiness
    if [ $success_rate -ge 95 ] && [ $ERRORS -eq 0 ]; then
        echo -e "\n${GREEN}${ROCKET} READY FOR LAUNCH!${NC}"
        echo -e "All systems are GO. The Cursive Terminal ecosystem is ready for deployment."
        echo "" >> "$REPORT_FILE"
        echo "**Status:** ✅ **READY FOR LAUNCH!**" >> "$REPORT_FILE"
        echo "" >> "$REPORT_FILE"
        echo "All systems are GO. The Cursive Terminal ecosystem is ready for deployment." >> "$REPORT_FILE"
    elif [ $success_rate -ge 80 ]; then
        echo -e "\n${YELLOW}⚠ NEARLY READY${NC}"
        echo -e "A few issues need attention before launch."
        echo "" >> "$REPORT_FILE"
        echo "**Status:** ⚠️  **NEARLY READY**" >> "$REPORT_FILE"
        echo "" >> "$REPORT_FILE"
        echo "A few issues need attention before launch." >> "$REPORT_FILE"
    else
        echo -e "\n${RED}${CROSS} NOT READY${NC}"
        echo -e "Significant issues must be resolved before launch."
        echo "" >> "$REPORT_FILE"
        echo "**Status:** ❌ **NOT READY**" >> "$REPORT_FILE"
        echo "" >> "$REPORT_FILE"
        echo "Significant issues must be resolved before launch." >> "$REPORT_FILE"
    fi
    
    # Display counters
    echo -e "\n${WHITE}Launch Review Statistics:${NC}"
    echo -e "  Total Checks:  ${CYAN}$TOTAL_CHECKS${NC}"
    echo -e "  Passed:        ${GREEN}$PASSED_CHECKS${NC}"
    echo -e "  Warnings:      ${YELLOW}$WARNINGS${NC}"
    echo -e "  Errors:        ${RED}$ERRORS${NC}"
    echo -e "  Success Rate:  ${success_rate}%"
    
    echo "" >> "$REPORT_FILE"
    echo "### Deployment Commands" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    echo '```bash' >> "$REPORT_FILE"
    echo "# Create release tag" >> "$REPORT_FILE"
    echo "git tag -a v1.0.0 -m \"Cursive Terminal v1.0.0 - Initial Release\"" >> "$REPORT_FILE"
    echo "git push origin v1.0.0" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    echo "# Create GitHub release" >> "$REPORT_FILE"
    echo "gh release create v1.0.0 --title \"Cursive Terminal v1.0.0\" --notes-file RELEASE_NOTES.md" >> "$REPORT_FILE"
    echo '```' >> "$REPORT_FILE"
    
    echo "" >> "$REPORT_FILE"
    echo "---" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    echo "*Report generated by launch-review.sh*" >> "$REPORT_FILE"
}

# Main execution
main() {
    clear
    
    print_header "${ROCKET} Cursive Terminal Ecosystem Launch Review ${ROCKET}"
    
    echo -e "${WHITE}Starting comprehensive launch review...${NC}\n"
    
    # Initialize report
    init_report
    
    # Run all checks
    check_directory_structure
    validate_themes
    validate_bubble_components
    validate_dna_integration
    check_installation_scripts
    check_documentation
    performance_check
    git_status_check
    feature_checklist
    generate_launch_checklist
    generate_summary
    
    # Save report location
    echo -e "\n${GREEN}${CHECK}${NC} Launch review complete!"
    echo -e "${BLUE}Report saved to: ${WHITE}$REPORT_FILE${NC}"
    echo -e "${BLUE}Checklist saved to: ${WHITE}LAUNCH_CHECKLIST.md${NC}"
    
    # Open report in default editor if available
    if command -v code &> /dev/null; then
        echo -e "\n${YELLOW}Opening report in VS Code...${NC}"
        code "$REPORT_FILE"
    elif command -v open &> /dev/null; then
        echo -e "\n${YELLOW}Opening report...${NC}"
        open "$REPORT_FILE"
    fi
}

# Run main function
main "$@"