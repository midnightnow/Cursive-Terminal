// 🎮 Cursive Unit Renderer - Progressive Enhancement System

class CursiveUnit {
    constructor(unitData) {
        this.id = unitData.id;
        this.type = unitData.type;
        this.name = unitData.name;
        
        // Multi-resolution representations
        this.representations = {
            ascii: unitData.ascii || this.generateASCII(),
            terminal: unitData.terminal || this.generateTerminal(),
            pixel: null,      // Loaded on demand
            voxel: null,      // Loaded on demand
            lowPoly: null,    // Loaded on demand
            photoreal: null   // Loaded on demand
        };
        
        // Current render state
        this.currentLevel = 'ascii';
        this.position = { x: 0, y: 0, z: 0 };
        this.rotation = { x: 0, y: 0, z: 0 };
        this.scale = 1;
    }
    
    // Generate ASCII representation
    generateASCII() {
        const asciiMap = {
            'ship': '⛵',
            'vampire': '🧛',
            'castle': '🏰',
            'function': 'ƒ()',
            'class': '◇',
            'module': '▣',
            'pirate': '🏴‍☠️',
            'gear': '⚙️',
            'wizard': '🧙'
        };
        return asciiMap[this.type] || '?';
    }
    
    // Generate terminal box art
    generateTerminal() {
        const templates = {
            'ship': [
                '     ⛵     ',
                '    ~~~    ',
                '  ~~~~~~~  '
            ],
            'vampire': [
                '    🧛     ',
                '   ╱│╲    ',
                '  ╱ │ ╲   '
            ],
            'castle': [
                '   ▄▄▄▄   ',
                '  ▐🏰▌   ',
                '  ▐████▌  '
            ]
        };
        return templates[this.type] || ['???'];
    }
    
    // Render based on capability
    render(context, capability) {
        switch(capability) {
            case 'terminal':
                return this.renderTerminal(context);
            case 'canvas2d':
                return this.renderPixel(context);
            case 'webgl':
                return this.renderVoxel(context);
            case 'webgl2':
                return this.renderLowPoly(context);
            case 'webgpu':
                return this.renderPhotoreal(context);
            default:
                return this.renderASCII(context);
        }
    }
    
    // Terminal rendering
    renderTerminal(context) {
        const art = this.representations.terminal;
        const colored = art.map(line => 
            context.theme ? context.theme.colorize(line) : line
        );
        return colored.join('\n');
    }
    
    // ASCII rendering
    renderASCII(context) {
        return this.representations.ascii;
    }
    
    // Progressive loading
    async loadHigherQuality(level) {
        if (this.representations[level]) return;
        
        try {
            const assetPath = `/assets/units/${this.type}/${this.id}/${level}`;
            const response = await fetch(assetPath);
            const data = await response.json();
            
            this.representations[level] = data;
            this.upgradeRenderLevel(level);
        } catch (error) {
            console.log(`Failed to load ${level} for ${this.id}`);
        }
    }
    
    upgradeRenderLevel(newLevel) {
        const levels = ['ascii', 'terminal', 'pixel', 'voxel', 'lowPoly', 'photoreal'];
        const currentIndex = levels.indexOf(this.currentLevel);
        const newIndex = levels.indexOf(newLevel);
        
        if (newIndex > currentIndex) {
            this.currentLevel = newLevel;
            this.emit('levelUpgraded', newLevel);
        }
    }
}

// Board game view system
class CursiveBoardView {
    constructor(options = {}) {
        this.gridSize = options.gridSize || 8;
        this.tileSize = options.tileSize || 64;
        this.renderMode = options.renderMode || 'terminal';
        this.units = new Map();
        this.grid = this.createGrid();
    }
    
    createGrid() {
        const grid = [];
        for (let y = 0; y < this.gridSize; y++) {
            grid[y] = [];
            for (let x = 0; x < this.gridSize; x++) {
                grid[y][x] = null;
            }
        }
        return grid;
    }
    
