// 🎭 Immersive Persona System - Fleets, Hordes & Guilds in Spatial Computing

class ImmersivePersonaSystem {
    constructor() {
        this.personas = new Map();
        this.fleets = new Map();
        this.currentPersona = null;
        this.toneLevel = 50; // 0-100 scale
        this.immersionLevel = 0; // 0: flat, 100: full spatial
        
        // Audio engine for spatial soundscapes
        this.audioEngine = new SpatialAudioEngine();
        
        // Visual effect system
        this.visualEngine = new VisualEffectEngine();
        
        // Natural language processor
        this.nlp = new NaturalLanguageProcessor();
        
        this.initializePersonas();
    }
    
    initializePersonas() {
        // Define persona packs with full sensory profiles
        const personaPacks = {
            'pirate': {
                flag: '🏴‍☠️',
                name: 'Pirate Crew',
                visual: {
                    skin: 'weather-beaten-parchment',
                    icons: ['skull-crossbones', 'ship-wheel', 'treasure'],
                    colors: ['#8B4513', '#FFD700', '#1C1C1C'],
                    shaders: 'ocean-worn'
                },
                lexicon: {
                    greetings: ["Ahoy!", "Avast!", "Arr!"],
                    affirmatives: ["Aye!", "Right ye are!", "That be true!"],
                    negatives: ["Nay!", "Belay that!", "Not on yer life!"],
                    commands: {
                        'navigate': "Set sail for {target}!",
                        'execute': "Fire the cannons!",
                        'debug': "Check the rigging for rats!"
                    }
                },
                audio: {
                    ambient: ['waves', 'gulls', 'creaking-wood'],
                    actions: {
                        'spawn': 'cannon-fire.wav',
                        'dismiss': 'anchor-drop.wav',
                        'error': 'storm-warning.wav'
                    },
                    spatial: true,
                    volume: 0.7
                },
                fleetUnits: [
                    { type: 'flagship', model: 'galleon', count: 1 },
                    { type: 'frigate', model: 'frigate', count: 3 },
                    { type: 'crew', model: 'pirate-crew', count: 12 }
                ]
            },
            
            'vampire': {
                flag: '🧛',
                name: 'Vampire Horde',
                visual: {
                    skin: 'black-velvet',
                    icons: ['bat', 'coffin', 'blood-drop'],
                    colors: ['#0B0A0C', '#8B0000', '#4B0082'],
                    shaders: 'gothic-shadow'
                },
                lexicon: {
                    greetings: ["Welcome to eternal night...", "Greetings, mortal..."],
                    affirmatives: ["Indeed...", "It shall be done...", "Yesss..."],
                    negatives: ["Never!", "Forbidden!", "The darkness refuses..."],
                    commands: {
                        'navigate': "Drift through shadows to {target}...",
                        'execute': "Let the blood flow...",
                        'debug': "Hunt for the corruption..."
                    }
                },
                audio: {
                    ambient: ['wind-howl', 'heartbeat', 'whispers'],
                    actions: {
                        'spawn': 'bat-swarm.wav',
                        'dismiss': 'coffin-close.wav',
                        'error': 'vampire-hiss.wav'
                    },
                    spatial: true,
                    volume: 0.5
                },
                fleetUnits: [
                    { type: 'castle', model: 'gothic-castle', count: 1 },
                    { type: 'lord', model: 'vampire-lord', count: 1 },
                    { type: 'spawn', model: 'vampire-spawn', count: 8 }
                ]
            },
            
            'clockwork': {
                flag: '⚙️',
                name: 'Clockwork Legion',
                visual: {
                    skin: 'brass-copper',
                    icons: ['gear', 'steam', 'wrench'],
                    colors: ['#B87333', '#4682B4', '#2F4F4F'],
                    shaders: 'steampunk-metal'
                },
                lexicon: {
                    greetings: ["Good day, Engineer.", "Greetings, Artificer."],
                    affirmatives: ["Precisely.", "Calculations confirmed.", "Affirmative."],
                    negatives: ["Negative.", "Mechanism failure.", "Impossible."],
                    commands: {
                        'navigate': "Engage locomotion to {target}.",
                        'execute': "Initialize primary sequence.",
                        'debug': "Run diagnostic protocols."
                    }
                },
                audio: {
                    ambient: ['tick-tock', 'steam-hiss', 'gear-turn'],
                    actions: {
                        'spawn': 'steam-release.wav',
                        'dismiss': 'power-down.wav',
                        'error': 'gear-grind.wav'
                    },
                    spatial: true,
                    volume: 0.6
                },
                fleetUnits: [
                    { type: 'factory', model: 'clockwork-factory', count: 1 },
                    { type: 'automaton', model: 'brass-automaton', count: 6 },
                    { type: 'engineer', model: 'clockwork-engineer', count: 2 }
                ]
            },
            
            'wizard': {
                flag: '🧙‍♂️',
                name: 'Arcane Guild',
                visual: {
                    skin: 'nebula-mystic',
                    icons: ['crystal', 'spellbook', 'wand'],
                    colors: ['#4B0082', '#FF00FF', '#00CED1'],
                    shaders: 'magical-aurora'
                },
                lexicon: {
                    greetings: ["Greetings, apprentice.", "Welcome to the arcane."],
                    affirmatives: ["By my beard!", "The stars align!", "Indeed!"],
                    negatives: ["The magic refuses!", "Impossible!", "The void says no!"],
                    commands: {
                        'navigate': "Teleport to the realm of {target}!",
                        'execute': "Cast the spell of execution!",
                        'debug': "Divine the source of corruption!"
                    }
                },
                audio: {
                    ambient: ['chimes', 'whispered-spells', 'crystal-hum'],
                    actions: {
                        'spawn': 'spell-cast.wav',
                        'dismiss': 'portal-close.wav',
                        'error': 'spell-fail.wav'
                    },
                    spatial: true,
                    volume: 0.8
                },
                fleetUnits: [
                    { type: 'tower', model: 'wizard-tower', count: 1 },
                    { type: 'wizard', model: 'arcane-master', count: 1 },
                    { type: 'familiar', model: 'magical-familiar', count: 5 }
                ]
            }
        };
        
        // Initialize all personas
        Object.entries(personaPacks).forEach(([key, data]) => {
            this.personas.set(key, new Persona(key, data));
        });
    }
    
