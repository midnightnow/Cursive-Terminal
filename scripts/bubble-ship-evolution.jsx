import React, { useState, useEffect, useRef } from 'react';
import { Code, FileText, Ship, Sparkles, Zap, Play, Pause, Settings, Eye } from 'lucide-react';

const BubbleShipEvolution = () => {
  const [isStreaming, setIsStreaming] = useState(false);
  const [codeEntities, setCodeEntities] = useState([]);
  const [streamSpeed, setStreamSpeed] = useState(50);
  const [showLabels, setShowLabels] = useState(true);
  const [selectedEntity, setSelectedEntity] = useState(null);
  const canvasRef = useRef(null);
  const animationRef = useRef(null);

  // Code templates with different complexities
  const codeTemplates = [
    {
      type: 'function',
      complexity: 'simple',
      code: 'const greet = () => "Ahoy!";',
      size: 30,
      color: '#4ECDC4',
      helperCount: 0
    },
    {
      type: 'component',
      complexity: 'medium',
      code: `function Button({ onClick, label }) {
  return <button onClick={onClick}>{label}</button>;
}`,
      size: 50,
      color: '#45B7D1',
      helperCount: 2
    },
    {
      type: 'module',
      complexity: 'complex',
      code: `export class NavigationSystem {
  constructor() {
    this.routes = new Map();
    this.history = [];
  }
  
  navigate(route) {
    this.history.push(route);
    return this.routes.get(route);
  }
}`,
      size: 80,
      color: '#FF6B6B',
      helperCount: 4
    },
    {
      type: 'application',
      complexity: 'flagship',
      code: `class FleetCommander {
  constructor() {
    this.ships = [];
    this.missions = new Queue();
    this.state = new StateManager();
  }
  
  deployFleet() {
    return this.ships.map(ship => ship.launch());
  }
}`,
      size: 120,
      color: '#9B59B6',
      helperCount: 8
    }
  ];

  // Entity lifecycle states
  const entityStates = {
    BUBBLE: 'bubble',
    TRANSITIONING: 'transitioning',
    SCREEN: 'screen',
    FORMING_SHIP: 'forming',
    SHIP: 'ship',
    DEPLOYED: 'deployed'
  };

  // Generate new code entity
  const generateEntity = () => {
    const template = codeTemplates[Math.floor(Math.random() * codeTemplates.length)];
    return {
      id: Date.now() + Math.random(),
      ...template,
      state: entityStates.BUBBLE,
      x: 10 + Math.random() * 20,
      y: 70 + Math.random() * 20,
      vx: 0.5 + Math.random() * 0.5,
      vy: -0.2 - Math.random() * 0.3,
      age: 0,
      rotation: 0,
      scale: 0.1,
      opacity: 0,
      helpers: []
    };
  };

  // Evolution logic
  const evolveEntity = (entity) => {
    const evolutionTimeline = {
      0: { state: entityStates.BUBBLE, scale: 1, opacity: 1 },
      50: { state: entityStates.TRANSITIONING, scale: 1.2 },
      100: { state: entityStates.SCREEN, scale: 1 },
      150: { state: entityStates.FORMING_SHIP, scale: 1.1 },
      200: { state: entityStates.SHIP, scale: 1 },
      300: { state: entityStates.DEPLOYED }
    };

    const milestone = Object.keys(evolutionTimeline)
      .reverse()
      .find(age => entity.age >= parseInt(age));

    if (milestone) {
      const evolution = evolutionTimeline[milestone];
      entity.state = evolution.state;
      if (evolution.scale) entity.scale = evolution.scale;
      if (evolution.opacity !== undefined) entity.opacity = evolution.opacity;
    }

    // Generate helpers when becoming a ship
    if (entity.state === entityStates.SHIP && entity.helpers.length === 0) {
      entity.helpers = Array.from({ length: entity.helperCount }, (_, i) => ({
        id: `${entity.id}-helper-${i}`,
        angle: (i / entity.helperCount) * Math.PI * 2,
        distance: 40 + Math.random() * 20,
        size: 10 + Math.random() * 5,
        rotation: 0
      }));
    }

    return entity;
  };

  // Animation loop
  useEffect(() => {
    let lastTime = 0;
    let spawnTimer = 0;

    const animate = (currentTime) => {
      const deltaTime = currentTime - lastTime;
      lastTime = currentTime;

      if (isStreaming) {
        spawnTimer += deltaTime;
        
        // Spawn new entities
        const spawnInterval = 3000 - (streamSpeed * 25);
        if (spawnTimer > spawnInterval) {
          setCodeEntities(prev => [...prev, generateEntity()]);
          spawnTimer = 0;
        }
      }

      // Update entities
      setCodeEntities(prev => prev.map(entity => {
        let updated = { ...entity };
        
        // Age and evolve
        updated.age += 1;
        updated = evolveEntity(updated);
        
        // Movement based on state
        switch (updated.state) {
          case entityStates.BUBBLE:
            // Floating bubble physics
            updated.x += updated.vx;
            updated.y += updated.vy;
            updated.vx += (Math.random() - 0.5) * 0.02;
            updated.rotation += 0.01;
            break;
            
          case entityStates.TRANSITIONING:
            // Slow down and prepare to flatten
            updated.vx *= 0.95;
            updated.vy *= 0.95;
            updated.rotation += 0.02;
            break;
            
          case entityStates.SCREEN:
            // Gentle floating as flat screen
            updated.y += Math.sin(updated.age * 0.02) * 0.1;
            updated.rotation = Math.sin(updated.age * 0.01) * 0.1;
            break;
            
          case entityStates.FORMING_SHIP:
            // Screen wrapping around bubble
            updated.rotation += 0.03;
            break;
            
          case entityStates.SHIP:
            // Ship movement
            updated.x += 0.5;
            updated.y += Math.sin(updated.age * 0.01) * 0.2;
            updated.rotation = Math.sin(updated.age * 0.02) * 0.05;
            
            // Update helpers
            updated.helpers = updated.helpers.map(helper => ({
              ...helper,
              rotation: helper.rotation + 0.02,
              angle: helper.angle + 0.01
            }));
            break;
            
          case entityStates.DEPLOYED:
            // Continue sailing
            updated.x += 0.8;
            updated.y += Math.sin(updated.age * 0.01) * 0.1;
            break;
        }
        
        return updated;
      }).filter(entity => entity.x < 120 && entity.age < 500));

      animationRef.current = requestAnimationFrame(animate);
    };

    animationRef.current = requestAnimationFrame(animate);

    return () => {
      if (animationRef.current) {
        cancelAnimationFrame(animationRef.current);
      }
    };
  }, [isStreaming, streamSpeed]);

  // Render entity based on state
  const renderEntity = (entity) => {
    const baseStyle = {
      position: 'absolute',
      left: `${entity.x}%`,
      top: `${entity.y}%`,
      transform: `translate(-50%, -50%) scale(${entity.scale}) rotate(${entity.rotation}rad)`,
      transition: 'all 0.3s ease-out',
      opacity: entity.opacity,
      cursor: 'pointer'
    };

    switch (entity.state) {
      case entityStates.BUBBLE:
        return (
          <div
            key={entity.id}
            style={baseStyle}
            onClick={() => setSelectedEntity(entity)}
          >
            <div
              className="rounded-full backdrop-blur-sm border-2 flex items-center justify-center animate-pulse"
              style={{
                width: `${entity.size}px`,
                height: `${entity.size}px`,
                backgroundColor: `${entity.color}20`,
                borderColor: entity.color,
                boxShadow: `0 0 ${entity.size/2}px ${entity.color}40`
              }}
            >
              <Code size={entity.size * 0.4} color={entity.color} />
            </div>
            {showLabels && (
              <div className="absolute -bottom-6 left-1/2 transform -translate-x-1/2 text-xs whitespace-nowrap">
                {entity.type}
              </div>
            )}
          </div>
        );

      case entityStates.TRANSITIONING:
        return (
          <div key={entity.id} style={baseStyle}>
            <div
              className="rounded-lg backdrop-blur-sm border-2 flex items-center justify-center"
              style={{
                width: `${entity.size * 1.5}px`,
                height: `${entity.size}px`,
                backgroundColor: `${entity.color}15`,
                borderColor: entity.color,
                boxShadow: `0 0 ${entity.size/2}px ${entity.color}50`
              }}
            >
              <Sparkles size={entity.size * 0.5} color={entity.color} />
            </div>
          </div>
        );

      case entityStates.SCREEN:
        return (
          <div key={entity.id} style={baseStyle}>
            <div
              className="rounded-md backdrop-blur-sm border-2 p-2"
              style={{
                width: `${entity.size * 2}px`,
                height: `${entity.size * 1.2}px`,
                backgroundColor: `${entity.color}10`,
                borderColor: entity.color,
                boxShadow: `0 0 15px ${entity.color}30`
              }}
            >
              <div className="text-xs font-mono text-white overflow-hidden" style={{ fontSize: `${entity.size * 0.15}px` }}>
                {entity.code.split('\n')[0]}...
              </div>
              <FileText size={entity.size * 0.3} color={entity.color} className="absolute bottom-1 right-1" />
            </div>
            {showLabels && (
              <div className="absolute -bottom-6 left-1/2 transform -translate-x-1/2 text-xs whitespace-nowrap">
                {entity.complexity} {entity.type}
              </div>
            )}
          </div>
        );

      case entityStates.FORMING_SHIP:
        return (
          <div key={entity.id} style={baseStyle}>
            <div
              className="relative rounded-lg backdrop-blur-sm border-2"
              style={{
                width: `${entity.size * 1.8}px`,
                height: `${entity.size * 1.5}px`,
                backgroundColor: `${entity.color}15`,
                borderColor: entity.color,
                boxShadow: `0 0 20px ${entity.color}40`,
                transform: `perspective(100px) rotateY(${entity.rotation * 50}deg)`
              }}
            >
              <div className="absolute inset-0 flex items-center justify-center">
                <Zap size={entity.size * 0.4} color={entity.color} className="animate-spin" />
              </div>
            </div>
          </div>
        );

      case entityStates.SHIP:
      case entityStates.DEPLOYED:
        return (
          <div key={entity.id} style={baseStyle}>
            {/* Main ship body */}
            <div
              className="relative rounded-lg backdrop-blur-sm border-2"
              style={{
                width: `${entity.size}px`,
                height: `${entity.size * 0.8}px`,
                backgroundColor: `${entity.color}20`,
                borderColor: entity.color,
                boxShadow: `0 0 25px ${entity.color}50`
              }}
            >
              <Ship size={entity.size * 0.4} color={entity.color} className="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2" />
              
              {/* Code screen sail */}
              <div
                className="absolute -top-2 left-1/2 transform -translate-x-1/2 rounded-sm border opacity-80"
                style={{
                  width: `${entity.size * 0.6}px`,
                  height: `${entity.size * 0.4}px`,
                  backgroundColor: entity.color,
                  borderColor: entity.color,
                  fontSize: `${entity.size * 0.08}px`,
                  padding: '2px'
                }}
              >
                <div className="text-white font-mono overflow-hidden">
                  {entity.type}
                </div>
              </div>
            </div>

            {/* Helper modules */}
            {entity.helpers.map(helper => {
              const helperX = Math.cos(helper.angle + helper.rotation) * helper.distance;
              const helperY = Math.sin(helper.angle + helper.rotation) * helper.distance;
              
              return (
                <div
                  key={helper.id}
                  className="absolute rounded-full"
                  style={{
                    left: `${helperX}px`,
                    top: `${helperY}px`,
                    width: `${helper.size}px`,
                    height: `${helper.size}px`,
                    backgroundColor: entity.color,
                    opacity: 0.6,
                    transform: 'translate(-50%, -50%)'
                  }}
                />
              );
            })}

            {showLabels && entity.state === entityStates.SHIP && (
              <div className="absolute -bottom-8 left-1/2 transform -translate-x-1/2 text-xs whitespace-nowrap">
                {entity.complexity} {entity.type} ship
              </div>
            )}
          </div>
        );

      default:
        return null;
    }
  };

  return (
    <div className="w-full h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900 text-white overflow-hidden relative">
      {/* Header */}
      <div className="absolute top-4 left-4 right-4 z-20 flex justify-between items-center">
        <div>
          <h1 className="text-3xl font-bold italic mb-1">🫧 Bubble → Screen → Ship Evolution</h1>
          <p className="text-sm opacity-75">Watch code evolve from bubbles to sailing vessels</p>
        </div>
        
        <div className="flex items-center space-x-4">
          <button
            onClick={() => setIsStreaming(!isStreaming)}
            className={`flex items-center space-x-2 px-6 py-3 rounded-lg transition-all ${
              isStreaming 
                ? 'bg-red-600 hover:bg-red-700 shadow-lg shadow-red-600/50' 
                : 'bg-green-600 hover:bg-green-700 shadow-lg shadow-green-600/50'
            }`}
          >
            {isStreaming ? <Pause size={20} /> : <Play size={20} />}
            <span className="font-semibold">{isStreaming ? 'Pause Stream' : 'Start Stream'}</span>
          </button>
        </div>
      </div>

      {/* Controls */}
      <div className="absolute top-24 right-4 z-20 bg-black bg-opacity-60 backdrop-blur-sm p-6 rounded-lg">
        <h3 className="flex items-center space-x-2 mb-4 text-lg font-semibold">
          <Settings size={20} />
          <span>Controls</span>
        </h3>
        
        <div className="space-y-4">
          <div>
            <label className="text-sm mb-2 block">Stream Speed</label>
            <input
              type="range"
              min="10"
              max="90"
              value={streamSpeed}
              onChange={(e) => setStreamSpeed(e.target.value)}
              className="w-40"
            />
            <div className="text-xs text-gray-400 mt-1">{streamSpeed}%</div>
          </div>
          
          <div className="flex items-center space-x-2">
            <input
              type="checkbox"
              id="showLabels"
              checked={showLabels}
              onChange={(e) => setShowLabels(e.target.checked)}
              className="rounded"
            />
            <label htmlFor="showLabels" className="text-sm">Show Labels</label>
          </div>
        </div>
      </div>

      {/* Evolution Pipeline */}
      <div className="absolute top-24 left-4 z-20 bg-black bg-opacity-60 backdrop-blur-sm p-6 rounded-lg">
        <h3 className="text-lg font-semibold mb-4">Evolution Pipeline</h3>
        <div className="space-y-3">
          <div className="flex items-center space-x-3">
            <div className="w-8 h-8 rounded-full bg-blue-500 bg-opacity-30 border border-blue-400 flex items-center justify-center">
              <Code size={16} className="text-blue-400" />
            </div>
            <span className="text-sm">Code Stream → Bubble (Vector)</span>
          </div>
          <div className="text-center text-gray-400">↓</div>
          <div className="flex items-center space-x-3">
            <div className="w-8 h-8 rounded bg-purple-500 bg-opacity-30 border border-purple-400 flex items-center justify-center">
              <FileText size={16} className="text-purple-400" />
            </div>
            <span className="text-sm">Bubble Pops → Screen (Text)</span>
          </div>
          <div className="text-center text-gray-400">↓</div>
          <div className="flex items-center space-x-3">
            <div className="w-8 h-8 rounded bg-orange-500 bg-opacity-30 border border-orange-400 flex items-center justify-center">
              <Ship size={16} className="text-orange-400" />
            </div>
            <span className="text-sm">Screen Wraps → Ship (Mission)</span>
          </div>
        </div>
      </div>

      {/* Stats */}
      <div className="absolute bottom-4 left-4 z-20 bg-black bg-opacity-60 backdrop-blur-sm p-4 rounded-lg">
        <div className="text-sm space-y-1">
          <div>Total Entities: {codeEntities.length}</div>
          <div>Bubbles: {codeEntities.filter(e => e.state === entityStates.BUBBLE).length}</div>
          <div>Screens: {codeEntities.filter(e => e.state === entityStates.SCREEN).length}</div>
          <div>Ships: {codeEntities.filter(e => e.state === entityStates.SHIP || e.state === entityStates.DEPLOYED).length}</div>
        </div>
      </div>

      {/* Selected Entity Info */}
      {selectedEntity && (
        <div className="absolute bottom-4 right-4 z-20 bg-black bg-opacity-80 backdrop-blur-sm p-6 rounded-lg max-w-md">
          <h4 className="font-semibold mb-2">{selectedEntity.type} ({selectedEntity.complexity})</h4>
          <pre className="text-xs font-mono text-gray-300 overflow-auto max-h-32">
            {selectedEntity.code}
          </pre>
          <div className="mt-2 text-xs text-gray-400">
            State: {selectedEntity.state} | Age: {selectedEntity.age} | Helpers: {selectedEntity.helperCount}
          </div>
          <button
            onClick={() => setSelectedEntity(null)}
            className="mt-2 text-xs text-gray-500 hover:text-white"
          >
            Close
          </button>
        </div>
      )}

      {/* Main Canvas */}
      <div ref={canvasRef} className="w-full h-full relative">
        {/* Background particles */}
        <div className="absolute inset-0 overflow-hidden pointer-events-none">
          {Array.from({ length: 30 }).map((_, i) => (
            <div
              key={i}
              className="absolute w-1 h-1 bg-white rounded-full opacity-20 animate-pulse"
              style={{
                left: `${Math.random() * 100}%`,
                top: `${Math.random() * 100}%`,
                animationDelay: `${Math.random() * 5}s`,
                animationDuration: `${3 + Math.random() * 4}s`
              }}
            />
          ))}
        </div>

        {/* Code entities */}
        {codeEntities.map(renderEntity)}

        {/* Terminal source */}
        <div className="absolute bottom-8 left-1/2 transform -translate-x-1/2 z-10">
          <div className="bg-black bg-opacity-80 backdrop-blur-sm p-4 rounded-lg border border-green-400 border-opacity-50">
            <div className="flex items-center space-x-2 mb-2">
              <div className={`w-3 h-3 rounded-full ${isStreaming ? 'bg-green-400 animate-pulse' : 'bg-gray-400'}`} />
              <span className="font-mono text-green-400">cursive-terminal:~$</span>
            </div>
            <div className="text-sm text-gray-300 font-mono">
              {isStreaming ? 'Generating code bubbles...' : 'Stream paused'}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default BubbleShipEvolution;