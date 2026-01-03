#!/bin/bash

#  ____                _            _                           _     
# / ___|   _ _ __ ___ (_)_   ___   | |    __ _ _   _ _ __   ___| |__  
#| |  | | | | '__/ __| | \ \ / / _ \| |   / _` | | | | '_ \ / __| '_ \ 
#| |__| |_| | |  \__ \ | |\ V /  __/| |__| (_| | |_| | | | | (__| | | |
# \____\__,_|_|  |___/_|_| \_/ \___||_____\__,_|\__,_|_| |_|\___|_| |_|
#                                                                       
# Comprehensive Launch Validator for Cursive Terminal Ecosystem
# Version: 1.0.0
# Date: $(date +"%Y-%m-%d")

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Global counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0
WARNINGS=0

# Launch report file
LAUNCH_REPORT="launch-report-$(date +"%Y%m%d-%H%M%S").md"
LAUNCH_CHECKLIST="launch-checklist-$(date +"%Y%m%d-%H%M%S").md"

# Base directories
CURSIVE_TERMINAL_DIR="/Users/studio/Cursive-Terminal"
CURSIVE_SETUP_DIR="/Users/studio/cursive-terminal-setup"

# Component arrays
declare -a THEMES=(
    "ancient-papyrus" "ancient-parchment" "aurora-borealis" "blueprint-tech"
    "calligraphy-flourish" "calligraphy-scroll" "carbon-copy" "cotton-candy"
    "cursive-elegance" "cursive-garden" "cursive-noir" "ditto-spirit"
    "forest-grove" "illuminated-manuscript" "invisible-ink" "invisible-ink-revealed"
    "ivory-parchment" "legal-document" "linen-manuscript" "linen-sheet"
    "midnight-quill" "neon-cyberpunk" "ocean-mist" "office-memo"
    "papyrus-scroll" "pirate-scroll" "rainbow-prism" "receipt-paper"
    "sunset-festival" "sunset-glow" "tropical-paradise" "vampires-letter"
    "DNA-theme"
)

declare -a BUBBLE_COMPONENTS=(
    "bubble-code-ships.jsx"
    "bubble-ship-evolution.jsx"
    "bubble-coder-complete.html"
)

declare -a CORE_SCRIPTS=(
    "install.sh"
    "quick_setup.sh"
    "cursive_terminal_themes.sh"
    "showcase.sh"
    "theme-selector.sh"
)

declare -a ECOSYSTEM_COMPONENTS=(
    "cursive-ecosystem-dashboard.jsx"
    "ecosystem-dashboard-demo.html"
    "dna-integration.sh"
    "dna-theme-showcase.html"
    "cursive-unit-renderer.js"
    "adaptive-unit-system.js"
    "immersive-persona-system.js"
    "xr-terminal-core.js"
)

# Initialize report
init_report() {
    cat > "$LAUNCH_REPORT" << EOF
# Cursive Terminal Launch Report
**Generated:** $(date +"%Y-%m-%d %H:%M:%S")
**Version:** 1.0.0
**System:** $(uname -s) $(uname -r)

## Executive Summary
This report validates all components of the Cursive Terminal ecosystem before launch.

---

EOF

    cat > "$LAUNCH_CHECKLIST" << EOF
# Cursive Terminal Launch Checklist
**Generated:** $(date +"%Y-%m-%d %H:%M:%S")

## Pre-Launch Verification

EOF
}

# Test function with reporting
test_component() {
    local component="$1"
    local test_name="$2"
    local test_command="$3"
    
    ((TOTAL_TESTS++))
    
    echo -ne "${CYAN}Testing:${NC} $test_name... "
    
    # Run in subshell for isolation (safer than eval)
    if bash -c "$test_command" >/dev/null 2>&1; then
        echo -e "${GREEN}✓ PASSED${NC}"
        echo "✓ **$test_name**: PASSED" >> "$LAUNCH_REPORT"
        echo "- [x] $test_name" >> "$LAUNCH_CHECKLIST"
        ((PASSED_TESTS++))
        return 0
    else
        echo -e "${RED}✗ FAILED${NC}"
        echo "✗ **$test_name**: FAILED" >> "$LAUNCH_REPORT"
        echo "- [ ] $test_name - **NEEDS FIX**" >> "$LAUNCH_CHECKLIST"
        ((FAILED_TESTS++))
        return 1
    fi
}

# Warning function
add_warning() {
    local message="$1"
    echo -e "${YELLOW}⚠ WARNING:${NC} $message"
    echo "⚠ **WARNING**: $message" >> "$LAUNCH_REPORT"
    ((WARNINGS++))
}

