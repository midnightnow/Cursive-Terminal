#!/bin/bash
# 🧬 DNA Helix Theme Integration Script
# Connects DNA theme with Cursive Terminal ecosystem

# Integration functions for DNA theme
integrate_dna_with_cursive() {
    echo "🧬 Integrating DNA Helix with Cursive Terminal..."
    
    # 1. Add to theme selector
    if [ ! -f ~/.config/terminal-themes/theme-list.txt ]; then
        mkdir -p ~/.config/terminal-themes
        touch ~/.config/terminal-themes/theme-list.txt
    fi
    
    # Add DNA theme to list if not already present
    if ! grep -q "dna-helix" ~/.config/terminal-themes/theme-list.txt; then
        echo "dna-helix:🧬 DNA Helix - Genetic programming laboratory" >> ~/.config/terminal-themes/theme-list.txt
    fi
    
    # 2. Create DNA persona integration
    cat > ~/.config/terminal-themes/dna-persona.sh << 'EOF'
#!/bin/bash
# DNA Scientist Persona Integration

export DNA_PERSONA_ACTIVE=true
export PERSONA_INTENSITY=75

# Scientific vocabulary mappings
declare -A SCIENTIFIC_VOCAB=(
    ["hello"]="Greetings, fellow researcher"
    ["error"]="Genetic mutation detected"
    ["success"]="Protein synthesis complete"
    ["loading"]="Transcription in progress"
    ["done"]="Evolution successful"
    ["failed"]="Mutation incompatible"
    ["starting"]="Initiating DNA sequence"
    ["finished"]="Replication complete"
)

# DNA fleet commands
dna_spawn_fleet() {
    local count=${1:-5}
    echo "🧬 Spawning genetic research fleet ($count vessels)..."
    for i in $(seq 1 $count); do
        bases=("A" "T" "G" "C")
        base=${bases[$RANDOM % 4]}
        printf "⛵ Research Vessel $i carrying %s-base cargo\n" "$base"
    done
}

# DNA replication ships
summon_dna_carriers() {
    local bases=${1:-"ATGC"}
    local count=${2:-10}
    
    echo "🧬 Summoning DNA carrier ships..."
    for ((i=0; i<${#bases}; i++)); do
        base=${bases:$i:1}
        case $base in
            "A") color="\e[38;2;255;107;107m" ;;
            "T") color="\e[38;2;78;236;196m" ;;
            "G") color="\e[38;2;69;183;209m" ;;
            "C") color="\e[38;2;150;206;180m" ;;
        esac
        printf "${color}⛵ DNA Carrier: %s-base transport\e[0m\n" "$base"
    done
}

# Scientific command translations
scientific_translate() {
    local input="$1"
    if [[ -n "${SCIENTIFIC_VOCAB[$input]}" ]]; then
        echo "${SCIENTIFIC_VOCAB[$input]}"
    else
        echo "$input"
    fi
}

# Export functions
export -f dna_spawn_fleet
export -f summon_dna_carriers
export -f scientific_translate

# Aliases for DNA fleet operations
alias spawn-dna-fleet="dna_spawn_fleet"
alias summon-carriers="summon_dna_carriers"
alias translate="scientific_translate"
EOF

    # 3. Create DNA bubble ships integration
    cat > ~/.config/terminal-themes/dna-bubble-ships.sh << 'EOF'
#!/bin/bash
# DNA Bubble Ships Integration

# DNA cargo types for bubble ships
declare -A DNA_CARGO=(
    ["A"]="function_declarations"
    ["T"]="class_definitions" 
    ["G"]="constant_variables"
    ["C"]="import_statements"
    ["RNA"]="transcription_data"
    ["protein"]="synthesized_output"
)

# Generate DNA-specific bubble ships
generate_dna_bubble() {
    local base=${1:-"A"}
    local cargo=${DNA_CARGO[$base]}
    
    cat << EOF
{
  "id": "dna-${base}-$(date +%s)",
  "type": "genetic_vessel",
  "cargo": "$cargo",
  "base": "$base",
  "color": "$(get_base_color $base)",
  "mission": "transport_genetic_data",
  "replication_factor": 2
}
EOF
}

# Get color for DNA base
get_base_color() {
    case $1 in
        "A") echo "#FF6B6B" ;;
        "T") echo "#4ECDC4" ;;
        "G") echo "#45B7D1" ;;
        "C") echo "#96CEB4" ;;
        "RNA") echo "#00FF9F" ;;
        *) echo "#E8F4FD" ;;
    esac
}

