# 🎮 Cursive Units: Multi-Resolution Rendering System

## Overview
A revolutionary rendering system that represents code units, personas, and fleets as game pieces that scale from ASCII art to photorealistic 3D models.

## Rendering Levels

### Level 0: Terminal ASCII (8x8)
```
 Fleet:     Unit:      Persona:
   ⛵        👤          🧛
  ~~~~      ╱│╲         ╱▓╲
            ╱ ╲         ╱ ╲
```

### Level 1: Pixel Art (32x32)
```
┌────────┐  ┌────────┐  ┌────────┐
│ ▄██▄   │  │  ▄▄▄   │  │ ▄▓▓▄   │
│██⛵██  │  │ █👤█   │  │█🧛█   │
│ ▀██▀   │  │  ▀▀▀   │  │ ▀▓▓▀   │
└────────┘  └────────┘  └────────┘
```

### Level 2: Voxel/Minecraft Style (64x64x64)
- 3D pixelated models
- Basic animations
- Terminal-friendly rendering

### Level 3: Low-Poly Game Pieces (1K polys)
- Stylized board game aesthetic
- PBR materials
- Real-time shadows

### Level 4: Photorealistic Miniatures (100K+ polys)
- Museum-quality details
- Subsurface scattering
- Physically accurate materials

## Unit Types & Visual Representations

### Code Units
```yaml
Function:
  ascii: "ƒ()"
  icon: chess_knight.glb
  material: "obsidian"
  animations: ["idle", "execute", "error"]

Class:
  ascii: "◇"
  icon: castle_tower.glb
  material: "marble"
  animations: ["construct", "inherit", "destroy"]

Module:
  ascii: "▣"
  icon: crystal_cube.glb
  material: "glass"
  animations: ["import", "export", "refactor"]
```

### Persona Fleets
```yaml
PirateFleet:
  flagship:
    ascii: "⛵"
    model: "galleon_miniature.glb"
    material: "weathered_wood"
    scale: [1.5, 1.5, 1.5]
  
  units:
    - type: "frigate"
      count: 3
      ascii: "⛵"
      model: "frigate_miniature.glb"
    
    - type: "crew"
      count: 12
      ascii: "👤"
      model: "pirate_crew.glb"

VampireHorde:
  castle:
    ascii: "🏰"
    model: "gothic_castle.glb"
    material: "dark_stone"
  
  units:
    - type: "vampire_lord"
      count: 1
      ascii: "🧛"
      model: "vampire_noble.glb"
    
    - type: "thralls"
      count: 20
      ascii: "👥"
      model: "vampire_minions.glb"
```

## Terminal Browser Architecture

### Progressive Enhancement
```javascript
class CursiveUnit {
  constructor(unitData) {
    this.levels = {
      ascii: unitData.ascii,
      pixel: unitData.pixelSprite,
      voxel: unitData.voxelModel,
      lowPoly: unitData.gameModel,
      photoreal: unitData.hdModel
    };
    
    this.currentLevel = this.detectRenderCapability();
  }
  
  detectRenderCapability() {
    if (isTerminal()) return 'ascii';
    if (isLowEndDevice()) return 'pixel';
    if (hasWebGL()) return 'voxel';
    if (hasWebGL2()) return 'lowPoly';
    if (hasWebGPU()) return 'photoreal';
    return 'ascii';
  }
  
  render(context) {
    switch(this.currentLevel) {
      case 'ascii':
        return this.renderASCII(context);
      case 'pixel':
        return this.renderPixelArt(context);
      case 'voxel':
        return this.renderVoxel(context);
      case 'lowPoly':
        return this.renderGamePiece(context);
      case 'photoreal':
        return this.renderPhotorealistic(context);
    }
  }
}
```

### Storage Format
```json
{
  "unitId": "pirate_flagship",
  "name": "The Crimson Revenge",
  "representations": {
    "ascii": {
      "symbol": "⛵",
      "color": "#8B4513"
    },
    "pixel": {
      "sprite": "pirate_ship_32x32.png",
      "animations": ["sail", "battle", "sink"]
    },
    "voxel": {
      "model": "pirate_ship.vox",
      "palette": "wood_and_canvas"
    },
    "gamePiece": {
      "model": "pirate_galleon_lowpoly.glb",
      "material": "stylized_wood",
      "lodLevels": [1000, 500, 250]
    },
    "photoreal": {
      "model": "pirate_galleon_hero.glb",
      "textures": {
        "diffuse": "galleon_diffuse_4k.jpg",
        "normal": "galleon_normal_4k.jpg",
        "roughness": "galleon_roughness_4k.jpg"
      }
    }
  }
}
```

## Board View System

### Terminal Board
```
┌─────────────────────────────────┐
│ Cursive Code Battlefield        │
├─────────────────────────────────┤
│     A    B    C    D    E       │
│ 1  [⛵] [  ] [🧛] [  ] [⚙️]    │
│ 2  [👤] [📜] [  ] [🦇] [  ]    │
│ 3  [  ] [ƒ()] [◇] [  ] [🔧]    │
│ 4  [🏴] [  ] [  ] [  ] [🏰]    │
└─────────────────────────────────┘
```

### 3D Board View
```javascript
class CursiveBoardView {
  constructor(renderLevel) {
    this.board = new THREE.Scene();
    this.setupLighting();
    this.setupCamera();
    this.loadUnits();
  }
  
  loadUnits() {
    this.units.forEach(unit => {
      const piece = new GamePiece(unit);
      piece.loadModel(this.renderLevel);
      piece.position.set(
        unit.gridX * TILE_SIZE,
        0,
        unit.gridY * TILE_SIZE
      );
      this.board.add(piece);
    });
  }
  
  animateMove(unit, fromPos, toPos) {
    const piece = this.getPiece(unit);
    const tween = new TWEEN.Tween(piece.position)
      .to(toPos, 1000)
      .easing(TWEEN.Easing.Quadratic.InOut)
      .onUpdate(() => this.render())
      .start();
  }
}
```