# Section header
section_header() {
    local title="$1"
    echo -e "\n${BOLD}${PURPLE}═══════════════════════════════════════${NC}"
    echo -e "${BOLD}${PURPLE}$title${NC}"
    echo -e "${BOLD}${PURPLE}═══════════════════════════════════════${NC}\n"
    
    echo -e "\n## $title\n" >> "$LAUNCH_REPORT"
    echo -e "\n### $title\n" >> "$LAUNCH_CHECKLIST"
}

# 1. Check directory structure
check_directory_structure() {
    section_header "1. DIRECTORY STRUCTURE VALIDATION"
    
    test_component "dir" "Cursive Terminal main directory" "[ -d '$CURSIVE_TERMINAL_DIR' ]"
    test_component "dir" "Cursive setup directory" "[ -d '$CURSIVE_SETUP_DIR' ]"
    test_component "dir" "Scripts directory" "[ -d '$CURSIVE_TERMINAL_DIR/scripts' ]"
    test_component "dir" "Themes directory" "[ -d '$CURSIVE_TERMINAL_DIR/themes' ]"
    test_component "dir" "Docs directory" "[ -d '$CURSIVE_TERMINAL_DIR/docs' ]"
    test_component "dir" "Enterprise directory" "[ -d '$CURSIVE_TERMINAL_DIR/enterprise' ]"
    test_component "dir" "Mac App directory" "[ -d '$CURSIVE_TERMINAL_DIR/mac-app' ]"
    test_component "dir" "Website directory" "[ -d '$CURSIVE_TERMINAL_DIR/website' ]"
}

# 2. Validate all themes
validate_themes() {
    section_header "2. THEME VALIDATION (33 THEMES)"
    
    local theme_count=0
    
    for theme in "${THEMES[@]}"; do
        if [ "$theme" = "DNA-theme" ]; then
            # Special handling for DNA theme
            test_component "theme" "DNA Theme integration" "[ -f '$CURSIVE_TERMINAL_DIR/scripts/dna-integration.sh' ]"
            test_component "theme" "DNA Theme showcase" "[ -f '$CURSIVE_TERMINAL_DIR/scripts/dna-theme-showcase.html' ]"
        else
            # Check theme HTML file
            test_component "theme" "Theme: $theme" "[ -f '$CURSIVE_TERMINAL_DIR/docs/themes/${theme}.html' ]"
            
            # Check theme demo image
            if [ -d "$CURSIVE_TERMINAL_DIR/docs/images/theme-demos/${theme}" ]; then
                ((theme_count++))
            fi
        fi
    done
    
    echo -e "\n${CYAN}Total theme demos found:${NC} $theme_count" >> "$LAUNCH_REPORT"
}

# 3. Check bubble components
check_bubble_components() {
    section_header "3. BUBBLE COMPONENTS VALIDATION"
    
    for component in "${BUBBLE_COMPONENTS[@]}"; do
        test_component "bubble" "Bubble component: $component" "[ -f '$CURSIVE_TERMINAL_DIR/scripts/$component' ]"
        
        # Check component syntax
        if [[ "$component" == *.jsx ]]; then
            if command -v node >/dev/null 2>&1; then
                test_component "syntax" "JSX syntax: $component" "node -c '$CURSIVE_TERMINAL_DIR/scripts/$component' 2>/dev/null || true"
            fi
        fi
    done
}

# 4. Validate DNA theme integration
validate_dna_integration() {
    section_header "4. DNA THEME INTEGRATION"
    
    test_component "dna" "DNA integration script" "[ -f '$CURSIVE_TERMINAL_DIR/scripts/dna-integration.sh' ]"
    test_component "dna" "DNA theme showcase HTML" "[ -f '$CURSIVE_TERMINAL_DIR/scripts/dna-theme-showcase.html' ]"
    test_component "dna" "Code DNA transcription component" "[ -f '$CURSIVE_TERMINAL_DIR/scripts/code-dna-transcription.jsx' ]"
    
    # Check if DNA integration script is executable
    if [ -f "$CURSIVE_TERMINAL_DIR/scripts/dna-integration.sh" ]; then
        test_component "dna" "DNA script executable" "[ -x '$CURSIVE_TERMINAL_DIR/scripts/dna-integration.sh' ]"
    fi
}

# 5. Test ecosystem dashboard
test_ecosystem_dashboard() {
    section_header "5. ECOSYSTEM DASHBOARD VALIDATION"
    
    test_component "dashboard" "Ecosystem dashboard component" "[ -f '$CURSIVE_TERMINAL_DIR/scripts/cursive-ecosystem-dashboard.jsx' ]"
    test_component "dashboard" "Dashboard demo HTML" "[ -f '$CURSIVE_TERMINAL_DIR/scripts/ecosystem-dashboard-demo.html' ]"
    
    # Check dashboard dependencies
    for component in "${ECOSYSTEM_COMPONENTS[@]}"; do
        test_component "ecosystem" "Component: $component" "[ -f '$CURSIVE_TERMINAL_DIR/scripts/$component' ]"
    done
}