    // Natural language commands
    processCommand(command) {
        const patterns = {
            // Tone control
            'dial {persona} {level}%': (matches) => {
                this.setPersonaTone(matches.persona, parseInt(matches.level));
            },
            'speak plainly': () => {
                this.setPersonaTone(this.currentPersona?.id || 'neutral', 0);
            },
            'unleash full {persona} prose': (matches) => {
                this.switchPersona(matches.persona);
                this.setPersonaTone(matches.persona, 100);
            },
            
            // Visual control
            'dial visuals {level}%': (matches) => {
                this.setImmersionLevel(parseInt(matches.level));
            },
            'fullscreen on': () => {
                this.enterCinematicMode();
            },
            'fullscreen off': () => {
                this.exitCinematicMode();
            },
            
            // Fleet management
            'summon {persona} {type}': (matches) => {
                this.summonFleet(matches.persona, matches.type);
            },
            'spawn fleet n={count} flag={persona}': (matches) => {
                this.spawnFleet(matches.persona, parseInt(matches.count));
            },
            'dismiss {type}': (matches) => {
                this.dismissFleet(matches.type);
            },
            
            // Immersion control
            '/enter-immersion': () => {
                this.enterFullImmersion();
            },
            '/exit-immersion': () => {
                this.exitFullImmersion();
            }
        };
        
        return this.nlp.match(command, patterns);
    }
    
    // Persona and tone management
    switchPersona(personaId) {
        const persona = this.personas.get(personaId);
        if (persona) {
            // Fade out current persona
            if (this.currentPersona) {
                this.currentPersona.fadeOut();
            }
            
            // Switch persona
            this.currentPersona = persona;
            
            // Apply visual theme
            this.visualEngine.applyTheme(persona.visual);
            
            // Start ambient audio
            this.audioEngine.startAmbient(persona.audio.ambient);
            
            // Update UI elements
            this.updateUIForPersona(persona);
            
            // Announce switch
            this.announce(persona.getGreeting());
        }
    }
    
