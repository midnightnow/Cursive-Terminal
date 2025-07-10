// 🥽 XR Terminal Core - Spatial Computing Interface

class XRTerminal {
    constructor() {
        this.session = null;
        this.space = null;
        this.renderer = null;
        this.scene = null;
        
        // XR-specific features
        this.handTracking = new HandTrackingSystem();
        this.voiceCommands = new VoiceCommandSystem();
        this.spatialUI = new SpatialUISystem();
        this.haptics = new HapticFeedback();
        
        // Terminal state
        this.terminals = [];
        this.activeTerminal = null;
        this.workspace = new SpatialWorkspace();
        
        this.init();
    }
    
    async init() {
        // Check XR support
        if ('xr' in navigator) {
            const supported = await navigator.xr.isSessionSupported('immersive-vr');
            if (supported) {
                this.setupXRButton();
            }
        }
    }
    
    async enterXR() {
        try {
            // Request XR session with hand tracking
            this.session = await navigator.xr.requestSession('immersive-vr', {
                requiredFeatures: ['hand-tracking', 'local-floor'],
                optionalFeatures: ['bounded-floor', 'layers']
            });
            
            // Setup XR rendering
            await this.setupXRRendering();
            
            // Initialize spatial features
            this.initializeSpatialTerminal();
            
            // Start render loop
            this.session.requestAnimationFrame(this.onXRFrame.bind(this));
            
        } catch (error) {
            console.error('Failed to enter XR:', error);
        }
    }
    
    initializeSpatialTerminal() {
        // Create default curved terminal
        const mainTerminal = new CurvedTerminal({
            radius: 2.0,  // 2 meters away
            width: 1.5,   // 1.5 meters wide
            height: 1.0,  // 1 meter tall
            curvature: 30 // 30 degree curve
        });
        
        mainTerminal.position.set(0, 1.5, -2);
        this.terminals.push(mainTerminal);
        this.activeTerminal = mainTerminal;
        
        // Setup hand tracking gestures
        this.setupGestures();
        
        // Setup voice commands
        this.setupVoiceCommands();
        
        // Create spatial UI
        this.createSpatialUI();
    }
    
    setupGestures() {
        // Pinch to select
        this.handTracking.registerGesture('pinch', (hand, position) => {
            this.selectAtPosition(position);
        });
        
        // Grab to move terminal
        this.handTracking.registerGesture('grab', (hand, position) => {
            if (this.activeTerminal) {
                this.activeTerminal.startDragging(hand);
            }
        });
        
        // Point to place cursor
        this.handTracking.registerGesture('point', (hand, ray) => {
            const intersection = this.getTerminalIntersection(ray);
            if (intersection) {
                this.activeTerminal.setCursorPosition(intersection.point);
            }
        });
        
        // Spread to scale
        this.handTracking.registerGesture('spread', (scale) => {
            if (this.activeTerminal) {
                this.activeTerminal.scale(scale);
            }
        });
        
        // Palm up for command palette
        this.handTracking.registerGesture('palm_up', () => {
            this.spatialUI.showCommandPalette();
        });
    }
    
    setupVoiceCommands() {
        const commands = {
            // Navigation
            'go to *file': (file) => this.navigateToFile(file),
            'show *module': (module) => this.showModule(module),
            
            // Terminal management
            'new terminal': () => this.createNewTerminal(),
            'close terminal': () => this.closeActiveTerminal(),
            'terminal *position': (position) => this.moveTerminal(position),
            
            // Themes
            'theme *name': (name) => this.applyTheme(name),
            'lights *state': (state) => this.setLighting(state),
            
            // Debugging
            'debug *function': (func) => this.startSpatialDebug(func),
            'show variables': () => this.showVariableOrbs(),
            'trace execution': () => this.show3DStackTrace(),
            
            // AI assistance
            'summon assistant': () => this.summonAIAssistant(),
            'explain this': () => this.explainCode(),
            
            // Workspace
            'save workspace': () => this.workspace.save(),
            'privacy mode': () => this.enablePrivacyMode()
        };
        
        this.voiceCommands.registerCommands(commands);
    }
}

// Curved terminal for optimal XR viewing
class CurvedTerminal {
    constructor(options) {
        this.radius = options.radius;
        this.width = options.width;
        this.height = options.height;
        this.curvature = options.curvature;
        
        this.mesh = this.createCurvedMesh();
        this.texture = this.createTerminalTexture();
        this.cursor = new SpatialCursor();
        
        // Terminal content
        this.lines = [];
        this.currentLine = 0;
        this.fontSize = this.calculateOptimalFontSize();
    }
    
    createCurvedMesh() {
        // Create curved geometry for better readability
        const geometry = new THREE.CylinderGeometry(
            this.radius,
            this.radius,
            this.height,
            64,
            1,
            true,
            0,
            Math.PI * this.curvature / 180
        );
        
        // Flip normals for interior viewing
        geometry.scale(-1, 1, 1);
        
        const material = new THREE.MeshBasicMaterial({
            map: this.texture,
            side: THREE.DoubleSide,
            transparent: true,
            opacity: 0.95
        });
        
        return new THREE.Mesh(geometry, material);
    }
    
