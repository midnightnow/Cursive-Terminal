---
name: Adaptive Unit Sprite Export Pipeline
about: Create multi-resolution asset pipeline for game pieces
title: '[GRAPHICS] Implement adaptive unit sprite export (16px → GLB)'
labels: good-first-issue, graphics
assignees: ''
---

## 🎮 Create the Asset Pipeline!

Build a system that takes a single sprite and exports it at multiple resolutions for our game piece units.

### 📋 Requirements

Create a pipeline that generates from one source:
- [ ] 16×16px terminal ASCII/emoji
- [ ] 32×32px favicon
- [ ] 64×64px icon
- [ ] 128×128px detailed PNG
- [ ] SVG vector version
- [ ] Low-poly GLB (< 1000 triangles)
- [ ] High-poly GLB (< 10000 triangles)

### 🏴‍☠️ First Unit: Pirate Galleon

Start with the flagship of our pirate fleet:

```
Input: pirate-galleon-source.png (512×512)

Output:
├── terminal/
│   └── galleon.txt (ASCII art)
├── icons/
│   ├── galleon-16.png
│   ├── galleon-32.png
│   ├── galleon-64.png
│   └── galleon-128.png
├── vectors/
│   └── galleon.svg
└── models/
    ├── galleon-low.glb
    └── galleon-high.glb
```

### 🛠️ Technical Approach

**New file:** `scripts/unit-asset-pipeline.js`

```javascript
class UnitAssetPipeline {
  async processUnit(sourcePath, unitName) {
    const source = await loadImage(sourcePath);
    
    // Generate sizes
    await this.generateIcons(source, unitName);
    await this.generateASCII(source, unitName);
    await this.generateSVG(source, unitName);
    await this.generate3D(source, unitName);
  }
  
  generateASCII(source, name) {
    // Convert to 16×16 ASCII art
    // Use density mapping: █▓▒░
  }
  
  generate3D(source, name) {
    // Option 1: Height map → mesh
    // Option 2: SVG extrude → GLB
    // Option 3: Voxelize → optimize
  }
}
```

### ✅ Acceptance Criteria

1. Single command processes all formats
2. Maintains visual consistency across sizes
3. ASCII art is recognizable
4. 3D models are game-piece styled (flat base)
5. Total pipeline time < 10 seconds

### 🎨 Sprite Guidelines

For the pirate galleon:
- Side view (like classic game piece)
- Clear silhouette
- High contrast
- Identifiable at all sizes

### 📊 LOD (Level of Detail) Specs

```javascript
const LOD_CONFIG = {
  terminal: {
    size: 16,
    colors: 2,  // Monochrome
    format: 'ASCII'
  },
  icon_small: {
    size: 32,
    colors: 16,
    format: 'PNG'
  },
  icon_large: {
    size: 128,
    colors: 'full',
    format: 'PNG'
  },
  model_low: {
    triangles: 500,
    texture: '128×128',
    format: 'GLB'
  },
  model_high: {
    triangles: 5000,
    texture: '512×512',
    format: 'GLB'
  }
};
```

### 🚀 Stretch Goals

- Auto-generate material variations (wood, metal, crystal)
- Animation states (idle, moving, destroyed)
- Team color masks
- Emissive maps for magical units

### 📚 Resources

- [Sharp.js for image processing](https://sharp.pixelplumbing.com/)
- [SVG.js for vector generation](https://svgjs.dev/)
- [Three.js GLTFExporter](https://threejs.org/docs/#examples/en/exporters/GLTFExporter)
- [ASCII art best practices](https://en.wikipedia.org/wiki/ASCII_art)

### 🏗️ Setup

```bash
npm install sharp svgjs three gltf-pipeline
```

### 📝 Example ASCII Output

```
16×16 Galleon:
     ▄▄▄▄
    ██⛵██
   ████████
  ~~~~~~~~~~
```

*"From pixels to polygons, make our fleet sail!"* 🏴‍☠️