## Integration with Cursive Code

### Unit Creation from Code
```javascript
// Automatically generate units from code structure
class CodeToUnit {
  static analyzeRepository(repo) {
    const units = [];
    
    // Functions become knights
    repo.functions.forEach(func => {
      units.push({
        type: 'knight',
        name: func.name,
        power: func.complexity,
        model: 'chess_knight.glb'
      });
    });
    
    // Classes become castles
    repo.classes.forEach(cls => {
      units.push({
        type: 'castle',
        name: cls.name,
        defense: cls.methods.length,
        model: 'castle_tower.glb'
      });
    });
    
    return units;
  }
}
```

### Fleet Management
```bash
# Command line fleet control
cursive-fleet spawn pirate --units 5 --render voxel
cursive-fleet move "Crimson Revenge" --to D4
cursive-fleet battle vampire --animation full
```

## Rendering Pipeline

### 1. Asset Loading
```javascript
class AssetManager {
  async loadUnit(unitId, renderLevel) {
    const manifest = await fetch(`/units/${unitId}/manifest.json`);
    const data = await manifest.json();
    
    switch(renderLevel) {
      case 'ascii':
        return data.representations.ascii;
      
      case 'voxel':
        const voxelData = await fetch(data.representations.voxel.model);
        return this.parseVoxel(voxelData);
      
      case 'photoreal':
        const model = await this.loadGLTF(data.representations.photoreal.model);
        await this.loadTextures(data.representations.photoreal.textures);
        return model;
    }
  }
}
```

### 2. Progressive Loading
```javascript
// Start with ASCII, progressively enhance
class ProgressiveUnit {
  constructor(unitId) {
    this.unitId = unitId;
    this.representations = {};
    
    // Immediate ASCII render
    this.loadASCII();
    
    // Background load higher quality
    this.loadProgressive();
  }
  
  async loadProgressive() {
    // Load in background, upgrade when ready
    for (const level of ['pixel', 'voxel', 'lowPoly', 'photoreal']) {
      if (this.canRender(level)) {
        const asset = await AssetManager.loadUnit(this.unitId, level);
        this.representations[level] = asset;
        this.upgradeRender(level);
      }
    }
  }
}
```

## VR/AR Support

### WebXR Integration
```javascript
class CursiveXR {
  async enterVR() {
    const session = await navigator.xr.requestSession('immersive-vr');
    
    // Scale up units for VR
    this.units.forEach(unit => {
      unit.scale.multiplyScalar(10);
      unit.enablePhysics();
      unit.enableGrabbing();
    });
    
    // Add hand tracking for piece manipulation
    this.setupHandTracking(session);
  }
  
  placeUnitInAR(unit) {
    // Place game piece on real table
    const hitTest = await this.performHitTest();
    unit.position.copy(hitTest.position);
    unit.enableARShadows();
  }
}
```

## Export Formats

### 3D Printing Support
```yaml
export_profiles:
  miniature_28mm:
    scale: 0.028
    supports: auto
    base: round_25mm
    detail_level: high
    
  display_piece:
    scale: 0.1
    supports: tree
    base: display_plinth
    detail_level: maximum
```

### Unreal Engine Integration
```cpp
// Unreal Engine Actor
class CURSIVE_API ACursiveUnit : public AActor {
public:
    UPROPERTY(EditAnywhere)
    UStaticMeshComponent* MeshComponent;
    
    UPROPERTY(EditAnywhere)
    UCursiveUnitData* UnitData;
    
    void SetRenderLevel(ECursiveRenderLevel Level);
    void AnimateToPosition(FVector NewPosition);
};
```

## Performance Optimizations

### LOD System
```javascript
const LODLevels = {
  distance_0_10: 'photoreal',    // < 10 units
  distance_10_50: 'lowPoly',     // 10-50 units
  distance_50_100: 'voxel',      // 50-100 units
  distance_100_plus: 'pixel'     // > 100 units
};
```

### Instanced Rendering
```javascript
// Render thousands of units efficiently
class UnitInstancer {
  constructor(unitType) {
    this.geometry = unitType.geometry;
    this.material = unitType.material;
    this.mesh = new THREE.InstancedMesh(
      this.geometry,
      this.material,
      MAX_INSTANCES
    );
  }
  
  updateInstances(units) {
    units.forEach((unit, i) => {
      unit.updateMatrix();
      this.mesh.setMatrixAt(i, unit.matrix);
    });
    this.mesh.instanceMatrix.needsUpdate = true;
  }
}
```

## Theme Integration

Each theme provides its own unit aesthetics:

### Pirate Theme Units
- Ships: Weather-beaten galleons
- Crew: Swashbucklers and parrots
- Buildings: Taverns and docks
- Resources: Treasure chests

### Vampire Theme Units
- Castle: Gothic fortress
- Units: Bats, vampires, thralls
- Buildings: Crypts and towers
- Resources: Blood vials

### Clockwork Theme Units
- Machines: Brass automatons
- Units: Cogs and gears
- Buildings: Factories
- Resources: Steam cores

## Future Possibilities

1. **NFT Integration**: Unique, tradeable game pieces
2. **Physics Simulation**: Pieces that topple and interact
3. **AI Photography**: Generate new piece designs
4. **Community Workshop**: User-created miniatures
5. **Tournament Mode**: Competitive code battles with pieces

---

*"From terminal to table, your code comes alive"* 🎲✨