# 📜 Scripts Reference - Cursive Terminal

Complete reference guide for all scripts in the Cursive Terminal project.

## 📊 Quick Reference Table

| Script | Type | Purpose | User-Facing |
|--------|------|---------|-------------|
| `cursive_font_demo.sh` | Demo | Showcase cursive fonts | ✅ Yes |
| `colored_text_demo.sh` | Demo | Display color capabilities | ✅ Yes |
| `theme-selector.sh` | Tool | Interactive theme picker | ✅ Yes |
| `showcase.sh` | Demo | Feature presentation | ✅ Yes |
| `font_comparison.sh` | Demo | Compare cursive fonts | ✅ Yes |
| `font_preview_generator.py` | Utility | Generate font images | 🔧 Dev |
| `showcase_gif_generator.sh` | Utility | Create animated GIFs | 🔧 Dev |
| `create_oblique_font.py` | Utility | Generate slanted fonts | 🔧 Dev |
| `license_generator.sh` | Utility | Generate MIT license | 🔧 Dev |
| `theme-selector-web.html` | Tool | Web-based theme selector | ✅ Yes |
| `run-all-tests.sh` | Testing | Execute all tests | 🧪 Test |
| `launch-validator.sh` | Testing | Validate launch readiness | 🧪 Test |

## 🎨 Demo Scripts

### `cursive_font_demo.sh`
**Purpose**: Demonstrate how cursive fonts render in the terminal

**Usage**:
```bash
./scripts/cursive_font_demo.sh
```

**What it shows**:
- List of recommended cursive fonts
- How to install each font
- Terminal setup instructions for Terminal.app and iTerm2
- Sample cursive text rendering

**Best for**: First-time users wanting to see what cursive fonts look like

---

### `colored_text_demo.sh`
**Purpose**: Comprehensive showcase of color capabilities with cursive text

**Usage**:
```bash
./scripts/colored_text_demo.sh
```

**Features Demonstrated**:
- 8-color ANSI palette in cursive
- 16-color bright palette
- Rainbow text effects
- Code syntax highlighting
- Git status displays
- 256-color palette
- 24-bit true color gradients
- Colored ASCII art

**Requirements**: `TERM=xterm-256color` for full color support

**Best for**: Seeing the full range of color + cursive combinations

---

### `showcase.sh`
**Purpose**: Animated feature presentation

**Usage**:
```bash
./scripts/showcase.sh
```

**Highlights**:
- Beautiful cursive text rendering
- Syntax highlighting in cursive
- Custom color themes
- Code examples with cursive comments
- Quick start instructions

**Best for**: Quick overview of project capabilities

---

### `font_comparison.sh`
**Purpose**: Side-by-side comparison of different cursive fonts

**Usage**:
```bash
./scripts/font_comparison.sh
```

**Fonts Compared**:
- Victor Mono (most cursive)
- Cascadia Code (elegant)
- JetBrains Mono (subtle)
- Fira Code (ligatures)
- SF Mono Oblique (custom slanted)

**Information Provided**:
- Cursiveness level
- Best use cases
- Installation methods
- Visual comparison

**Best for**: Choosing which cursive font to use

---

### `showcase-all-themes.sh`
**Purpose**: Display all 33 themes with examples

**Usage**:
```bash
./scripts/showcase-all-themes.sh
```

**What it shows**:
- Each theme applied
- Color samples
- Code examples in each theme
- Theme categories

**Duration**: ~2 minutes (cycles through all themes)

**Best for**: Browsing all available themes

---

## 🛠️ User Tools

### `theme-selector.sh`
**Purpose**: Interactive terminal-based theme selector

**Usage**:
```bash
./scripts/theme-selector.sh
```

**Features**:
- Browse themes by category
- Live preview
- Apply themes instantly
- Search functionality
- Favorites system

**Requirements**:
- Themes must be installed via `quick_setup.sh`
- Theme directory at `~/.config/terminal-themes/`

**Categories**:
1. Dark Themes (9 themes)
2. Light Manuscript (6 themes)
3. Colorful (6 themes)
4. Business Document (6 themes)
5. Feather-Light (6 themes)

**Best for**: Regular users switching between themes