    setPersonaTone(personaId, level) {
        this.toneLevel = Math.max(0, Math.min(100, level));
        
        if (this.currentPersona?.id === personaId) {
            this.currentPersona.setToneLevel(this.toneLevel);
            
            // Adjust lexicon intensity
            this.updateLexiconIntensity();
            
            // Announce change
            const message = this.toneLevel === 0 
                ? "Speaking plainly now."
                : `${personaId} tone at ${this.toneLevel}%`;
            this.announce(message);
        }
    }
    
    // Visual immersion control
    setImmersionLevel(level) {
        this.immersionLevel = Math.max(0, Math.min(100, level));
        
        // Apply visual effects based on level
        this.visualEngine.setEffects({
            blur: (100 - this.immersionLevel) * 0.01,
            particles: this.immersionLevel > 50,
            shaders: this.immersionLevel > 70,
            fullscreen: this.immersionLevel === 100
        });
        
        // Adjust audio
        this.audioEngine.setMasterVolume(this.immersionLevel / 100);
        
        // Update UI opacity
        this.updateUIOpacity(this.immersionLevel);
    }
    
    // Fleet spawning system
    async summonFleet(personaId, fleetType = 'default') {
        const persona = this.personas.get(personaId);
        if (!persona) return;
        
        // Create fleet identifier
        const fleetId = `${personaId}-${fleetType}-${Date.now()}`;
        
        // Create fleet with spatial positioning
        const fleet = new PersonaFleet(fleetId, persona, {
            formation: 'wedge',
            spacing: 2.0,
            centerPosition: this.getSpawnPosition()
        });
        
        // Spawn units with animations
        for (const unitSpec of persona.fleetUnits) {
            for (let i = 0; i < unitSpec.count; i++) {
                const unit = await this.createFleetUnit(unitSpec, persona);
                fleet.addUnit(unit);
                
                // Stagger spawn animation
                setTimeout(() => {
                    unit.spawn();
                    this.audioEngine.play3D(
                        persona.audio.actions.spawn,
                        unit.position
                    );
                }, i * 100);
            }
        }
        
        this.fleets.set(fleetId, fleet);
        
        // Announce summoning
        const announcement = persona.getLexicon('summon', { 
            count: fleet.units.length,
            type: fleetType 
        });
        this.announce(announcement);
        
        return fleet;
    }
    
    async createFleetUnit(spec, persona) {
        const unit = new FleetUnit({
            type: spec.type,
            model: spec.model,
            persona: persona,
            renderLevel: this.getOptimalRenderLevel()
        });
        
        // Load appropriate model based on context
        if (this.isXRSession()) {
            await unit.loadModel('photoreal');
        } else if (this.immersionLevel > 70) {
            await unit.loadModel('lowpoly');
        } else if (this.immersionLevel > 30) {
            await unit.loadModel('voxel');
        } else {
            await unit.loadModel('icon');
        }
        
        return unit;
    }
    
    // Full immersion mode
    async enterFullImmersion() {
        // Fade to black
        await this.visualEngine.fadeToBlack(1000);
        
        // Enter fullscreen
        await this.enterCinematicMode();
        
        // Load 3D environment
        await this.load3DEnvironment();
        
        // Maximum effects
        this.setImmersionLevel(100);
        
        // Spawn initial fleet if persona active
        if (this.currentPersona) {
            await this.summonFleet(this.currentPersona.id, 'default');
        }
        
        // Fade in to immersive view
        await this.visualEngine.fadeFromBlack(2000);
        
        // Start spatial features
        this.enableSpatialFeatures();
    }
    
    async load3DEnvironment() {
        if (!this.currentPersona) return;
        
        const environment = {
            'pirate': {
                skybox: 'ocean-sunset',
                terrain: 'ship-deck',
                props: ['barrels', 'ropes', 'cannons'],
                lighting: 'golden-hour'
            },
            'vampire': {
                skybox: 'blood-moon',
                terrain: 'castle-courtyard',
                props: ['tombstones', 'gargoyles', 'torches'],
                lighting: 'moonlight'
            },
            'clockwork': {
                skybox: 'brass-sky',
                terrain: 'factory-floor',
                props: ['gears', 'pipes', 'steam-vents'],
                lighting: 'industrial'
            },
            'wizard': {
                skybox: 'nebula',
                terrain: 'floating-platform',
                props: ['crystals', 'books', 'orbs'],
                lighting: 'magical'
            }
        };
        
        const env = environment[this.currentPersona.id];
        if (env) {
            await this.visualEngine.loadEnvironment(env);
        }
    }
    