    placeUnit(unit, x, y) {
        if (this.grid[y] && this.grid[y][x] !== undefined) {
            this.grid[y][x] = unit;
            unit.position = { x, y, z: 0 };
            this.units.set(unit.id, unit);
            return true;
        }
        return false;
    }
    
    renderTerminalBoard() {
        const rows = ['   A  B  C  D  E  F  G  H'];
        
        for (let y = 0; y < this.gridSize; y++) {
            let row = `${y + 1} `;
            for (let x = 0; x < this.gridSize; x++) {
                const unit = this.grid[y][x];
                if (unit) {
                    row += `[${unit.representations.ascii}]`;
                } else {
                    row += '[ ]';
                }
            }
            rows.push(row);
        }
        
        return rows.join('\n');
    }
    
    render3DBoard(renderer) {
        // For Three.js rendering
        const scene = new THREE.Scene();
        
        // Add board
        const boardGeometry = new THREE.PlaneGeometry(
            this.gridSize * this.tileSize,
            this.gridSize * this.tileSize
        );
        const boardMaterial = new THREE.MeshStandardMaterial({
            map: this.generateBoardTexture()
        });
        const board = new THREE.Mesh(boardGeometry, boardMaterial);
        board.rotation.x = -Math.PI / 2;
        scene.add(board);
        
        // Add units
        this.units.forEach(unit => {
            const unitMesh = this.createUnitMesh(unit);
            unitMesh.position.set(
                (unit.position.x - this.gridSize/2) * this.tileSize,
                0,
                (unit.position.y - this.gridSize/2) * this.tileSize
            );
            scene.add(unitMesh);
        });
        
        return scene;
    }
    
    generateBoardTexture() {
        const canvas = document.createElement('canvas');
        canvas.width = canvas.height = this.gridSize * 64;
        const ctx = canvas.getContext('2d');
        
        // Draw checkerboard
        for (let y = 0; y < this.gridSize; y++) {
            for (let x = 0; x < this.gridSize; x++) {
                ctx.fillStyle = (x + y) % 2 === 0 ? '#F5E6D3' : '#8B4513';
                ctx.fillRect(x * 64, y * 64, 64, 64);
            }
        }
        
        return new THREE.CanvasTexture(canvas);
    }
    
    createUnitMesh(unit) {
        // Progressive mesh loading
        switch(unit.currentLevel) {
            case 'voxel':
                return this.createVoxelMesh(unit);
            case 'lowPoly':
                return this.createLowPolyMesh(unit);
            case 'photoreal':
                return this.createPhotorealMesh(unit);
            default:
                return this.createPlaceholderMesh(unit);
        }
    }
    
    createPlaceholderMesh(unit) {
        // Simple colored cube with emoji texture
        const geometry = new THREE.BoxGeometry(40, 40, 40);
        const canvas = document.createElement('canvas');
        canvas.width = canvas.height = 128;
        const ctx = canvas.getContext('2d');
        
        ctx.fillStyle = '#FFFFFF';
        ctx.fillRect(0, 0, 128, 128);
        ctx.font = '64px Arial';
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.fillText(unit.representations.ascii, 64, 64);
        
        const texture = new THREE.CanvasTexture(canvas);
        const material = new THREE.MeshBasicMaterial({ map: texture });
        
        return new THREE.Mesh(geometry, material);
    }
}

// Fleet management system
class CursiveFleet {
    constructor(type, theme) {
        this.type = type;
        this.theme = theme;
        this.units = [];
        this.formation = 'line';
        
        this.loadFleetComposition();
    }
    
    loadFleetComposition() {
        const fleetTemplates = {
            'pirate': {
                flagship: { type: 'ship', id: 'pirate_galleon', count: 1 },
                units: [
                    { type: 'ship', id: 'pirate_frigate', count: 3 },
                    { type: 'pirate', id: 'pirate_crew', count: 12 }
                ]
            },
            'vampire': {
                castle: { type: 'castle', id: 'vampire_castle', count: 1 },
                units: [
                    { type: 'vampire', id: 'vampire_lord', count: 1 },
                    { type: 'vampire', id: 'vampire_spawn', count: 8 }
                ]
            },
            'clockwork': {
                factory: { type: 'building', id: 'clockwork_factory', count: 1 },
                units: [
                    { type: 'gear', id: 'clockwork_automaton', count: 6 },
                    { type: 'gear', id: 'clockwork_engineer', count: 2 }
                ]
            }
        };
        
        const template = fleetTemplates[this.type];
        if (template) {
            this.createUnitsFromTemplate(template);
        }
    }
    
