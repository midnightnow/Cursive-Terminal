// 🎯 Adaptive Unit System - Context-Aware Rendering
// Units adapt from simple icons to full 3D based on viewport and device

class AdaptiveUnit {
    constructor(unitData) {
        this.id = unitData.id;
        this.type = unitData.type;
        this.mathRepresentation = unitData.math || this.generateMath();
        
        // Context-aware rendering states
        this.renderStates = {
            // Minimal: Just an icon in text
            icon: {
                size: '16px',
                representation: unitData.icon || '◆',
                interactive: false
            },
            
            // Browser small window: Nice flat icon
            flatIcon: {
                size: '32px',
                svg: unitData.svgIcon,
                hover: true,
                tooltip: true
            },
            
            // Browser large window: Optional 3D preview
            preview3D: {
                size: '128px',
                model: 'lowpoly',
                autoRotate: true,
                clickFor3D: true
            },
            
            // Full 3D mode: Interactive model
            full3D: {
                model: 'detailed',
                controls: ['rotate', 'zoom', 'inspect'],
                lighting: 'dynamic',
                shadows: true
            },
            
            // VR/AR mode: Full interaction
            immersive: {
                model: 'photoreal',
                physics: true,
                grab: true,
                menu: 'spatial',
                voiceCommands: true
            }
        };
        
        this.currentState = this.detectOptimalState();
        this.mathEngine = new MathRepresentation(this);
    }
    
    // Detect optimal rendering based on context
    detectOptimalState() {
        const context = {
            viewport: this.getViewportSize(),
            device: this.getDeviceType(),
            performance: this.getPerformanceLevel(),
            userPreference: this.getUserPreference()
        };
        
        // In terminal or tiny window
        if (context.device === 'terminal' || context.viewport.width < 400) {
            return 'icon';
        }
        
        // Small browser window
        if (context.viewport.width < 800) {
            return 'flatIcon';
        }
        
        // Large browser window with good performance
        if (context.viewport.width >= 800 && context.performance > 60) {
            return 'preview3D';
        }
        
        // User clicked "View in 3D" or fullscreen
        if (context.userPreference === '3d' || context.viewport.fullscreen) {
            return 'full3D';
        }
        
        // VR/AR headset detected
        if (context.device === 'xr') {
            return 'immersive';
        }
        
        return 'flatIcon';
    }
    
    // Mathematical representation for code logic
    generateMath() {
        const mathTemplates = {
            'function': {
                symbol: 'ƒ',
                latex: '\\mathcal{f}: X \\rightarrow Y',
                graph: 'directed_edge',
                properties: ['input', 'output', 'complexity']
            },
            'class': {
                symbol: '𝒞',
                latex: '\\mathbb{C} = \\{M, P\\}',
                graph: 'node_cluster',
                properties: ['methods', 'properties', 'inheritance']
            },
            'module': {
                symbol: 'ℳ',
                latex: '\\mathcal{M} \\subseteq \\mathcal{S}',
                graph: 'subgraph',
                properties: ['exports', 'imports', 'dependencies']
            },
            'fleet': {
                symbol: '𝔽',
                latex: '\\mathbb{F} = \\bigcup_{i=1}^{n} U_i',
                graph: 'union_set',
                properties: ['units', 'formation', 'strength']
            }
        };
        
        return mathTemplates[this.type] || mathTemplates['function'];
    }
    
    // Render based on current context
    render(container) {
        const renderer = this.getRenderer(this.currentState);
        return renderer.render(container);
    }
    
    getRenderer(state) {
        const renderers = {
            icon: new IconRenderer(this),
            flatIcon: new FlatIconRenderer(this),
            preview3D: new Preview3DRenderer(this),
            full3D: new Full3DRenderer(this),
            immersive: new ImmersiveRenderer(this)
        };
        
        return renderers[state] || renderers.icon;
    }
    
    // Handle viewport changes
    onViewportChange(newSize) {
        const oldState = this.currentState;
        this.currentState = this.detectOptimalState();
        
        if (oldState !== this.currentState) {
            this.transitionToState(this.currentState);
        }
    }
    
    // Smooth transitions between states
    async transitionToState(newState) {
        const transitions = {
            'icon_to_flatIcon': this.growToFlatIcon,
            'flatIcon_to_preview3D': this.expandTo3D,
            'preview3D_to_full3D': this.enterFull3D,
            'full3D_to_immersive': this.enterImmersive
        };
        
        const transitionKey = `${this.currentState}_to_${newState}`;
        const transition = transitions[transitionKey];
        
        if (transition) {
            await transition.call(this);
        } else {
            // Direct transition
            this.currentState = newState;
            this.render();
        }
    }
    