# DNA replication for ships
replicate_dna_ship() {
    local original_ship="$1"
    echo "🧬 Replicating DNA ship: $original_ship"
    
    # Create complementary ship
    local base=$(echo "$original_ship" | grep -o '"base":"[ATGC]"' | cut -d'"' -f4)
    local complement=""
    
    case $base in
        "A") complement="T" ;;
        "T") complement="A" ;;
        "G") complement="C" ;;
        "C") complement="G" ;;
    esac
    
    generate_dna_bubble "$complement"
}

export -f generate_dna_bubble
export -f get_base_color
export -f replicate_dna_ship
EOF

    # 4. Create XR DNA integration
    cat > ~/.config/terminal-themes/dna-xr-integration.sh << 'EOF'
#!/bin/bash
# DNA XR (VR/AR) Integration

export DNA_XR_MODE=false

# Enable XR DNA visualization
enable_dna_xr() {
    export DNA_XR_MODE=true
    echo "🧬 DNA XR Mode: ENABLED"
    echo "   • 3D double helix visualization"
    echo "   • Interactive base pair manipulation"
    echo "   • Spatial genetic algorithms"
    echo "   • Hand tracking for DNA editing"
}

# DNA XR commands
dna_xr_helix() {
    if [ "$DNA_XR_MODE" = "true" ]; then
        echo "🧬 Rendering 3D DNA helix in XR space..."
        echo "   Helix parameters: 10.5 base pairs per turn"
        echo "   Major groove: 22 Å, Minor groove: 12 Å"
        echo "   Rise per base pair: 3.4 Å"
    else
        echo "❌ XR mode not enabled. Run 'enable_dna_xr' first."
    fi
}

dna_xr_manipulate() {
    local action=${1:-"view"}
    if [ "$DNA_XR_MODE" = "true" ]; then
        case $action in
            "grab") echo "👋 Hand tracking: Grab base pair with gesture" ;;
            "edit") echo "✏️ Spatial editing: Modify genetic sequence" ;;
            "replicate") echo "🔄 3D replication: Watch DNA unzip and copy" ;;
            "transcribe") echo "📝 3D transcription: RNA polymerase animation" ;;
            *) echo "🔍 3D DNA visualization active" ;;
        esac
    else
        echo "❌ XR mode required for manipulation"
    fi
}

export -f enable_dna_xr
export -f dna_xr_helix
export -f dna_xr_manipulate

# XR aliases
alias xr-dna="enable_dna_xr"
alias dna-3d="dna_xr_helix"
alias dna-grab="dna_xr_manipulate grab"
alias dna-edit="dna_xr_manipulate edit"
EOF

    # 5. Create theme export utilities
    cat > ~/.config/terminal-themes/dna-export.sh << 'EOF'
#!/bin/bash
# DNA Theme Export Utilities

# Export DNA config
dna_export_config() {
    cat << EOF
# DNA Helix Terminal Configuration
export DNA_THEME_ACTIVE=true
export DNA_BASES="ATGC"
export DNA_REPLICATION_SPEED=50
export DNA_TRANSCRIPTION_MODE=true

# Base colors
export DNA_ADENINE="#FF6B6B"
export DNA_THYMINE="#4ECDC4"  
export DNA_GUANINE="#45B7D1"
export DNA_CYTOSINE="#96CEB4"
export DNA_RNA="#00FF9F"
export DNA_MUTATION="#FFD93D"
export DNA_PROTEIN="#E8F4FD"
EOF
}

# Export iTerm2 profile
dna_export_iterm2() {
    cat << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Name</key>
    <string>DNA Helix</string>
    <key>Ansi 0 Color</key>
    <dict>
        <key>Red Component</key><real>0.047</real>
        <key>Green Component</key><real>0.086</real>
        <key>Blue Component</key><real>0.094</real>
    </dict>
    <key>Ansi 1 Color</key>
    <dict>
        <key>Red Component</key><real>1.0</real>
        <key>Green Component</key><real>0.42</real>
        <key>Blue Component</key><real>0.42</real>
    </dict>
    <key>Ansi 2 Color</key>
    <dict>
        <key>Red Component</key><real>0.588</real>
        <key>Green Component</key><real>0.808</real>
        <key>Blue Component</key><real>0.706</real>
    </dict>
    <key>Background Color</key>
    <dict>
        <key>Red Component</key><real>0.047</real>
        <key>Green Component</key><real>0.086</real>
        <key>Blue Component</key><real>0.094</real>
    </dict>
    <key>Foreground Color</key>
    <dict>
        <key>Red Component</key><real>0.909</real>
        <key>Green Component</key><real>0.956</real>
        <key>Blue Component</key><real>0.992</real>
    </dict>
</dict>
</plist>
EOF
}

