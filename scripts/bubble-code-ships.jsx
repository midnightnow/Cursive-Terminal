import React, { useState, useEffect, useRef } from 'react';
import { Code, FileText, Ship, Zap, Play, Pause, RotateCcw, Settings } from 'lucide-react';

const BubbleCodeShips = () => {
  const [isGenerating, setIsGenerating] = useState(false);
  const [bubbles, setBubbles] = useState([]);
  const [ships, setShips] = useState([]);
  const [codeStream, setCodeStream] = useState('');
  const [bubbleSpeed, setBubbleSpeed] = useState(50);
  const [shipCount, setShipCount] = useState(0);
  const [pirateMode, setPirateMode] = useState(true);
  const canvasRef = useRef(null);
  const animationRef = useRef(null);

  const codeTemplates = [
    { 
      type: 'function', 
      code: 'function navigate() {\n  return "Ahoy!";\n}',
      color: '#4CAF50',
      size: 'small',
      icon: Code
    },
    { 
      type: 'component', 
      code: 'const Ship = () => {\n  return <div>⛵</div>;\n}',
      color: '#2196F3',
      size: 'medium',
      icon: Ship
    },
    { 
      type: 'module', 
      code: 'export class Fleet {\n  constructor() {\n    this.ships = [];\n  }\n}',
      color: '#FF9800',
      size: 'large',
      icon: FileText
    },
    { 
      type: 'helper', 
      code: 'const log = (msg) => console.log(msg);',
      color: '#9C27B0',
      size: 'tiny',
      icon: Zap
    }
  ];

  const pirateMessages = [
    "Arr! Code be flowin' like the seven seas!",
    "Shiver me timbers! That's some fine code!",
    "Hoist the mainsail! Deploy to production!",
    "Avast ye bugs! No errors on me watch!",
    "Yo ho ho and a bottle of rum...time!",
  ];

  // Generate new bubble
  const generateBubble = () => {
    const template = codeTemplates[Math.floor(Math.random() * codeTemplates.length)];
    const newBubble = {
      id: Date.now() + Math.random(),
      x: Math.random() * (window.innerWidth - 200),
      y: window.innerHeight + 100,
      template: template,
      velocity: (Math.random() * 2 + 1) * (bubbleSpeed / 50),
      wobble: Math.random() * Math.PI * 2,
      opacity: 1,
      captured: false
    };
    
    setBubbles(prev => [...prev, newBubble]);
  };

  // Generate ship when bubble is captured
  const generateShip = (bubble) => {
    const newShip = {
      id: Date.now() + Math.random(),
      x: bubble.x,
      y: 100,
      color: bubble.template.color,
      size: bubble.template.size,
      velocity: Math.random() * 2 + 1,
      direction: Math.random() > 0.5 ? 1 : -1,
      rotation: 0
    };
    
    setShips(prev => [...prev, newShip]);
    setShipCount(prev => prev + 1);
    
    // Add code to stream
    setCodeStream(prev => prev + '\n' + bubble.template.code + '\n');
    
    // Show pirate message
    if (pirateMode && Math.random() > 0.7) {
      showPirateMessage();
    }
  };

  const showPirateMessage = () => {
    const message = pirateMessages[Math.floor(Math.random() * pirateMessages.length)];
    // You could show this as a toast or overlay
    console.log('🏴‍☠️ ' + message);
  };

  // Animation loop
  useEffect(() => {
    const animate = () => {
      if (isGenerating) {
        // Update bubbles
        setBubbles(prev => prev
          .map(bubble => ({
            ...bubble,
            y: bubble.y - bubble.velocity,
            x: bubble.x + Math.sin(bubble.wobble) * 0.5,
            wobble: bubble.wobble + 0.05,
            opacity: bubble.captured ? bubble.opacity - 0.05 : 1
          }))
          .filter(bubble => bubble.y > -100 && bubble.opacity > 0)
        );

        // Update ships
        setShips(prev => prev
          .map(ship => ({
            ...ship,
            x: ship.x + ship.velocity * ship.direction,
            rotation: ship.rotation + 0.02,
            direction: (ship.x > window.innerWidth - 100 || ship.x < 0) ? -ship.direction : ship.direction
          }))
        );

        // Generate new bubbles
        if (Math.random() < 0.02) {
          generateBubble();
        }
      }

      animationRef.current = requestAnimationFrame(animate);
    };

    animationRef.current = requestAnimationFrame(animate);
    
    return () => {
      if (animationRef.current) {
        cancelAnimationFrame(animationRef.current);
      }
    };
  }, [isGenerating, bubbleSpeed]);

  // Handle bubble clicks
  const handleBubbleClick = (bubbleId) => {
    setBubbles(prev => prev.map(bubble => {
      if (bubble.id === bubbleId && !bubble.captured) {
        generateShip(bubble);
        return { ...bubble, captured: true };
      }
      return bubble;
    }));
  };

  // Reset everything
  const reset = () => {
    setIsGenerating(false);
    setBubbles([]);
    setShips([]);
    setCodeStream('');
    setShipCount(0);
  };

  const getSizeMultiplier = (size) => {
    switch(size) {
      case 'tiny': return 0.7;
      case 'small': return 1;
      case 'medium': return 1.3;
      case 'large': return 1.6;
      default: return 1;
    }
  };

  return (
    <div className="bubble-code-ships" style={{ 
      position: 'relative', 
      width: '100%', 
      height: '100vh', 
      background: 'linear-gradient(to bottom, #0a0a0a, #1a1a2e)',
      overflow: 'hidden',
      fontFamily: '"Victor Mono", monospace',
      fontStyle: 'italic'
    }}>
      {/* Control Panel */}
      <div style={{
        position: 'absolute',
        top: 20,
        left: 20,
        zIndex: 100,
        background: 'rgba(0,0,0,0.8)',
        padding: '20px',
        borderRadius: '10px',
        border: '2px solid #ffd700'
      }}>
        <h2 style={{ color: '#ffd700', marginBottom: '15px' }}>
          🏴‍☠️ Code Bubble Fleet Generator
        </h2>
        
        <div style={{ display: 'flex', gap: '10px', marginBottom: '15px' }}>
          <button
            onClick={() => setIsGenerating(!isGenerating)}
            style={{
              padding: '10px 20px',
              background: isGenerating ? '#f44336' : '#4CAF50',
              border: 'none',
              borderRadius: '5px',
              color: 'white',
              cursor: 'pointer',
              display: 'flex',
              alignItems: 'center',
              gap: '5px'
            }}
          >
            {isGenerating ? <Pause size={16} /> : <Play size={16} />}
            {isGenerating ? 'Pause' : 'Start'}
          </button>
          
          <button
            onClick={reset}
            style={{
              padding: '10px 20px',
              background: '#FF9800',
              border: 'none',
              borderRadius: '5px',
              color: 'white',
              cursor: 'pointer',
              display: 'flex',
              alignItems: 'center',
              gap: '5px'
            }}
          >
            <RotateCcw size={16} />
            Reset
          </button>
        </div>
        
        <div style={{ marginBottom: '10px' }}>
          <label style={{ color: '#ffd700', fontSize: '14px' }}>
            Bubble Speed: {bubbleSpeed}%
          </label>
          <input
            type="range"
            min="10"
            max="100"
            value={bubbleSpeed}
            onChange={(e) => setBubbleSpeed(parseInt(e.target.value))}
            style={{ width: '100%', marginTop: '5px' }}
          />
        </div>
        
        <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
          <input
            type="checkbox"
            id="pirateMode"
            checked={pirateMode}
            onChange={(e) => setPirateMode(e.target.checked)}
          />
          <label htmlFor="pirateMode" style={{ color: '#ffd700', fontSize: '14px' }}>
            Pirate Mode 🏴‍☠️
          </label>
        </div>
        
        <div style={{ marginTop: '15px', color: '#4CAF50' }}>
          Ships Generated: {shipCount} ⛵
        </div>
      </div>

      {/* Code Stream Display */}
      <div style={{
        position: 'absolute',
        top: 20,
        right: 20,
        width: '300px',
        height: '200px',
        background: 'rgba(0,0,0,0.8)',
        border: '2px solid #4CAF50',
        borderRadius: '10px',
        padding: '10px',
        overflow: 'auto',
        fontFamily: 'monospace',
        fontSize: '12px',
        color: '#4CAF50'
      }}>
        <h3 style={{ marginBottom: '10px' }}>Generated Code Stream</h3>
        <pre style={{ margin: 0 }}>{codeStream || '// Click bubbles to generate code...'}</pre>
      </div>

      {/* Bubbles */}
      {bubbles.map(bubble => {
        const Icon = bubble.template.icon;
        const size = getSizeMultiplier(bubble.template.size);
        
        return (
          <div
            key={bubble.id}
            onClick={() => handleBubbleClick(bubble.id)}
            style={{
              position: 'absolute',
              left: bubble.x,
              top: bubble.y,
              width: 80 * size,
              height: 80 * size,
              background: `radial-gradient(circle at 30% 30%, ${bubble.template.color}88, ${bubble.template.color}44)`,
              borderRadius: '50%',
              border: `2px solid ${bubble.template.color}`,
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              cursor: 'pointer',
              opacity: bubble.opacity,
              transform: `scale(${bubble.captured ? 1.5 : 1})`,
              transition: 'transform 0.3s, opacity 0.5s',
              boxShadow: `0 0 20px ${bubble.template.color}66`
            }}
          >
            <Icon size={30 * size} color="white" />
          </div>
        );
      })}

      {/* Ships */}
      {ships.map(ship => {
        const size = getSizeMultiplier(ship.size);
        
        return (
          <div
            key={ship.id}
            style={{
              position: 'absolute',
              left: ship.x,
              top: ship.y,
              fontSize: 40 * size,
              transform: `rotate(${ship.rotation}rad)`,
              filter: `drop-shadow(0 0 10px ${ship.color})`,
              transition: 'left 0.1s linear'
            }}
          >
            ⛵
          </div>
        );
      })}

      {/* Ocean waves effect */}
      <div style={{
        position: 'absolute',
        bottom: 0,
        left: 0,
        right: 0,
        height: '100px',
        background: 'linear-gradient(to top, #0066cc44, transparent)',
        borderTop: '2px solid #0066cc'
      }}>
        <div style={{
          position: 'absolute',
          width: '200%',
          height: '100%',
          background: 'repeating-linear-gradient(90deg, transparent, transparent 50px, #0066cc22 50px, #0066cc22 100px)',
          animation: 'wave 10s linear infinite'
        }} />
      </div>

      <style jsx>{`
        @keyframes wave {
          0% { transform: translateX(0); }
          100% { transform: translateX(-100px); }
        }
      `}</style>
    </div>
  );
};

export default BubbleCodeShips;