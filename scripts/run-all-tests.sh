#!/bin/bash

#  _____         _     ____                              
# |_   _|__  ___| |_  |  _ \ _   _ _ __  _ __   ___ _ __ 
#   | |/ _ \/ __| __| | |_) | | | | '_ \| '_ \ / _ \ '__|
#   | |  __/\__ \ |_  |  _ <| |_| | | | | | | |  __/ |   
#   |_|\___||___/\__| |_| \_\\__,_|_| |_|_| |_|\___|_|   
#
# Comprehensive Test Runner for Cursive Terminal
# Version: 1.0.0

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

# Test results
declare -A TEST_RESULTS
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Directories
CURSIVE_DIR="/Users/studio/Cursive-Terminal"
SCRIPTS_DIR="$CURSIVE_DIR/scripts"

# Test report
TEST_REPORT="test-report-$(date +%Y%m%d-%H%M%S).md"

# Initialize test report
init_test_report() {
    cat > "$TEST_REPORT" << EOF
# Cursive Terminal Test Report
**Date:** $(date +"%Y-%m-%d %H:%M:%S")
**System:** $(uname -s) $(uname -r)

## Test Results

EOF
}

# Run test with result tracking
run_test() {
    local test_name="$1"
    local test_command="$2"
    local test_category="${3:-General}"
    
    ((TOTAL_TESTS++))
    
    echo -ne "${CYAN}Testing:${NC} $test_name... "
    
    if eval "$test_command" >/dev/null 2>&1; then
        echo -e "${GREEN}✓ PASSED${NC}"
        TEST_RESULTS["$test_name"]="PASSED"
        ((PASSED_TESTS++))
        echo "✓ **$test_name** - PASSED" >> "$TEST_REPORT"
        return 0
    else
        echo -e "${RED}✗ FAILED${NC}"
        TEST_RESULTS["$test_name"]="FAILED"
        ((FAILED_TESTS++))
        echo "✗ **$test_name** - FAILED" >> "$TEST_REPORT"
        return 1
    fi
}

# Test section header
test_section() {
    local section_name="$1"
    echo -e "\n${BOLD}${PURPLE}═══ $section_name ═══${NC}\n"
    echo -e "\n### $section_name\n" >> "$TEST_REPORT"
}