---

### `theme-selector-web.html`
**Purpose**: Web-based theme browser and selector

**Usage**:
```bash
open scripts/theme-selector-web.html
# or
python -m http.server 8000
# then open http://localhost:8000/scripts/theme-selector-web.html
```

**Features**:
- Visual previews of all themes
- Filter by category
- Copy theme application commands
- Responsive design
- No installation required

**Best for**: Visual browsing without installing themes

---

## 🔧 Development Utilities

### `font_preview_generator.py`
**Purpose**: Generate PNG preview images of fonts

**Usage**:
```bash
python scripts/font_preview_generator.py
```

**Requirements**:
```bash
pip install Pillow
```

**Output**: PNG images in `docs/images/` directory

**Configuration**:
- Edit script to change font paths
- Modify text samples
- Adjust image size and colors

**Best for**: Creating documentation screenshots

---

### `showcase_gif_generator.sh`
**Purpose**: Create animated GIF demonstrations

**Usage**:
```bash
./scripts/showcase_gif_generator.sh
```

**Requirements**:
```bash
brew install asciinema
cargo install --git https://github.com/asciinema/agg
```

**Process**:
1. Records terminal session with asciinema
2. Converts to GIF with agg
3. Optimizes file size

**Output**: `showcase.gif` in project root

**Best for**: Creating demo GIFs for README

---

### `create_oblique_font.py`
**Purpose**: Generate custom slanted/oblique fonts from regular fonts

**Usage**:
```bash
python scripts/create_oblique_font.py input.ttf output.ttf
```

**Requirements**:
```bash
pip install fonttools
```

**Parameters**:
- `input.ttf`: Source font file
- `output.ttf`: Output slanted font file
- Slant angle: Configurable in script

**Best for**: Creating cursive-style fonts from non-cursive monospace fonts

---

### `license_generator.sh`
**Purpose**: Generate MIT license file

**Usage**:
```bash
./scripts/license_generator.sh
```

**Output**: `LICENSE` file in project root

**Configuration**: Edit script to change:
- Copyright year
- Copyright holder name

**Best for**: Initializing new projects or updating license

---

## 🧪 Testing Scripts

### `run-all-tests.sh`
**Purpose**: Execute complete test suite

**Usage**:
```bash
./scripts/run-all-tests.sh
```

**Tests Run**:
- Theme installation verification
- Script execution tests
- Font detection
- Color capability tests
- Configuration file validation

**Exit Codes**:
- `0`: All tests passed
- `1`: One or more tests failed

**Output**: Detailed test results with ✓/✗ indicators

**Best for**: Pre-commit testing, CI/CD pipelines

---

### `test-theme-selector.sh`
**Purpose**: Test theme selector functionality

**Usage**:
```bash
./scripts/test-theme-selector.sh
```

**Tests**:
- Theme directory exists
- All 33 themes present
- Theme files are valid
- Selector script is executable

**Best for**: Verifying theme installation

---

### `launch-validator.sh`
**Purpose**: Validate project is ready for launch/release

**Usage**:
```bash
./scripts/launch-validator.sh
```

**Validates**:
- All documentation files present
- Scripts are executable
- No broken links in markdown
- Required directories exist
- Git repository status
- Version numbers consistent

**Generates**: `launch-validation-report.md`

**Best for**: Pre-release checklist

---

## 🚀 Deployment Scripts

### `launch-now.sh` (Project Root)
**Purpose**: Execute commercial launch workflow

**Usage**:
```bash
./launch-now.sh
```

**Actions**:
1. Validates project state
2. Commits changes
3. Pushes to GitHub
4. Opens sponsor platform links
5. Prepares marketing materials

**Best for**: Production deployment

---

### `deploy-cursive-ecosystem.sh`
**Purpose**: Deploy complete cursive terminal ecosystem

**Usage**:
```bash
./scripts/deploy-cursive-ecosystem.sh
```

**Components Deployed**:
- Terminal themes
- Font configurations
- Editor integrations
- Shell customizations

**Best for**: Full system setup

---

### `launch-orchestrator.sh`
**Purpose**: Coordinate multi-step launch process

**Usage**:
```bash
./scripts/launch-orchestrator.sh
```

**Orchestrates**:
- Pre-launch validation
- Git operations
- Documentation generation
- Release creation
- Post-launch verification

**Best for**: Automated release workflow

---

## 📦 Installation Scripts

### `install-all-themes.sh`
**Purpose**: Install all 33 themes to system

**Usage**:
```bash
./scripts/install-all-themes.sh
```

**Installation Location**: `~/.config/terminal-themes/`

**Creates**:
- Theme directory structure
- Individual theme files
- Theme index
- Quick access scripts

**Best for**: Included in main installation workflow

---

### `add_feather_light_themes.sh`
**Purpose**: Add WCAG-AA compliant light themes

**Usage**:
```bash
./scripts/add_feather_light_themes.sh
```

**Themes Added** (6 total):
- Papyrus Scroll
- Linen Sheet
- Calligraphy Flourish
- Ivory Letter
- Pearl Manuscript
- Invisible Ink

**Contrast Ratios**: All meet WCAG-AA standards (4.5:1+)

**Best for**: Accessibility-focused installations

---

### `add_missing_themes.sh`
**Purpose**: Add any themes missing from installation

**Usage**:
```bash
./scripts/add_missing_themes.sh
```

**Process**:
1. Checks installed themes
2. Compares with expected list
3. Installs missing themes
4. Verifies installation

**Best for**: Updating existing installations

---

## 📝 Documentation Scripts

### `generate-theme-demos.sh`
**Purpose**: Generate documentation and demos for all themes

**Usage**:
```bash
./scripts/generate-theme-demos.sh
```

**Generates**:
- Screenshot for each theme
- Theme description files
- Comparison images
- Demo videos (if tools available)

**Output Directory**: `docs/images/themes/`

**Best for**: Updating documentation with latest themes

---

### `prepare-deployment.sh`
**Purpose**: Prepare all deployment materials

**Usage**:
```bash
./scripts/prepare-deployment.sh
```

**Preparation Steps**:
1. Validates all files
2. Generates previews
3. Creates archives
4. Updates documentation
5. Checks git status

**Output**: Deployment checklist and status report

**Best for**: Pre-deployment preparation

---

## 🎬 Marketing Scripts

### Social Media Content Files

**`reddit-post.txt`**
- Pre-written Reddit post for r/unixporn and r/commandline
- Includes install instructions and highlights

**`reddit-post-complete.txt`**
- Extended Reddit post with full feature list

**`reddit-ascii-demo.txt`**
- ASCII art demo for Reddit code blocks

**Usage**: Copy content for social media posting

---

## 📊 Script Statistics

- **Total Scripts**: 40+
- **Demo Scripts**: 5
- **User Tools**: 3
- **Dev Utilities**: 5
- **Testing Scripts**: 3
- **Deployment Scripts**: 5
- **Documentation**: Multiple MD files

## 🔍 Finding the Right Script

### "I want to..."

**See cursive fonts in action**
→ `./scripts/cursive_font_demo.sh`

**Browse and apply themes**
→ `./scripts/theme-selector.sh`

**See all colors possible**
→ `./scripts/colored_text_demo.sh`

**Compare different fonts**
→ `./scripts/font_comparison.sh`

**Get a quick overview**
→ `./scripts/showcase.sh`

**Test everything works**
→ `./scripts/run-all-tests.sh`

**Generate documentation images**
→ `python scripts/font_preview_generator.py`

**Create a demo GIF**
→ `./scripts/showcase_gif_generator.sh`

**Deploy to production**
→ `./launch-now.sh`

**Validate before release**
→ `./scripts/launch-validator.sh`

---

## 💡 Tips

1. **Make scripts executable**: `chmod +x scripts/*.sh`
2. **Set TERM variable**: `export TERM=xterm-256color` for best color support
3. **Run from project root**: Most scripts expect to be run from main directory
4. **Check dependencies**: Some scripts require Python packages or Homebrew tools
5. **Read script headers**: Each script has usage instructions in comments

---

**For development guidelines, see [DEVELOPMENT.md](DEVELOPMENT.md)**

**For troubleshooting, see [TROUBLESHOOTING.md](TROUBLESHOOTING.md)**
