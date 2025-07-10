# 🚀 Product Hunt Launch Assets
*Complete visual package for Cursive Terminal Ecosystem launch*

## 📱 **Required Assets Specifications**

### **1. Logo Variations**
- **Main Logo**: 1024x1024px PNG (transparent background)
- **App Icon**: 240x240px PNG (square, rounded corners optional)
- **Favicon**: 32x32px ICO format
- **Social Media**: 400x400px PNG for Twitter/Discord avatars

### **2. Gallery Screenshots (6 required)**

#### **Screenshot 1: Hero - DNA Terminal in Action**
- **Dimensions**: 1280x800px
- **Content**: Terminal showing DNA bubbles with live gene transcription
- **Text overlay**: "Your Terminal, Scientifically Enhanced"

#### **Screenshot 2: Theme Gallery Grid**
- **Dimensions**: 1280x800px  
- **Content**: 6x6 grid of theme previews with hover effects
- **Text overlay**: "33 DNA-Mapped Themes"

#### **Screenshot 3: Captain Code CLI Demo**
- **Dimensions**: 1280x800px
- **Content**: Terminal session with Captain Code responding to vision analysis
- **Text overlay**: "AI Assistant with Personality"

#### **Screenshot 4: Four-Tier Ecosystem**
- **Dimensions**: 1280x800px
- **Content**: Progression diagram: Terminal → Code → Coder → Coders
- **Text overlay**: "Complete AI Development Ecosystem"

#### **Screenshot 5: Gene Bubbles Visualization**
- **Dimensions**: 1280x800px
- **Content**: Close-up of DNA bubbles floating in terminal with code
- **Text overlay**: "Living Genetic Code Visualization"

#### **Screenshot 6: Multi-Platform Support**
- **Dimensions**: 1280x800px
- **Content**: Cursive Terminal running on macOS, Linux, Windows terminals
- **Text overlay**: "Cross-Platform Terminal Beauty"

### **3. Demo GIF (30 seconds max)**
- **Dimensions**: 800x600px
- **Format**: MP4 (converted to GIF for upload)
- **Content**: 
  1. Launch terminal with plain theme (2s)
  2. Apply Vampire's Letter theme with DNA bubbles (3s)
  3. Switch to Captain Code CLI mode (3s)
  4. AI responds to coding question with personality (4s)
  5. Show vision analysis of UI mockup (4s)
  6. Display ecosystem upgrade path (4s)
  7. End with "Revolutionize Your Terminal" (2s)

## 🎨 **Color Palette & Branding**

### **Primary Colors (DNA Bases)**
```css
--adenine: #FF6B6B;   /* Functions - Red */
--thymine: #4ECDC4;   /* Classes - Teal */
--guanine: #45B7D1;   /* Constants - Blue */
--cytosine: #96CEB4;  /* Imports - Green */
```

### **Brand Typography**
- **Primary**: Victor Mono (Italic for cursive effect)
- **Secondary**: Inter (for UI text)
- **Accent**: Fira Code (for code examples)

### **Visual Style Guidelines**
- **Aesthetic**: Cyberpunk meets molecular biology
- **Mood**: Mysterious, scientific, elegant
- **Effects**: Subtle glow, DNA helix patterns, particle systems
- **Contrast**: High contrast for accessibility (WCAG-AA compliant)

## 📝 **Product Hunt Listing Copy**

### **Tagline**
"Turn your terminal into a living genetic laboratory"

### **Description**
Transform your terminal with 33 scientifically-accurate DNA themes featuring live genetic visualization. Each code element maps to DNA bases (A/T/G/C) with floating gene bubbles that respond to your development workflow.

**🧬 What makes it revolutionary:**
- **DNA-accurate themes** based on real molecular biology
- **Captain Code AI** - terminal assistant with personality and vision
- **Live gene bubbles** that visualize code structure in real-time
- **Four-tier ecosystem** from free themes to enterprise AI swarms
- **Cross-platform** support (macOS, Linux, Windows)

Perfect for developers who believe terminals should be both beautiful and scientifically meaningful.