    createTerminalTexture() {
        const canvas = document.createElement('canvas');
        canvas.width = 2048;
        canvas.height = 1024;
        
        const ctx = canvas.getContext('2d');
        ctx.fillStyle = '#0a0a0a';
        ctx.fillRect(0, 0, canvas.width, canvas.height);
        
        // XR-optimized font settings
        ctx.font = `${this.fontSize}px 'Victor Mono XR', monospace`;
        ctx.fillStyle = '#e0e0e0';
        ctx.textBaseline = 'top';
        
        const texture = new THREE.CanvasTexture(canvas);
        texture.needsUpdate = true;
        
        return texture;
    }
    
    calculateOptimalFontSize() {
        // Adjust font size based on headset and distance
        const baseFontSize = 32;
        const distanceFactor = this.radius / 2.0;
        const headsetFactor = this.getHeadsetFactor();
        
        return Math.round(baseFontSize * distanceFactor * headsetFactor);
    }
    
    getHeadsetFactor() {
        // Adjust for different headset characteristics
        const userAgent = navigator.userAgent.toLowerCase();
        
        if (userAgent.includes('quest')) {
            return 1.2;  // Quest needs larger text
        } else if (userAgent.includes('visionos')) {
            return 1.0;  // Vision Pro has excellent clarity
        } else if (userAgent.includes('pico')) {
            return 1.3;  // Pico needs even larger
        }
        
        return 1.1;  // Default
    }
    
    updateContent(lines) {
        const canvas = this.texture.image;
        const ctx = canvas.getContext('2d');
        
        // Clear canvas
        ctx.fillStyle = '#0a0a0a';
        ctx.fillRect(0, 0, canvas.width, canvas.height);
        
        // Render lines with XR optimizations
        ctx.font = `${this.fontSize}px 'Victor Mono XR', monospace`;
        ctx.fillStyle = '#e0e0e0';
        
        const lineHeight = this.fontSize * 1.6;
        const startY = 50;
        
        lines.forEach((line, index) => {
            // Apply subtle glow for better readability
            ctx.shadowBlur = 2;
            ctx.shadowColor = '#ffffff30';
            
            ctx.fillText(line, 50, startY + index * lineHeight);
        });
        
        this.texture.needsUpdate = true;
    }
}

// Spatial UI components
class SpatialUISystem {
    constructor() {
        this.components = new Map();
        this.activeComponent = null;
    }
    
    showCommandPalette() {
        if (this.components.has('commandPalette')) {
            this.components.get('commandPalette').show();
            return;
        }
        
        const palette = new RadialMenu({
            radius: 0.5,
            items: [
                { icon: '📁', label: 'Files', action: 'showFiles' },
                { icon: '🔍', label: 'Search', action: 'search' },
                { icon: '⚙️', label: 'Settings', action: 'settings' },
                { icon: '🎨', label: 'Themes', action: 'themes' },
                { icon: '🐛', label: 'Debug', action: 'debug' },
                { icon: '🤖', label: 'AI', action: 'ai' }
            ]
        });
        
        palette.position.set(0, 1.5, -1);
        this.components.set('commandPalette', palette);
        palette.show();
    }
    
    create3DFileExplorer() {
        const explorer = new SpatialFileExplorer({
            root: this.workspace.currentProject,
            layout: 'tree',  // or 'galaxy', 'grid'
            scale: 0.1
        });
        
        explorer.on('fileSelected', (file) => {
            this.openFileInTerminal(file);
        });
        
        return explorer;
    }
}

// Hand tracking system
class HandTrackingSystem {
    constructor() {
        this.hands = new Map();
        this.gestures = new Map();
        this.gestureRecognizer = new GestureRecognizer();
    }
    
    update(frame, referenceSpace) {
        // Process hand tracking data
        for (const inputSource of frame.session.inputSources) {
            if (inputSource.hand) {
                this.updateHand(inputSource, frame, referenceSpace);
            }
        }
        
        // Recognize gestures
        this.recognizeGestures();
    }
    
    updateHand(inputSource, frame, referenceSpace) {
        const hand = inputSource.hand;
        const handedness = inputSource.handedness;
        
        if (!this.hands.has(handedness)) {
            this.hands.set(handedness, new TrackedHand(handedness));
        }
        
        const trackedHand = this.hands.get(handedness);
        
        // Update joint positions
        for (const joint of hand.values()) {
            const jointPose = frame.getJointPose(joint, referenceSpace);
            if (jointPose) {
                trackedHand.updateJoint(joint.jointName, jointPose);
            }
        }
    }
    
    registerGesture(name, callback) {
        this.gestures.set(name, callback);
    }
    
    recognizeGestures() {
        for (const [handedness, hand] of this.hands) {
            const gesture = this.gestureRecognizer.recognize(hand);
            
            if (gesture && this.gestures.has(gesture.type)) {
                this.gestures.get(gesture.type)(hand, gesture.data);
            }
        }
    }
}