# Export VS Code theme
dna_export_vscode() {
    cat << 'EOF'
{
  "name": "DNA Helix",
  "type": "dark",
  "colors": {
    "editor.background": "#0C1618",
    "editor.foreground": "#E8F4FD",
    "terminal.background": "#0C1618",
    "terminal.foreground": "#E8F4FD",
    "terminal.ansiRed": "#FF6B6B",
    "terminal.ansiGreen": "#96CEB4",
    "terminal.ansiYellow": "#FFD93D",
    "terminal.ansiBlue": "#45B7D1",
    "terminal.ansiMagenta": "#4ECDC4",
    "terminal.ansiCyan": "#00FF9F"
  },
  "tokenColors": [
    {
      "scope": "keyword.control",
      "settings": {
        "foreground": "#FF6B6B"
      }
    },
    {
      "scope": "storage.type.class",
      "settings": {
        "foreground": "#4ECDC4"
      }
    },
    {
      "scope": "storage.type.const",
      "settings": {
        "foreground": "#45B7D1"
      }
    },
    {
      "scope": "keyword.other.import",
      "settings": {
        "foreground": "#96CEB4"
      }
    }
  ]
}
EOF
}

export -f dna_export_config
export -f dna_export_iterm2
export -f dna_export_vscode

# Export aliases
alias dna-export-config="dna_export_config"
alias dna-export-iterm2="dna_export_iterm2"
alias dna-export-vscode="dna_export_vscode"
EOF

    # 6. Source all integration files
    echo "source ~/.config/terminal-themes/dna-persona.sh" >> ~/.bashrc
    echo "source ~/.config/terminal-themes/dna-bubble-ships.sh" >> ~/.bashrc
    echo "source ~/.config/terminal-themes/dna-xr-integration.sh" >> ~/.bashrc
    echo "source ~/.config/terminal-themes/dna-export.sh" >> ~/.bashrc
    
    echo "✅ DNA Helix integration complete!"
    echo ""
    echo "🧬 Available DNA commands:"
    echo "   dna-map           - Show base pair syntax mapping"
    echo "   dna-demo          - Transcription demo"
    echo "   dna-evolve        - Genetic algorithm simulation"
    echo "   dna-transcribe    - Start transcription process"
    echo "   spawn-dna-fleet   - Summon genetic research vessels"
    echo "   summon-carriers   - Deploy DNA cargo ships"
    echo "   xr-dna           - Enable XR DNA visualization"
    echo "   dna-export-config - Export theme configuration"
    echo ""
    echo "🧬 Git genetic operations:"
    echo "   git-mutate        - Create mutations (branches)"
    echo "   git-splice        - Gene splicing (merge)"
    echo "   git-sequence      - DNA sequencing (log)"
    echo ""
    echo "Ready for genetic programming! 🧬⚛️"
}

# Validate DNA theme installation
validate_dna_installation() {
    echo "🧬 Validating DNA Helix installation..."
    
    local valid=true
    
    # Check required files
    local required_files=(
        "~/.config/terminal-themes/dna-helix.sh"
        "~/.config/terminal-themes/dna-persona.sh"
        "~/.config/terminal-themes/dna-bubble-ships.sh"
        "~/.config/terminal-themes/dna-xr-integration.sh"
        "~/.config/terminal-themes/dna-export.sh"
    )
    
    for file in "${required_files[@]}"; do
        if [ ! -f "$file" ]; then
            echo "❌ Missing: $file"
            valid=false
        else
            echo "✅ Found: $file"
        fi
    done
    
    # Check commands
    local required_commands=(
        "dna-map"
        "dna-demo"
        "dna-evolve"
        "spawn-dna-fleet"
    )
    
    for cmd in "${required_commands[@]}"; do
        if command -v "$cmd" &> /dev/null; then
            echo "✅ Command: $cmd"
        else
            echo "❌ Missing command: $cmd"
            valid=false
        fi
    done
    
    if [ "$valid" = true ]; then
        echo "🧬 DNA Helix validation: PASSED"
        echo "   All genetic systems operational!"
    else
        echo "❌ DNA Helix validation: FAILED"
        echo "   Run 'integrate_dna_with_cursive' to fix issues"
    fi
}

# Main execution
main() {
    case ${1:-"integrate"} in
        "integrate")
            integrate_dna_with_cursive
            ;;
        "validate")
            validate_dna_installation
            ;;
        "help")
            echo "🧬 DNA Integration Commands:"
            echo "   ./dna-integration.sh integrate  - Full DNA integration"
            echo "   ./dna-integration.sh validate   - Validate installation"
            echo "   ./dna-integration.sh help       - Show this help"
            ;;
        *)
            echo "❌ Unknown command: $1"
            echo "Run './dna-integration.sh help' for options"
            ;;
    esac
}

# Export main function
export -f integrate_dna_with_cursive
export -f validate_dna_installation

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi