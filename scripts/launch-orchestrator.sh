#!/bin/bash

#  _                           _       ___           _               _             _             
# | |    __ _ _   _ _ __   ___| |__   / _ \ _ __ ___| |__   ___  ___| |_ _ __ __ _| |_ ___  _ __ 
# | |   / _` | | | | '_ \ / __| '_ \ | | | | '__/ __| '_ \ / _ \/ __| __| '__/ _` | __/ _ \| '__|
# | |__| (_| | |_| | | | | (__| | | || |_| | | | (__| | | |  __/\__ \ |_| | | (_| | || (_) | |   
# |_____\__,_|\__,_|_| |_|\___|_| |_| \___/|_|  \___|_| |_|\___||___/\__|_|  \__,_|\__\___/|_|   
#
# Master Launch Orchestrator for Cursive Terminal
# This script coordinates all launch activities
# Version: 1.0.0

set -euo pipefail

# Colors and formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'
DIM='\033[2m'

# Directories
SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CURSIVE_DIR="/Users/studio/Cursive-Terminal"
REPORTS_DIR="launch-reports-$(date +%Y%m%d-%H%M%S)"

# Launch stages tracking
declare -A STAGES=(
    ["tests"]="pending"
    ["validation"]="pending"
    ["preparation"]="pending"
    ["deployment"]="pending"
)

# Create reports directory
mkdir -p "$REPORTS_DIR"

# ASCII Art Header
show_header() {
    clear
    cat << 'EOF'
   ____                _            _                           _     
  / ___|   _ _ __ ___ (_)_   ___   | |    __ _ _   _ _ __   ___| |__  
 | |  | | | | '__/ __| | \ \ / / _ \| |   / _` | | | | '_ \ / __| '_ \ 
 | |__| |_| | |  \__ \ | |\ V /  __/| |__| (_| | |_| | | | | (__| | | |
  \____\__,_|_|  |___/_|_| \_/ \___||_____\__,_|\__,_|_| |_|\___|_| |_|
                                                                       
                    LAUNCH CONTROL CENTER v1.0.0
                         🚀 Ready for Liftoff 🚀

EOF
    
    echo -e "${DIM}═══════════════════════════════════════════════════════════════${NC}\n"
}

# Progress bar function
show_progress() {
    local current=$1
    local total=$2
    local width=50
    local percentage=$((current * 100 / total))
    local filled=$((width * current / total))
    
    printf "\r${CYAN}Progress: ${NC}["
    printf "%${filled}s" | tr ' ' '█'
    printf "%$((width - filled))s" | tr ' ' '░'
    printf "] ${BOLD}%3d%%${NC}" $percentage
}

# Stage execution function
execute_stage() {
    local stage_name="$1"
    local stage_command="$2"
    local stage_description="$3"
    
    echo -e "\n${BOLD}${PURPLE}▶ Stage: $stage_description${NC}"
    echo -e "${DIM}────────────────────────────────────────${NC}"
    
    STAGES["$stage_name"]="running"
    
    # Run command in subshell for isolation (safer than eval)
    if bash -c "$stage_command"; then
        STAGES["$stage_name"]="completed"
        echo -e "\n${GREEN}✅ $stage_description - COMPLETED${NC}"
        return 0
    else
        STAGES["$stage_name"]="failed"
        echo -e "\n${RED}❌ $stage_description - FAILED${NC}"
        return 1
    fi
}

# Dashboard display
show_dashboard() {
    echo -e "\n${BOLD}${CYAN}═══ LAUNCH DASHBOARD ═══${NC}"
    echo -e "${CYAN}┌─────────────────────────┬──────────────┐${NC}"
    echo -e "${CYAN}│ Stage                   │ Status       │${NC}"
    echo -e "${CYAN}├─────────────────────────┼──────────────┤${NC}"
    
    for stage in tests validation preparation deployment; do
        local status="${STAGES[$stage]}"
        local status_icon=""
        local status_color=""
        
        case $status in
            "pending")
                status_icon="⏸"
                status_color="${YELLOW}"
                ;;
            "running")
                status_icon="▶"
                status_color="${BLUE}"
                ;;
            "completed")
                status_icon="✓"
                status_color="${GREEN}"
                ;;
            "failed")
                status_icon="✗"
                status_color="${RED}"
                ;;
        esac
        
        printf "${CYAN}│${NC} %-23s ${CYAN}│${NC} ${status_color}%-12s${NC} ${CYAN}│${NC}\n" \
            "${stage^}" "$status_icon $status"
    done
    
    echo -e "${CYAN}└─────────────────────────┴──────────────┘${NC}"
}

# Interactive menu
show_menu() {
    echo -e "\n${BOLD}${YELLOW}Select Launch Mode:${NC}"
    echo "1) Full Launch Sequence (Recommended)"
    echo "2) Quick Validation Only"
    echo "3) Tests Only"
    echo "4) Deployment Preparation Only"
    echo "5) Custom Sequence"
    echo "6) Exit"
    echo -ne "\n${CYAN}Enter choice [1-6]: ${NC}"
}

# Run tests stage
run_tests() {
    if [ -f "$SCRIPTS_DIR/run-all-tests.sh" ]; then
        cd "$SCRIPTS_DIR"
        ./run-all-tests.sh
        mv test-report-*.md "$REPORTS_DIR/" 2>/dev/null || true
        cd - >/dev/null
    else
        echo -e "${YELLOW}Test runner not found, skipping...${NC}"
        return 1
    fi
}

# Run validation stage
run_validation() {
    if [ -f "$SCRIPTS_DIR/launch-validator.sh" ]; then
        cd "$SCRIPTS_DIR"
        ./launch-validator.sh
        mv launch-report-*.md launch-checklist-*.md "$REPORTS_DIR/" 2>/dev/null || true
        cd - >/dev/null
    else
        echo -e "${YELLOW}Launch validator not found, skipping...${NC}"
        return 1
    fi
}

# Run preparation stage
run_preparation() {
    if [ -f "$SCRIPTS_DIR/prepare-deployment.sh" ]; then
        cd "$SCRIPTS_DIR"
        ./prepare-deployment.sh
        mv deployment-prep-*.log DEPLOYMENT_COMMANDS.sh PRE_FLIGHT_CHECKLIST.md "$REPORTS_DIR/" 2>/dev/null || true
        cd - >/dev/null
    else
        echo -e "${YELLOW}Deployment preparation script not found, skipping...${NC}"
        return 1
    fi
}

# Generate final launch report
generate_final_report() {
    local report_file="$REPORTS_DIR/FINAL_LAUNCH_REPORT.md"
    
    cat > "$report_file" << EOF
# Cursive Terminal Final Launch Report
**Generated:** $(date +"%Y-%m-%d %H:%M:%S")
**Launch Orchestrator Version:** 1.0.0

## Launch Sequence Summary

| Stage | Status | Duration |
|-------|---------|----------|
EOF
    
    for stage in tests validation preparation deployment; do
        local status="${STAGES[$stage]}"
        local icon="⏸"
        
        case $status in
            "completed") icon="✅" ;;
            "failed") icon="❌" ;;
            "running") icon="🔄" ;;
        esac
        
        echo "| ${stage^} | $icon $status | - |" >> "$report_file"
    done
    
    cat >> "$report_file" << EOF

## Launch Readiness

EOF
    
    # Check overall readiness
    local ready=true
    for stage in tests validation preparation; do
        if [ "${STAGES[$stage]}" != "completed" ]; then
            ready=false
            break
        fi
    done
    
    if $ready; then
        cat >> "$report_file" << EOF
### 🚀 SYSTEM IS GO FOR LAUNCH

All critical stages have passed. The Cursive Terminal ecosystem is ready for deployment.

#### Next Steps:
1. Review all reports in the \`$REPORTS_DIR\` directory
2. Execute deployment commands from DEPLOYMENT_COMMANDS.sh
3. Monitor initial user feedback
4. Be ready to push hotfixes if needed

#### Launch Commands:
\`\`\`bash
# Tag and release
git tag -a v1.0.0 -m "Initial release of Cursive Terminal"
git push origin v1.0.0

# Create GitHub release
gh release create v1.0.0 --title "Cursive Terminal 1.0.0" --notes-file RELEASE_NOTES.md

# Deploy to package managers
npm publish
brew tap yourusername/cursive-terminal
\`\`\`
EOF
    else
        cat >> "$report_file" << EOF
### ❌ LAUNCH ABORT RECOMMENDED

Critical issues detected. Please resolve all failures before proceeding with launch.

#### Failed Stages:
EOF
        for stage in tests validation preparation; do
            if [ "${STAGES[$stage]}" = "failed" ]; then
                echo "- ${stage^}" >> "$report_file"
            fi
        done
    fi
    
    echo -e "\n---\n*Generated by Cursive Terminal Launch Orchestrator*" >> "$report_file"
}

# Full launch sequence
full_launch_sequence() {
    show_header
    echo -e "${BOLD}${GREEN}Starting Full Launch Sequence...${NC}\n"
    
    local stages=("tests" "validation" "preparation")
    local current=0
    local total=${#stages[@]}
    
    for stage in "${stages[@]}"; do
        ((current++))
        show_progress $current $total
        
        case $stage in
            "tests")
                execute_stage "tests" "run_tests" "Running Comprehensive Tests"
                ;;
            "validation")
                execute_stage "validation" "run_validation" "Validating All Components"
                ;;
            "preparation")
                execute_stage "preparation" "run_preparation" "Preparing Deployment Package"
                ;;
        esac
        
        show_dashboard
        sleep 2
    done
    
    echo -e "\n"
    generate_final_report
    
    echo -e "\n${BOLD}${CYAN}═══ LAUNCH SEQUENCE COMPLETE ═══${NC}"
    echo -e "\n📁 ${CYAN}All reports saved to:${NC} ${BOLD}$REPORTS_DIR${NC}"
    
    # Open reports directory on macOS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        open "$REPORTS_DIR" 2>/dev/null || true
    fi
}

# Main menu loop
main() {
    show_header
    
    while true; do
        show_menu
        read -r choice
        
        case $choice in
            1)
                full_launch_sequence
                break
                ;;
            2)
                show_header
                execute_stage "validation" "run_validation" "Quick Validation"
                show_dashboard
                ;;
            3)
                show_header
                execute_stage "tests" "run_tests" "Tests Only"
                show_dashboard
                ;;
            4)
                show_header
                execute_stage "preparation" "run_preparation" "Deployment Preparation"
                show_dashboard
                ;;
            5)
                echo -e "\n${YELLOW}Custom sequence not implemented yet${NC}"
                ;;
            6)
                echo -e "\n${CYAN}Launch sequence aborted. Goodbye!${NC}"
                exit 0
                ;;
            *)
                echo -e "\n${RED}Invalid choice. Please try again.${NC}"
                ;;
        esac
        
        if [[ $choice =~ ^[2-5]$ ]]; then
            echo -ne "\n${CYAN}Press Enter to continue...${NC}"
            read -r
            show_header
        fi
    done
}

# Trap for clean exit
trap 'echo -e "\n${YELLOW}Launch sequence interrupted${NC}"; exit 1' INT TERM

# Start the orchestrator
main "$@"