    // User interaction options based on context
    getContextualMenu() {
        const menus = {
            icon: ['copy', 'info'],
            flatIcon: ['copy', 'info', 'view3d'],
            preview3D: ['rotate', 'fullscreen', 'inspect'],
            full3D: ['materials', 'animations', 'export'],
            immersive: ['grab', 'scale', 'duplicate', 'physics']
        };
        
        return menus[this.currentState] || [];
    }
}

// Mathematical representation engine
class MathRepresentation {
    constructor(unit) {
        this.unit = unit;
        this.math = unit.mathRepresentation;
    }
    
    // Render as LaTeX
    toLatex() {
        return this.math.latex;
    }
    
    // Render as graph node
    toGraph() {
        return {
            id: this.unit.id,
            type: this.math.graph,
            properties: this.math.properties.reduce((acc, prop) => {
                acc[prop] = this.unit[prop];
                return acc;
            }, {})
        };
    }
    
    // Render as mathematical notation in terminal
    toTerminal() {
        const displays = {
            'function': `${this.math.symbol}(${this.unit.name})`,
            'class': `${this.math.symbol} ${this.unit.name}`,
            'module': `${this.math.symbol}[${this.unit.name}]`,
            'fleet': `${this.math.symbol}{${this.unit.units.length}}`
        };
        
        return displays[this.unit.type] || this.math.symbol;
    }
}

// Different renderers for different contexts
class IconRenderer {
    constructor(unit) {
        this.unit = unit;
    }
    
    render(container) {
        if (typeof container === 'string') {
            // Terminal/text context
            return this.unit.renderStates.icon.representation;
        } else {
            // HTML context
            const span = document.createElement('span');
            span.className = 'cursive-unit-icon';
            span.textContent = this.unit.renderStates.icon.representation;
            span.style.fontSize = this.unit.renderStates.icon.size;
            return span;
        }
    }
}

class FlatIconRenderer {
    constructor(unit) {
        this.unit = unit;
    }
    
    render(container) {
        const div = document.createElement('div');
        div.className = 'cursive-unit-flat';
        div.style.width = this.unit.renderStates.flatIcon.size;
        div.style.height = this.unit.renderStates.flatIcon.size;
        
        if (this.unit.renderStates.flatIcon.svg) {
            div.innerHTML = this.unit.renderStates.flatIcon.svg;
        } else {
            // Fallback to styled icon
            div.textContent = this.unit.renderStates.icon.representation;
            div.style.fontSize = '24px';
            div.style.display = 'flex';
            div.style.alignItems = 'center';
            div.style.justifyContent = 'center';
            div.style.background = 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)';
            div.style.borderRadius = '8px';
            div.style.color = 'white';
            div.style.cursor = 'pointer';
        }
        
        // Add hover tooltip
        if (this.unit.renderStates.flatIcon.tooltip) {
            div.title = `${this.unit.type}: ${this.unit.name}`;
        }
        
        // Click to view 3D option
        div.addEventListener('click', () => {
            if (window.confirm('View in 3D?')) {
                this.unit.transitionToState('preview3D');
            }
        });
        
        return div;
    }
}

class Preview3DRenderer {
    constructor(unit) {
        this.unit = unit;
        this.canvas = null;
        this.renderer = null;
        this.scene = null;
        this.camera = null;
    }
    
    render(container) {
        const wrapper = document.createElement('div');
        wrapper.className = 'cursive-unit-preview3d';
        wrapper.style.width = this.unit.renderStates.preview3D.size;
        wrapper.style.height = this.unit.renderStates.preview3D.size;
        wrapper.style.position = 'relative';
        
        // Create canvas
        this.canvas = document.createElement('canvas');
        this.canvas.width = parseInt(this.unit.renderStates.preview3D.size);
        this.canvas.height = parseInt(this.unit.renderStates.preview3D.size);
        wrapper.appendChild(this.canvas);
        
        // Initialize Three.js preview
        this.initThreeJS();
        
        // Add fullscreen button
        const fullscreenBtn = document.createElement('button');
        fullscreenBtn.className = 'fullscreen-btn';
        fullscreenBtn.textContent = '⛶';
        fullscreenBtn.style.position = 'absolute';
        fullscreenBtn.style.top = '5px';
        fullscreenBtn.style.right = '5px';
        fullscreenBtn.onclick = () => this.unit.transitionToState('full3D');
        wrapper.appendChild(fullscreenBtn);
        
        return wrapper;
    }
    