# 1. Theme Tests
test_themes() {
    test_section "THEME VALIDATION TESTS"
    
    # Test theme selector
    run_test "Theme selector script exists" "[ -f '$SCRIPTS_DIR/theme-selector.sh' ]"
    run_test "Theme selector is executable" "[ -x '$SCRIPTS_DIR/theme-selector.sh' ]"
    
    # Test all themes installation script
    run_test "Install all themes script" "[ -f '$SCRIPTS_DIR/install-all-themes.sh' ]"
    
    # Test individual theme files
    local theme_count=0
    for theme_file in "$CURSIVE_DIR/docs/themes"/*.html; do
        if [ -f "$theme_file" ]; then
            ((theme_count++))
        fi
    done
    
    run_test "Theme HTML files (expecting 33+)" "[ $theme_count -ge 33 ]"
    
    # Test theme showcase
    run_test "Theme showcase script" "[ -f '$SCRIPTS_DIR/showcase.sh' ]"
    run_test "Theme demo generator" "[ -f '$SCRIPTS_DIR/generate-theme-demos.sh' ]"
}

# 2. Bubble Component Tests
test_bubble_components() {
    test_section "BUBBLE COMPONENT TESTS"
    
    run_test "Bubble code ships component" "[ -f '$SCRIPTS_DIR/bubble-code-ships.jsx' ]"
    run_test "Bubble ship evolution component" "[ -f '$SCRIPTS_DIR/bubble-ship-evolution.jsx' ]"
    run_test "Bubble coder complete HTML" "[ -f '$SCRIPTS_DIR/bubble-coder-complete.html' ]"
    
    # Test component syntax (basic check)
    for component in bubble-code-ships.jsx bubble-ship-evolution.jsx; do
        if [ -f "$SCRIPTS_DIR/$component" ]; then
            run_test "$component syntax check" "grep -q 'React' '$SCRIPTS_DIR/$component'"
        fi
    done
}

# 3. DNA Integration Tests
test_dna_integration() {
    test_section "DNA INTEGRATION TESTS"
    
    run_test "DNA integration script" "[ -f '$SCRIPTS_DIR/dna-integration.sh' ]"
    run_test "DNA theme showcase HTML" "[ -f '$SCRIPTS_DIR/dna-theme-showcase.html' ]"
    run_test "Code DNA transcription component" "[ -f '$SCRIPTS_DIR/code-dna-transcription.jsx' ]"
    
    # Check DNA integration executable
    if [ -f "$SCRIPTS_DIR/dna-integration.sh" ]; then
        run_test "DNA script is executable" "[ -x '$SCRIPTS_DIR/dna-integration.sh' ]"
    fi
}

# 4. Ecosystem Dashboard Tests
test_ecosystem_dashboard() {
    test_section "ECOSYSTEM DASHBOARD TESTS"
    
    run_test "Ecosystem dashboard component" "[ -f '$SCRIPTS_DIR/cursive-ecosystem-dashboard.jsx' ]"
    run_test "Dashboard demo HTML" "[ -f '$SCRIPTS_DIR/ecosystem-dashboard-demo.html' ]"
    run_test "Cursive unit renderer" "[ -f '$SCRIPTS_DIR/cursive-unit-renderer.js' ]"
    run_test "Adaptive unit system" "[ -f '$SCRIPTS_DIR/adaptive-unit-system.js' ]"
    run_test "Immersive persona system" "[ -f '$SCRIPTS_DIR/immersive-persona-system.js' ]"
    run_test "XR terminal core" "[ -f '$SCRIPTS_DIR/xr-terminal-core.js' ]"
}

# 5. Installation Tests
test_installation() {
    test_section "INSTALLATION TESTS"
    
    run_test "Main install script" "[ -f '$CURSIVE_DIR/install.sh' ]"
    run_test "Quick setup script" "[ -f '$CURSIVE_DIR/quick_setup.sh' ]"
    run_test "Install script is executable" "[ -x '$CURSIVE_DIR/install.sh' ]"
    run_test "Quick setup is executable" "[ -x '$CURSIVE_DIR/quick_setup.sh' ]"
    
    # Test installation script syntax
    run_test "Install script syntax" "bash -n '$CURSIVE_DIR/install.sh'"
}

# 6. Documentation Tests
test_documentation() {
    test_section "DOCUMENTATION TESTS"
    
    run_test "README.md exists" "[ -f '$CURSIVE_DIR/README.md' ]"
    run_test "CHANGELOG.md exists" "[ -f '$CURSIVE_DIR/CHANGELOG.md' ]"
    run_test "CONTRIBUTING.md exists" "[ -f '$CURSIVE_DIR/CONTRIBUTING.md' ]"
    run_test "TROUBLESHOOTING.md exists" "[ -f '$CURSIVE_DIR/TROUBLESHOOTING.md' ]"
    run_test "LICENSE exists" "[ -f '$CURSIVE_DIR/LICENSE' ]"
    
    # Check documentation content
    run_test "README has installation instructions" "grep -q 'Installation' '$CURSIVE_DIR/README.md'"
    run_test "README has theme section" "grep -q 'Themes' '$CURSIVE_DIR/README.md'"
}

# 7. Enterprise Features Tests
test_enterprise() {
    test_section "ENTERPRISE FEATURES TESTS"
    
    run_test "Enterprise directory exists" "[ -d '$CURSIVE_DIR/enterprise' ]"
    run_test "Enterprise README" "[ -f '$CURSIVE_DIR/enterprise/README.md' ]"
    run_test "Deployment automation script" "[ -f '$CURSIVE_DIR/enterprise/deployment_automation.py' ]"
    run_test "License manager" "[ -f '$CURSIVE_DIR/enterprise/license_manager.py' ]"
    run_test "Team config" "[ -f '$CURSIVE_DIR/enterprise/team_config.py' ]"
    run_test "Requirements file" "[ -f '$CURSIVE_DIR/enterprise/requirements.txt' ]"
}

# 8. Website Tests
test_website() {
    test_section "WEBSITE TESTS"
    
    run_test "Website directory exists" "[ -d '$CURSIVE_DIR/website' ]"
    run_test "Website index.html" "[ -f '$CURSIVE_DIR/website/index.html' ]"
    run_test "Website CSS" "[ -f '$CURSIVE_DIR/website/src/styles.css' ]"
    run_test "Website JavaScript" "[ -f '$CURSIVE_DIR/website/src/script.js' ]"
    
    # Test website content
    run_test "Website has proper structure" "grep -q '<html' '$CURSIVE_DIR/website/index.html'"
}

# 9. Font Tests
test_fonts() {
    test_section "FONT TESTS"
    
    run_test "Font demo script" "[ -f '$SCRIPTS_DIR/cursive_font_demo.sh' ]"
    run_test "Font comparison script" "[ -f '$SCRIPTS_DIR/font_comparison.sh' ]"
    run_test "Font preview generator" "[ -f '$SCRIPTS_DIR/font_preview_generator.py' ]"
    run_test "Oblique font creator" "[ -f '$SCRIPTS_DIR/create_oblique_font.py' ]"
}

# 10. Utility Scripts Tests
test_utilities() {
    test_section "UTILITY SCRIPTS TESTS"
    
    run_test "License generator" "[ -f '$SCRIPTS_DIR/license_generator.sh' ]"
    run_test "Colored text demo" "[ -f '$SCRIPTS_DIR/colored_text_demo.sh' ]"
    run_test "Launch validator" "[ -f '$SCRIPTS_DIR/launch-validator.sh' ]"
    run_test "Deployment preparation" "[ -f '$SCRIPTS_DIR/prepare-deployment.sh' ]"
}

# Generate test summary
generate_summary() {
    local success_rate=$((PASSED_TESTS * 100 / TOTAL_TESTS))
    
    echo -e "\n${BOLD}${PURPLE}═══════════════════════════════════════${NC}"
    echo -e "${BOLD}TEST SUMMARY${NC}"
    echo -e "${BOLD}${PURPLE}═══════════════════════════════════════${NC}\n"
    
    echo -e "📊 ${CYAN}Total Tests:${NC} $TOTAL_TESTS"
    echo -e "✅ ${GREEN}Passed:${NC} $PASSED_TESTS"
    echo -e "❌ ${RED}Failed:${NC} $FAILED_TESTS"
    echo -e "📈 ${CYAN}Success Rate:${NC} ${success_rate}%"
    
    # Add to report
    cat >> "$TEST_REPORT" << EOF

## Summary

- **Total Tests:** $TOTAL_TESTS
- **Passed:** $PASSED_TESTS  
- **Failed:** $FAILED_TESTS
- **Success Rate:** ${success_rate}%

### Test Status
EOF
    
    if [ $FAILED_TESTS -eq 0 ]; then
        echo -e "\n${GREEN}${BOLD}✅ ALL TESTS PASSED!${NC}"
        echo "✅ **ALL TESTS PASSED** - System ready for deployment" >> "$TEST_REPORT"
    else
        echo -e "\n${RED}${BOLD}❌ SOME TESTS FAILED${NC}"
        echo "❌ **TESTS FAILED** - Review and fix issues before deployment" >> "$TEST_REPORT"
        
        # List failed tests
        echo -e "\n${YELLOW}Failed Tests:${NC}" >> "$TEST_REPORT"
        for test_name in "${!TEST_RESULTS[@]}"; do
            if [ "${TEST_RESULTS[$test_name]}" = "FAILED" ]; then
                echo "  - $test_name" >> "$TEST_REPORT"
            fi
        done
    fi
    
    echo -e "\n---\n*Test report generated by Cursive Terminal Test Runner v1.0.0*" >> "$TEST_REPORT"
}

# Main execution
main() {
    clear
    
    cat << 'EOF'
   _____         _     ____                              
  |_   _|__  ___| |_  |  _ \ _   _ _ __  _ __   ___ _ __ 
    | |/ _ \/ __| __| | |_) | | | | '_ \| '_ \ / _ \ '__|
    | |  __/\__ \ |_  |  _ <| |_| | | | | | | |  __/ |   
    |_|\___||___/\__| |_| \_\\__,_|_| |_|_| |_|\___|_|   
                                                          
              Cursive Terminal Test Suite v1.0.0

EOF
    
    echo -e "${CYAN}Starting comprehensive test suite...${NC}\n"
    
    # Initialize report
    init_test_report
    
    # Run all test suites
    test_themes
    test_bubble_components
    test_dna_integration
    test_ecosystem_dashboard
    test_installation
    test_documentation
    test_enterprise
    test_website
    test_fonts
    test_utilities
    
    # Generate summary
    generate_summary
    
    # Save test report
    echo -e "\n📄 ${CYAN}Test report saved to:${NC} ${BOLD}$TEST_REPORT${NC}"
    
    # Open report if on macOS
    if [[ "$OSTYPE" == "darwin"* ]] && [ $FAILED_TESTS -gt 0 ]; then
        echo -e "\n${CYAN}Opening test report...${NC}"
        open "$TEST_REPORT" 2>/dev/null || true
    fi
}

# Run main function
main "$@"