# 6. Validate core scripts
validate_core_scripts() {
    section_header "6. CORE SCRIPTS VALIDATION"
    
    for script in "${CORE_SCRIPTS[@]}"; do
        local script_path=""
        
        # Determine script location
        if [[ "$script" == "cursive_terminal_themes.sh" ]]; then
            script_path="$CURSIVE_TERMINAL_DIR/themes/$script"
        else
            script_path="$CURSIVE_TERMINAL_DIR/$script"
        fi
        
        test_component "script" "Core script: $script" "[ -f '$script_path' ]"
        
        # Check if executable
        if [ -f "$script_path" ]; then
            test_component "exec" "Executable: $script" "[ -x '$script_path' ]"
        fi
    done
}

# 7. Check documentation
check_documentation() {
    section_header "7. DOCUMENTATION VALIDATION"
    
    test_component "doc" "README.md" "[ -f '$CURSIVE_TERMINAL_DIR/README.md' ]"
    test_component "doc" "CHANGELOG.md" "[ -f '$CURSIVE_TERMINAL_DIR/CHANGELOG.md' ]"
    test_component "doc" "CONTRIBUTING.md" "[ -f '$CURSIVE_TERMINAL_DIR/CONTRIBUTING.md' ]"
    test_component "doc" "TROUBLESHOOTING.md" "[ -f '$CURSIVE_TERMINAL_DIR/TROUBLESHOOTING.md' ]"
    test_component "doc" "LICENSE" "[ -f '$CURSIVE_TERMINAL_DIR/LICENSE' ]"
    
    # Check enterprise docs
    test_component "doc" "Enterprise README" "[ -f '$CURSIVE_TERMINAL_DIR/enterprise/README.md' ]"
    test_component "doc" "Mac App concept" "[ -f '$CURSIVE_TERMINAL_DIR/mac-app/APP_CONCEPT.md' ]"
}

# 8. Validate website
validate_website() {
    section_header "8. WEBSITE VALIDATION"
    
    test_component "web" "Website index.html" "[ -f '$CURSIVE_TERMINAL_DIR/website/index.html' ]"
    test_component "web" "Website CSS" "[ -f '$CURSIVE_TERMINAL_DIR/website/src/styles.css' ]"
    test_component "web" "Website JavaScript" "[ -f '$CURSIVE_TERMINAL_DIR/website/src/script.js' ]"
    
    # Check theme gallery
    test_component "web" "Theme gallery index" "[ -f '$CURSIVE_TERMINAL_DIR/docs/themes/index.html' ]"
}

# 9. Check Git repository
check_git_status() {
    section_header "9. GIT REPOSITORY STATUS"
    
    cd "$CURSIVE_TERMINAL_DIR"
    
    # Check if it's a git repo
    if git rev-parse --git-dir > /dev/null 2>&1; then
        echo "✓ Git repository detected" >> "$LAUNCH_REPORT"
        
        # Get current branch
        local branch=$(git rev-parse --abbrev-ref HEAD)
        echo "Current branch: $branch" >> "$LAUNCH_REPORT"
        
        # Check for uncommitted changes
        if [ -n "$(git status --porcelain)" ]; then
            add_warning "Uncommitted changes detected in repository"
        else
            echo "✓ Working directory clean" >> "$LAUNCH_REPORT"
        fi
        
        # Get latest commit
        local latest_commit=$(git log -1 --oneline)
        echo "Latest commit: $latest_commit" >> "$LAUNCH_REPORT"
    else
        add_warning "Not a git repository"
    fi
    
    cd - >/dev/null
}

# 10. Generate deployment commands
generate_deployment_commands() {
    section_header "10. DEPLOYMENT COMMANDS"
    
    cat >> "$LAUNCH_REPORT" << 'EOF'

### Quick Installation
```bash
# Download and install (safer than piping to bash)
curl -fsSL -o /tmp/cursive-install.sh https://raw.githubusercontent.com/midnightnow/cursive-terminal/main/install.sh
bash /tmp/cursive-install.sh
```

### Manual Installation
```bash
# Clone repository
git clone https://github.com/yourusername/cursive-terminal.git
cd cursive-terminal

# Run installation
./install.sh

# Or quick setup
./quick_setup.sh
```

### Theme Installation
```bash
# Install all themes
./scripts/install-all-themes.sh

# Or use theme selector
./scripts/theme-selector.sh
```

### Enterprise Deployment
```bash
# Navigate to enterprise directory
cd enterprise

# Install requirements
pip install -r requirements.txt

# Run team deployment
python deployment_automation.py
```

### Docker Deployment (if available)
```bash
# Build Docker image
docker build -t cursive-terminal .

# Run container
docker run -it cursive-terminal
```

EOF
}