### **Maker Comment Template**
```
Hey Product Hunt! 👋

I built Cursive Terminal because I was tired of boring, generic terminal themes. As someone fascinated by both coding and molecular biology, I wondered: "What if my terminal could visualize code like DNA?"

🧬 The result: 33 themes where every function = Adenine, every class = Thymine, constants = Guanine, and imports = Cytosine. Your code literally becomes living genetic material!

But it doesn't stop there. I've built a complete four-tier ecosystem:
🏴‍☠️ Cursive Terminal - Beautiful DNA themes (FREE)
⚡ Cursive Code - Terminal AI with Captain Code personality
🧬 Cursive Coder - Multi-agent development platform  
⭐ Cursive Coders - Elite AI swarms for enterprise teams

The Captain Code AI can even analyze screenshots and UI mockups directly in your terminal - making it the first terminal AI with true vision capabilities.

Would love your feedback! What features would you want in a scientifically-enhanced terminal? 🚀

Try it: `npm install -g cursive-code`
```

### **Tags for Product Hunt**
- #DeveloperTools
- #Terminal
- #CLI
- #AI
- #OpenSource
- #Design
- #Productivity
- #MacOS
- #Linux
- #Themes

## 🎬 **Demo GIF Storyboard**

### **Frame-by-Frame Breakdown**

**Frames 1-60 (2s): Opening**
- Start with plain terminal prompt
- Text appears: "Your terminal deserves better..."

**Frames 61-150 (3s): DNA Theme Application**
- Command: `source ~/.cursive-themes/vampires-letter.sh`
- Terminal transforms with dark velvet background
- DNA bubbles start floating: 🔴🟢🔵🟣
- Code appears with gene mapping

**Frames 151-240 (3s): Captain Code Introduction**
- Command: `cursive-code --interactive`
- Banner appears with Captain Code ⚡
- Personality message: "Ready for efficient terminal AI!"

**Frames 241-360 (4s): AI Coding Assistant**
- User types: "Help me optimize this React component"
- Captain Code responds with practical, formatted advice
- Show DNA bubbles reacting to code changes

**Frames 361-480 (4s): Vision Analysis Demo**
- Command: `cursive-code --vision ui-mockup.png "Convert to React"`
- Show image analysis in terminal
- AI provides component code with styling

**Frames 481-600 (4s): Ecosystem Showcase**
- Quick montage of four tiers:
  - Terminal themes → Code AI → Coder web app → Coders elite
- Upgrade path visualization

**Frames 601-660 (2s): Call to Action**
- Text: "Revolutionize Your Terminal"
- Command: `npm install -g cursive-code`
- GitHub stars counter animation
- End with Cursive logo

## 🖼️ **Asset Creation Commands**

### **Generate Logo Set**
```bash
# Create base logo (requires design software or AI generation)
# Primary logo: DNA helix with terminal cursor
# Colors: Gradient from #FF6B6B to #4ECDC4
# Style: Modern, clean, scientific
```

### **Screenshot Automation**
```bash
# Automated screenshot capture
cd scripts
./capture-theme-screenshots.sh --product-hunt --resolution=1280x800
./capture-cli-demo.sh --captain-code --with-bubbles
./create-ecosystem-diagram.sh --four-tier --branding
```

### **GIF Creation**
```bash
# Using ScreenFlow or similar tool
# Record at 30fps, export as MP4
# Convert to optimized GIF with gifsicle
ffmpeg -i demo.mp4 -vf "fps=15,scale=800:600" demo.gif
gifsicle --optimize=3 --delay=7 demo.gif > demo-optimized.gif
```

## 📊 **Launch Day Metrics Targets**

### **24-Hour Goals**
- **Product Hunt**: Top 10 ranking
- **GitHub Stars**: 100+ stars across all repos
- **NPM Downloads**: 1000+ cursive-code installs
- **Social Media**: 50+ mentions/shares
- **Website Traffic**: 5000+ unique visitors

### **Success Indicators**
- Featured in PH newsletter
- Trending on GitHub
- Mentioned by tech influencers
- Posted in r/commandline, r/programming
- Added to terminal tools collections

## 🔗 **Asset Delivery Checklist**

- [ ] Main logo (1024x1024 PNG)
- [ ] App icon (240x240 PNG)  
- [ ] Favicon (32x32 ICO)
- [ ] 6 gallery screenshots (1280x800 PNG each)
- [ ] 30-second demo GIF (800x600)
- [ ] Product Hunt listing copy
- [ ] Maker comment template
- [ ] Social media posts drafted
- [ ] Press kit README.md created

---

**🧬 Ready to launch the genetic revolution in terminal development!**

*All assets following this specification will create a cohesive, professional Product Hunt presence that showcases the unique scientific approach and four-tier ecosystem strategy.*