    // Document cloud visualization
    create3DDocumentCloud() {
        const cloud = new DocumentCloud({
            documents: this.workspace.getAllDocuments(),
            layout: 'nebula', // or 'grid', 'tree', 'galaxy'
            interactive: true
        });
        
        // Make documents grabbable in XR
        if (this.isXRSession()) {
            cloud.enableXRInteraction();
        }
        
        // Position based on immersion level
        cloud.position.set(0, 2, -5);
        cloud.scale.setScalar(this.immersionLevel / 100);
        
        return cloud;
    }
}

// Fleet unit class with multi-resolution support
class FleetUnit {
    constructor(config) {
        this.type = config.type;
        this.persona = config.persona;
        this.position = new THREE.Vector3();
        this.rotation = new THREE.Euler();
        this.scale = 1;
        
        // Multi-res representations (from adaptive-unit-system.js)
        this.representations = {
            icon: this.getIcon(),
            voxel: null,
            lowpoly: null,
            photoreal: null
        };
        
        this.currentRepresentation = 'icon';
        this.mesh = null;
    }
    
    getIcon() {
        const icons = {
            'flagship': '⛵',
            'frigate': '⛵',
            'crew': '👥',
            'castle': '🏰',
            'lord': '🧛',
            'spawn': '🦇',
            'factory': '🏭',
            'automaton': '🤖',
            'engineer': '👷',
            'tower': '🗼',
            'wizard': '🧙',
            'familiar': '🐉'
        };
        
        return icons[this.type] || '❓';
    }
    
    async loadModel(level) {
        // Progressive loading based on capability
        switch(level) {
            case 'icon':
                this.createIconMesh();
                break;
            case 'voxel':
                await this.loadVoxelModel();
                break;
            case 'lowpoly':
                await this.loadLowPolyModel();
                break;
            case 'photoreal':
                await this.loadPhotorealModel();
                break;
        }
        
        this.currentRepresentation = level;
    }
    
    createIconMesh() {
        // Create simple billboard with emoji
        const canvas = document.createElement('canvas');
        canvas.width = canvas.height = 256;
        const ctx = canvas.getContext('2d');
        
        // Background matching persona theme
        ctx.fillStyle = this.persona.visual.colors[0];
        ctx.fillRect(0, 0, 256, 256);
        
        // Icon
        ctx.font = '128px Arial';
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.fillText(this.representations.icon, 128, 128);
        
        const texture = new THREE.CanvasTexture(canvas);
        const material = new THREE.SpriteMaterial({ map: texture });
        this.mesh = new THREE.Sprite(material);
    }
    
    spawn() {
        // Spawn animation based on persona
        const animations = {
            'pirate': this.spawnPirate.bind(this),
            'vampire': this.spawnVampire.bind(this),
            'clockwork': this.spawnClockwork.bind(this),
            'wizard': this.spawnWizard.bind(this)
        };
        
        const animate = animations[this.persona.id] || this.spawnDefault.bind(this);
        animate();
    }
    
    spawnPirate() {
        // Rise from the waves
        this.position.y = -2;
        new TWEEN.Tween(this.position)
            .to({ y: 0 }, 1000)
            .easing(TWEEN.Easing.Elastic.Out)
            .start();
            
        // Bobbing motion
        this.startBobbing();
    }
    
    spawnVampire() {
        // Materialize from mist
        this.mesh.material.opacity = 0;
        new TWEEN.Tween(this.mesh.material)
            .to({ opacity: 1 }, 2000)
            .start();
            
        // Particle effect
        this.createMistEffect();
    }
}

// Export for integration
export {
    ImmersivePersonaSystem,
    PersonaFleet,
    FleetUnit
};