    createUnitsFromTemplate(template) {
        // Create flagship/castle/factory
        if (template.flagship) {
            const flagship = new CursiveUnit(template.flagship);
            flagship.isLeader = true;
            this.units.push(flagship);
        }
        
        // Create units
        template.units.forEach(unitSpec => {
            for (let i = 0; i < unitSpec.count; i++) {
                const unit = new CursiveUnit({
                    ...unitSpec,
                    id: `${unitSpec.id}_${i}`
                });
                this.units.push(unit);
            }
        });
    }
    
    setFormation(formation) {
        this.formation = formation;
        this.arrangeUnits();
    }
    
    arrangeUnits() {
        const formations = {
            'line': this.arrangeInLine.bind(this),
            'wedge': this.arrangeInWedge.bind(this),
            'circle': this.arrangeInCircle.bind(this),
            'scatter': this.arrangeScattered.bind(this)
        };
        
        const arrangeFunc = formations[this.formation] || formations['line'];
        arrangeFunc();
    }
    
    arrangeInLine() {
        this.units.forEach((unit, index) => {
            unit.position.x = index * 2;
            unit.position.y = 0;
        });
    }
    
    arrangeInWedge() {
        const leader = this.units.find(u => u.isLeader);
        if (leader) {
            leader.position = { x: 0, y: 0, z: 0 };
            
            let row = 1;
            let positionInRow = 0;
            
            this.units.filter(u => !u.isLeader).forEach((unit, index) => {
                unit.position.x = (positionInRow - row/2) * 2;
                unit.position.y = row * -2;
                
                positionInRow++;
                if (positionInRow > row) {
                    row++;
                    positionInRow = 0;
                }
            });
        }
    }
}

// Browser detection and capability system
class CursiveRenderer {
    static detectCapabilities() {
        const caps = {
            terminal: typeof process !== 'undefined' && process.stdout,
            canvas2d: typeof document !== 'undefined' && !!document.createElement('canvas').getContext,
            webgl: false,
            webgl2: false,
            webgpu: false
        };
        
        if (caps.canvas2d) {
            const canvas = document.createElement('canvas');
            caps.webgl = !!(canvas.getContext('webgl') || canvas.getContext('experimental-webgl'));
            caps.webgl2 = !!canvas.getContext('webgl2');
            caps.webgpu = !!navigator.gpu;
        }
        
        return caps;
    }
    
    static getBestRenderer() {
        const caps = this.detectCapabilities();
        
        if (caps.webgpu) return 'webgpu';
        if (caps.webgl2) return 'webgl2';
        if (caps.webgl) return 'webgl';
        if (caps.canvas2d) return 'canvas2d';
        if (caps.terminal) return 'terminal';
        return 'ascii';
    }
}

// Export for use
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        CursiveUnit,
        CursiveBoardView,
        CursiveFleet,
        CursiveRenderer
    };
}

// Example usage
/*
// Create a pirate fleet
const pirateFleet = new CursiveFleet('pirate', 'pirate-scroll');

// Create a game board
const board = new CursiveBoardView({
    gridSize: 8,
    renderMode: CursiveRenderer.getBestRenderer()
});

// Place fleet on board
pirateFleet.units.forEach((unit, index) => {
    const x = index % 8;
    const y = Math.floor(index / 8);
    board.placeUnit(unit, x, y);
});

// Render terminal view
console.log(board.renderTerminalBoard());

// Progressive enhancement
pirateFleet.units.forEach(unit => {
    unit.loadHigherQuality('voxel').then(() => {
        console.log(`Upgraded ${unit.id} to voxel rendering`);
    });
});
*/