    initThreeJS() {
        // Simplified Three.js setup for preview
        this.scene = new THREE.Scene();
        this.camera = new THREE.PerspectiveCamera(
            50,
            1,
            0.1,
            1000
        );
        this.camera.position.z = 5;
        
        this.renderer = new THREE.WebGLRenderer({
            canvas: this.canvas,
            alpha: true,
            antialias: true
        });
        
        // Add simple cube placeholder
        const geometry = new THREE.BoxGeometry(1, 1, 1);
        const material = new THREE.MeshPhongMaterial({
            color: 0x667eea
        });
        const cube = new THREE.Mesh(geometry, material);
        this.scene.add(cube);
        
        // Add light
        const light = new THREE.DirectionalLight(0xffffff, 1);
        light.position.set(1, 1, 1);
        this.scene.add(light);
        
        // Auto-rotate
        const animate = () => {
            if (this.unit.renderStates.preview3D.autoRotate) {
                cube.rotation.x += 0.01;
                cube.rotation.y += 0.01;
            }
            this.renderer.render(this.scene, this.camera);
            requestAnimationFrame(animate);
        };
        animate();
    }
}

// XR/Headset specific features
class ImmersiveRenderer {
    constructor(unit) {
        this.unit = unit;
        this.xrSession = null;
    }
    
    async render(container) {
        // Check XR support
        if ('xr' in navigator) {
            const supported = await navigator.xr.isSessionSupported('immersive-vr');
            
            if (supported) {
                const button = document.createElement('button');
                button.textContent = 'Enter VR';
                button.onclick = () => this.startXR();
                return button;
            }
        }
        
        // Fallback to full 3D
        return new Full3DRenderer(this.unit).render(container);
    }
    
    async startXR() {
        try {
            this.xrSession = await navigator.xr.requestSession('immersive-vr', {
                requiredFeatures: ['hand-tracking'],
                optionalFeatures: ['bounded-floor']
            });
            
            // Set up XR rendering
            this.setupXRScene();
            
        } catch (e) {
            console.error('Failed to start XR session:', e);
        }
    }
    
    setupXRScene() {
        // In VR, units become:
        // - Grabbable with hand tracking
        // - Have spatial menus
        // - Can be scaled by pinching
        // - Have voice commands
        // - Show extended information in 3D space
        
        const xrCapabilities = {
            grab: true,
            scale: { min: 0.1, max: 10 },
            menu: {
                type: 'spatial',
                options: ['inspect', 'duplicate', 'delete', 'properties']
            },
            voice: {
                commands: [
                    'show properties',
                    'rotate unit',
                    'scale up',
                    'scale down',
                    'show connections'
                ]
            },
            physics: {
                enabled: true,
                gravity: false,
                collision: true
            }
        };
        
        // Apply XR-specific behaviors
        this.unit.xrMode = xrCapabilities;
    }
}

// Responsive layout system
class CursiveResponsiveGrid {
    constructor(units) {
        this.units = units;
        this.layout = this.detectLayout();
        
        // Watch for changes
        this.observeViewport();
    }
    
    detectLayout() {
        const width = window.innerWidth;
        
        if (width < 600) {
            return 'list';      // Simple list of icons
        } else if (width < 1200) {
            return 'grid';      // 2D grid of flat icons
        } else if (width < 1800) {
            return 'board';     // Board game view with optional 3D
        } else {
            return 'immersive'; // Full 3D scene
        }
    }
    
    observeViewport() {
        // Debounced resize handler
        let resizeTimer;
        window.addEventListener('resize', () => {
            clearTimeout(resizeTimer);
            resizeTimer = setTimeout(() => {
                const newLayout = this.detectLayout();
                if (newLayout !== this.layout) {
                    this.layout = newLayout;
                    this.reflow();
                }
            }, 250);
        });
    }
    
    reflow() {
        // Transition all units to appropriate state
        this.units.forEach(unit => {
            unit.onViewportChange({
                width: window.innerWidth,
                height: window.innerHeight,
                layout: this.layout
            });
        });
    }
}

// Export system
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        AdaptiveUnit,
        MathRepresentation,
        CursiveResponsiveGrid
    };
}