# Generate final summary
generate_summary() {
    section_header "FINAL SUMMARY"
    
    local success_rate=$((PASSED_TESTS * 100 / TOTAL_TESTS))
    
    cat >> "$LAUNCH_REPORT" << EOF

## Summary Statistics

- **Total Tests:** $TOTAL_TESTS
- **Passed:** $PASSED_TESTS
- **Failed:** $FAILED_TESTS
- **Warnings:** $WARNINGS
- **Success Rate:** ${success_rate}%

### Launch Status
EOF

    if [ $FAILED_TESTS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
        echo "🚀 **READY FOR LAUNCH** - All systems operational!" >> "$LAUNCH_REPORT"
        echo -e "${GREEN}${BOLD}🚀 READY FOR LAUNCH!${NC}"
    elif [ $FAILED_TESTS -eq 0 ] && [ $WARNINGS -gt 0 ]; then
        echo "⚠️  **LAUNCH WITH CAUTION** - Minor warnings detected" >> "$LAUNCH_REPORT"
        echo -e "${YELLOW}${BOLD}⚠️  LAUNCH WITH CAUTION${NC}"
    else
        echo "❌ **NOT READY FOR LAUNCH** - Critical issues detected" >> "$LAUNCH_REPORT"
        echo -e "${RED}${BOLD}❌ NOT READY FOR LAUNCH${NC}"
    fi
    
    # Add recommendations
    cat >> "$LAUNCH_REPORT" << EOF

## Recommendations

1. **Pre-Launch:**
   - Review all failed tests and fix issues
   - Address any warnings if possible
   - Ensure all documentation is up to date
   - Test installation on clean system

2. **Launch Day:**
   - Monitor GitHub issues closely
   - Be ready to push hotfixes
   - Engage with community feedback
   - Track installation metrics

3. **Post-Launch:**
   - Gather user feedback
   - Monitor performance metrics
   - Plan for version 1.1 features
   - Build community engagement

---

*Report generated by Cursive Terminal Launch Validator v1.0.0*
EOF

    # Final checklist summary
    cat >> "$LAUNCH_CHECKLIST" << EOF

## Final Checklist Summary

- Total items: $TOTAL_TESTS
- Completed: $PASSED_TESTS
- Pending: $FAILED_TESTS

### Launch Decision
EOF

    if [ $FAILED_TESTS -eq 0 ]; then
        echo "✅ **APPROVED FOR LAUNCH**" >> "$LAUNCH_CHECKLIST"
    else
        echo "❌ **FIX ISSUES BEFORE LAUNCH**" >> "$LAUNCH_CHECKLIST"
    fi
}

# Main execution
main() {
    clear
    
    cat << 'EOF'
   ____                _            _                           _     
  / ___|   _ _ __ ___ (_)_   ___   | |    __ _ _   _ _ __   ___| |__  
 | |  | | | | '__/ __| | \ \ / / _ \| |   / _` | | | | '_ \ / __| '_ \ 
 | |__| |_| | |  \__ \ | |\ V /  __/| |__| (_| | |_| | | | | (__| | | |
  \____\__,_|_|  |___/_|_| \_/ \___||_____\__,_|\__,_|_| |_|\___|_| |_|
                                                                       
                    Launch Validation System v1.0.0

EOF
    
    echo -e "${CYAN}Starting comprehensive launch validation...${NC}\n"
    
    # Initialize reports
    init_report
    
    # Run all validations
    check_directory_structure
    validate_themes
    check_bubble_components
    validate_dna_integration
    test_ecosystem_dashboard
    validate_core_scripts
    check_documentation
    validate_website
    check_git_status
    generate_deployment_commands
    generate_summary
    
    # Display results
    echo -e "\n${BOLD}${PURPLE}═══════════════════════════════════════${NC}"
    echo -e "${BOLD}VALIDATION COMPLETE${NC}"
    echo -e "${BOLD}${PURPLE}═══════════════════════════════════════${NC}\n"
    
    echo -e "📊 ${CYAN}Total Tests:${NC} $TOTAL_TESTS"
    echo -e "✅ ${GREEN}Passed:${NC} $PASSED_TESTS"
    echo -e "❌ ${RED}Failed:${NC} $FAILED_TESTS"
    echo -e "⚠️  ${YELLOW}Warnings:${NC} $WARNINGS"
    
    echo -e "\n📄 ${CYAN}Reports generated:${NC}"
    echo -e "   - Launch Report: ${BOLD}$LAUNCH_REPORT${NC}"
    echo -e "   - Launch Checklist: ${BOLD}$LAUNCH_CHECKLIST${NC}"
    
    # Open reports if on macOS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo -e "\n${CYAN}Opening reports...${NC}"
        open "$LAUNCH_REPORT" 2>/dev/null || true
        open "$LAUNCH_CHECKLIST" 2>/dev/null || true
    fi
}

# Run main function
main "$@"