// Gesture recognizer
class GestureRecognizer {
    recognize(hand) {
        // Pinch detection
        if (this.isPinching(hand)) {
            return {
                type: 'pinch',
                data: hand.getJointPosition('index-finger-tip')
            };
        }
        
        // Grab detection
        if (this.isGrabbing(hand)) {
            return {
                type: 'grab',
                data: hand.getJointPosition('wrist')
            };
        }
        
        // Point detection
        if (this.isPointing(hand)) {
            return {
                type: 'point',
                data: this.getPointingRay(hand)
            };
        }
        
        // Palm up detection
        if (this.isPalmUp(hand)) {
            return {
                type: 'palm_up',
                data: hand.getJointPosition('wrist')
            };
        }
        
        return null;
    }
    
    isPinching(hand) {
        const thumbTip = hand.getJointPosition('thumb-tip');
        const indexTip = hand.getJointPosition('index-finger-tip');
        
        if (thumbTip && indexTip) {
            const distance = thumbTip.distanceTo(indexTip);
            return distance < 0.02;  // 2cm threshold
        }
        
        return false;
    }
    
    isGrabbing(hand) {
        // Check if all fingers are curled
        const fingersCurled = ['index', 'middle', 'ring', 'pinky'].every(finger => {
            const mcp = hand.getJointPosition(`${finger}-finger-metacarpal`);
            const tip = hand.getJointPosition(`${finger}-finger-tip`);
            
            if (mcp && tip) {
                const distance = mcp.distanceTo(tip);
                return distance < 0.05;  // 5cm threshold
            }
            return false;
        });
        
        return fingersCurled;
    }
    
    isPointing(hand) {
        const indexExtended = this.isFingerExtended(hand, 'index');
        const othersNotExtended = ['middle', 'ring', 'pinky'].every(finger => 
            !this.isFingerExtended(hand, finger)
        );
        
        return indexExtended && othersNotExtended;
    }
}

// Spatial debugging visualizer
class SpatialDebugger {
    constructor(scene) {
        this.scene = scene;
        this.traces = new Map();
        this.variables = new Map();
    }
    
    visualizeExecution(function, args) {
        // Create 3D representation of code execution
        const trace = new ExecutionTrace(function);
        
        // Each function call becomes a node in 3D space
        const nodes = [];
        const connections = [];
        
        // Instrument function to track execution
        const instrumented = this.instrumentFunction(function, (event) => {
            if (event.type === 'call') {
                const node = new TraceNode(event);
                node.position.set(
                    nodes.length * 0.5,
                    event.depth * 0.3,
                    0
                );
                nodes.push(node);
                this.scene.add(node.mesh);
                
                if (event.caller) {
                    const connection = new TraceConnection(
                        event.caller,
                        node
                    );
                    connections.push(connection);
                    this.scene.add(connection.line);
                }
            }
        });
        
        // Execute and visualize
        instrumented(...args);
        
        return trace;
    }
    
    showVariableOrbs() {
        // Create floating orbs for each variable in scope
        const variables = this.getCurrentScopeVariables();
        
        variables.forEach((value, name) => {
            const orb = new VariableOrb(name, value);
            
            // Position in a circle around user
            const angle = (this.variables.size / variables.size) * Math.PI * 2;
            orb.position.set(
                Math.cos(angle) * 1.5,
                1.5,
                Math.sin(angle) * 1.5
            );
            
            // Make grabbable
            orb.enableInteraction();
            
            this.variables.set(name, orb);
            this.scene.add(orb.mesh);
        });
    }
}

// XR-optimized themes
class XRThemeManager {
    constructor() {
        this.themes = {
            'cyberdeck': new CyberdeckTheme(),
            'spacestation': new SpaceStationTheme(),
            'wizardtower': new WizardTowerTheme(),
            'underwater': new UnderwaterTheme()
        };
        
        this.currentTheme = null;
        this.environment = new XREnvironment();
    }
    
    applyTheme(themeName) {
        const theme = this.themes[themeName];
        if (theme) {
            // Transition to new theme
            this.transitionToTheme(theme);
        }
    }
    
    transitionToTheme(theme) {
        // Fade out current environment
        if (this.currentTheme) {
            this.currentTheme.fadeOut(1000);
        }
        
        // Load new environment
        theme.load().then(() => {
            // Update skybox
            this.environment.setSkybox(theme.skybox);
            
            // Update lighting
            this.environment.setLighting(theme.lighting);
            
            // Add environmental effects
            theme.effects.forEach(effect => {
                this.environment.addEffect(effect);
            });
            
            // Update terminal appearance
            this.updateTerminalStyle(theme.terminalStyle);
            
            // Start ambient audio
            theme.audio.play();
            
            this.currentTheme = theme;
        });
    }
}

// Export for use
export {
    XRTerminal,
    CurvedTerminal,
    SpatialUISystem,
    HandTrackingSystem,
    SpatialDebugger,
    XRThemeManager
};