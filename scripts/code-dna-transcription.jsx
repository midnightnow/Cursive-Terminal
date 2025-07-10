import React, { useState, useEffect, useRef } from 'react';
import { GitBranch, Send, Package, Database, Cloud, Cpu, Activity } from 'lucide-react';

const CodeDNATranscription = () => {
  const [isTranscribing, setIsTranscribing] = useState(false);
  const [dnaStrands, setDnaStrands] = useState([]);
  const [rnaMessages, setRnaMessages] = useState([]);
  const [apiShips, setApiShips] = useState([]);
  const [gitCommits, setGitCommits] = useState([]);
  const [pipelines, setPipelines] = useState([]);
  const canvasRef = useRef(null);
  const animationRef = useRef(null);

  // DNA base pairs representing code patterns
  const codeBases = {
    'A': { pair: 'T', color: '#FF6B6B', represents: 'async', symbol: 'A' },
    'T': { pair: 'A', color: '#4ECDC4', represents: 'await', symbol: 'T' },
    'G': { pair: 'C', color: '#45B7D1', represents: 'function', symbol: 'G' },
    'C': { pair: 'G', color: '#F7DC6F', represents: 'class', symbol: 'C' }
  };

  // Pipeline destinations
  const destinations = [
    { 
      id: 'git', 
      name: 'Git Repository', 
      icon: GitBranch, 
      color: '#F05032',
      endpoint: { x: 100, y: 50 },
      ships: []
    },
    { 
      id: 'api', 
      name: 'REST API', 
      icon: Send, 
      color: '#00D9FF',
      endpoint: { x: 300, y: 50 },
      ships: []
    },
    { 
      id: 'npm', 
      name: 'NPM Registry', 
      icon: Package, 
      color: '#CB3837',
      endpoint: { x: 500, y: 50 },
      ships: []
    },
    { 
      id: 'db', 
      name: 'Database', 
      icon: Database, 
      color: '#336791',
      endpoint: { x: 700, y: 50 },
      ships: []
    },
    { 
      id: 'cloud', 
      name: 'Cloud Deploy', 
      icon: Cloud, 
      color: '#FF9900',
      endpoint: { x: 900, y: 50 },
      ships: []
    }
  ];

  // Generate DNA sequence from code
  const generateDNAFromCode = (code) => {
    const sequence = [];
    const keywords = ['async', 'await', 'function', 'class', 'const', 'let', 'return', 'export'];
    
    // Simple mapping of code patterns to DNA bases
    for (let i = 0; i < code.length; i += 10) {
      const chunk = code.substring(i, i + 10);
      let base = 'A';
      
      if (chunk.includes('async')) base = 'A';
      else if (chunk.includes('await')) base = 'T';
      else if (chunk.includes('function')) base = 'G';
      else if (chunk.includes('class')) base = 'C';
      else base = ['A', 'T', 'G', 'C'][Math.floor(Math.random() * 4)];
      
      sequence.push(base);
    }
    
    return sequence;
  };

  // DNA Replication Animation
  const replicateDNA = (originalStrand) => {
    const newStrand = {
      id: Date.now(),
      sequence: originalStrand.sequence.slice(),
      x: originalStrand.x,
      y: originalStrand.y + 100,
      isReplica: true,
      opacity: 0,
      transcribing: true
    };
    
    setDnaStrands(prev => [...prev, newStrand]);
    
    // Animate replication
    setTimeout(() => {
      setDnaStrands(prev => prev.map(strand => 
        strand.id === newStrand.id 
          ? { ...strand, opacity: 1, y: strand.y + 50 }
          : strand
      ));
    }, 100);
    
    return newStrand;
  };

  // Transcribe DNA to RNA (code to messages)
  const transcribeDNA = (strand) => {
    const rna = strand.sequence.map(base => {
      // DNA to RNA transcription (A→U, T→A, G→C, C→G)
      const transcriptionMap = { 'A': 'U', 'T': 'A', 'G': 'C', 'C': 'G' };
      return transcriptionMap[base] || base;
    });
    
    const message = {
      id: Date.now() + Math.random(),
      sequence: rna,
      x: strand.x + 200,
      y: strand.y,
      velocity: 2,
      destination: destinations[Math.floor(Math.random() * destinations.length)],
      cargo: generateCargoFromRNA(rna)
    };
    
    setRnaMessages(prev => [...prev, message]);
    
    // Launch ship for this RNA message
    launchShip(message);
  };

  // Generate cargo based on RNA sequence
  const generateCargoFromRNA = (rna) => {
    const cargoTypes = {
      'U': 'commit',
      'A': 'api_call',
      'C': 'config',
      'G': 'deployment'
    };
    
    return rna.map(base => cargoTypes[base] || 'data').join('_');
  };

  // Launch ships carrying transcribed code
  const launchShip = (message) => {
    const ship = {
      id: Date.now() + Math.random(),
      x: message.x,
      y: message.y,
      targetX: message.destination.endpoint.x,
      targetY: message.destination.endpoint.y,
      cargo: message.cargo,
      destination: message.destination,
      color: message.destination.color,
      size: 30,
      speed: 1 + Math.random(),
      trail: []
    };
    
    setApiShips(prev => [...prev, ship]);
  };

  // Create pipeline connections
  useEffect(() => {
    const newPipelines = [];
    destinations.forEach((dest, index) => {
      if (index < destinations.length - 1) {
        newPipelines.push({
          from: dest,
          to: destinations[index + 1],
          ships: [],
          flow: 'bidirectional'
        });
      }
    });
    setPipelines(newPipelines);
  }, []);

  // Animation loop
  useEffect(() => {
    let frame = 0;
    
    const animate = () => {
      if (isTranscribing) {
        frame++;
        
        // Generate new DNA strands periodically
        if (frame % 120 === 0) {
          const code = `function processData() {
  async function fetchAPI() {
    const data = await fetch('/api/data');
    return data.json();
  }
  class DataProcessor {
    constructor() {
      this.data = [];
    }
  }
}`;
          
          const sequence = generateDNAFromCode(code);
          const strand = {
            id: Date.now(),
            sequence: sequence,
            x: 100,
            y: 300,
            isOriginal: true,
            opacity: 1,
            transcribing: false
          };
          
          setDnaStrands(prev => [...prev, strand]);
          
          // Replicate after delay
          setTimeout(() => {
            const replica = replicateDNA(strand);
            setTimeout(() => transcribeDNA(replica), 1000);
          }, 500);
        }
        
        // Update ship positions
        setApiShips(prev => prev.map(ship => {
          const dx = ship.targetX - ship.x;
          const dy = ship.targetY - ship.y;
          const distance = Math.sqrt(dx * dx + dy * dy);
          
          if (distance < 5) {
            // Ship reached destination
            return null;
          }
          
          const vx = (dx / distance) * ship.speed;
          const vy = (dy / distance) * ship.speed;
          
          // Add to trail
          ship.trail.push({ x: ship.x, y: ship.y });
          if (ship.trail.length > 20) ship.trail.shift();
          
          return {
            ...ship,
            x: ship.x + vx,
            y: ship.y + vy
          };
        }).filter(Boolean));
        
        // Update RNA messages
        setRnaMessages(prev => prev.map(msg => ({
          ...msg,
          x: msg.x + msg.velocity,
          opacity: msg.opacity !== undefined ? msg.opacity - 0.01 : 1
        })).filter(msg => msg.opacity > 0));
      }
      
      animationRef.current = requestAnimationFrame(animate);
    };
    
    animationRef.current = requestAnimationFrame(animate);
    
    return () => {
      if (animationRef.current) {
        cancelAnimationFrame(animationRef.current);
      }
    };
  }, [isTranscribing]);

  // Render DNA double helix
  const renderDNAStrand = (strand) => {
    return (
      <div
        key={strand.id}
        style={{
          position: 'absolute',
          left: strand.x,
          top: strand.y,
          opacity: strand.opacity,
          transition: 'all 0.5s ease'
        }}
      >
        <div style={{ display: 'flex', alignItems: 'center' }}>
          {strand.sequence.map((base, index) => {
            const baseInfo = codeBases[base];
            const pair = codeBases[baseInfo.pair];
            
            return (
              <div key={index} style={{ 
                display: 'flex', 
                flexDirection: 'column', 
                alignItems: 'center',
                margin: '0 2px'
              }}>
                <div style={{
                  width: '20px',
                  height: '20px',
                  borderRadius: '50%',
                  background: baseInfo.color,
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  fontSize: '10px',
                  fontWeight: 'bold',
                  color: 'white',
                  boxShadow: `0 0 10px ${baseInfo.color}`
                }}>
                  {base}
                </div>
                <div style={{
                  width: '2px',
                  height: '30px',
                  background: `linear-gradient(to bottom, ${baseInfo.color}, ${pair.color})`,
                  margin: '2px 0'
                }} />
                <div style={{
                  width: '20px',
                  height: '20px',
                  borderRadius: '50%',
                  background: pair.color,
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  fontSize: '10px',
                  fontWeight: 'bold',
                  color: 'white',
                  boxShadow: `0 0 10px ${pair.color}`
                }}>
                  {baseInfo.pair}
                </div>
              </div>
            );
          })}
        </div>
        {strand.isReplica && (
          <div style={{
            position: 'absolute',
            top: '-20px',
            left: '0',
            fontSize: '12px',
            color: '#4ECDC4',
            fontStyle: 'italic'
          }}>
            ↓ Replicating...
          </div>
        )}
      </div>
    );
  };

  // Render destination endpoints
  const renderDestinations = () => {
    return destinations.map(dest => {
      const Icon = dest.icon;
      return (
        <div
          key={dest.id}
          style={{
            position: 'absolute',
            left: dest.endpoint.x - 40,
            top: dest.endpoint.y - 40,
            width: '80px',
            height: '80px',
            borderRadius: '50%',
            background: `${dest.color}22`,
            border: `3px solid ${dest.color}`,
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'center',
            justifyContent: 'center',
            boxShadow: `0 0 20px ${dest.color}66`
          }}
        >
          <Icon size={24} color={dest.color} />
          <span style={{ 
            fontSize: '10px', 
            marginTop: '5px', 
            color: dest.color,
            fontWeight: 'bold'
          }}>
            {dest.name}
          </span>
        </div>
      );
    });
  };

  // Render pipeline connections
  const renderPipelines = () => {
    return pipelines.map((pipeline, index) => {
      const x1 = pipeline.from.endpoint.x;
      const y1 = pipeline.from.endpoint.y;
      const x2 = pipeline.to.endpoint.x;
      const y2 = pipeline.to.endpoint.y;
      
      return (
        <svg
          key={index}
          style={{
            position: 'absolute',
            left: 0,
            top: 0,
            width: '100%',
            height: '100%',
            pointerEvents: 'none'
          }}
        >
          <defs>
            <linearGradient id={`gradient-${index}`} x1="0%" y1="0%" x2="100%" y2="0%">
              <stop offset="0%" stopColor={pipeline.from.color} stopOpacity="0.3" />
              <stop offset="100%" stopColor={pipeline.to.color} stopOpacity="0.3" />
            </linearGradient>
          </defs>
          <line
            x1={x1}
            y1={y1}
            x2={x2}
            y2={y2}
            stroke={`url(#gradient-${index})`}
            strokeWidth="3"
            strokeDasharray="5,5"
          />
        </svg>
      );
    });
  };

  return (
    <div style={{
      position: 'relative',
      width: '100%',
      height: '100vh',
      background: 'linear-gradient(135deg, #0a0a0a 0%, #1a1a2e 100%)',
      overflow: 'hidden',
      fontFamily: '"Victor Mono", monospace',
      fontStyle: 'italic',
      color: '#e0e0e0'
    }}>
      {/* Control Panel */}
      <div style={{
        position: 'absolute',
        top: 20,
        left: 20,
        zIndex: 100,
        background: 'rgba(0,0,0,0.9)',
        padding: '20px',
        borderRadius: '10px',
        border: '2px solid #4ECDC4',
        maxWidth: '300px'
      }}>
        <h2 style={{ color: '#4ECDC4', marginBottom: '15px', display: 'flex', alignItems: 'center', gap: '10px' }}>
          <Cpu size={24} />
          Code DNA Transcription
        </h2>
        
        <p style={{ fontSize: '14px', marginBottom: '15px', opacity: 0.8 }}>
          Watch as code replicates like DNA and ships carry the transcribed data to various endpoints!
        </p>
        
        <button
          onClick={() => setIsTranscribing(!isTranscribing)}
          style={{
            padding: '10px 20px',
            background: isTranscribing ? '#FF6B6B' : '#4ECDC4',
            border: 'none',
            borderRadius: '5px',
            color: 'white',
            cursor: 'pointer',
            width: '100%',
            fontSize: '16px',
            fontWeight: 'bold',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            gap: '10px'
          }}
        >
          <Activity size={20} />
          {isTranscribing ? 'Stop Transcription' : 'Start Transcription'}
        </button>
        
        <div style={{ marginTop: '20px', fontSize: '12px' }}>
          <h3 style={{ color: '#F7DC6F', marginBottom: '10px' }}>DNA Base Legend:</h3>
          {Object.entries(codeBases).map(([base, info]) => (
            <div key={base} style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '5px' }}>
              <div style={{
                width: '20px',
                height: '20px',
                borderRadius: '50%',
                background: info.color,
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                fontSize: '10px',
                fontWeight: 'bold',
                color: 'white'
              }}>
                {base}
              </div>
              <span>{base} = {info.represents}</span>
            </div>
          ))}
        </div>
      </div>

      {/* Stats Panel */}
      <div style={{
        position: 'absolute',
        top: 20,
        right: 20,
        background: 'rgba(0,0,0,0.9)',
        padding: '20px',
        borderRadius: '10px',
        border: '2px solid #45B7D1',
        minWidth: '200px'
      }}>
        <h3 style={{ color: '#45B7D1', marginBottom: '10px' }}>Pipeline Status</h3>
        <div style={{ fontSize: '14px' }}>
          <div>DNA Strands: {dnaStrands.length}</div>
          <div>RNA Messages: {rnaMessages.length}</div>
          <div>Ships in Transit: {apiShips.length}</div>
        </div>
      </div>

      {/* Main Canvas */}
      <div style={{ position: 'relative', width: '100%', height: '100%' }}>
        {/* Render pipelines */}
        {renderPipelines()}
        
        {/* Render destinations */}
        {renderDestinations()}
        
        {/* Render DNA strands */}
        {dnaStrands.map(strand => renderDNAStrand(strand))}
        
        {/* Render RNA messages */}
        {rnaMessages.map(msg => (
          <div
            key={msg.id}
            style={{
              position: 'absolute',
              left: msg.x,
              top: msg.y,
              opacity: msg.opacity,
              transition: 'all 0.1s linear'
            }}
          >
            <div style={{
              background: 'rgba(255, 255, 255, 0.1)',
              border: '1px solid rgba(255, 255, 255, 0.3)',
              borderRadius: '5px',
              padding: '5px',
              fontSize: '10px',
              display: 'flex',
              gap: '2px'
            }}>
              {msg.sequence.map((base, i) => (
                <span key={i} style={{ 
                  color: base === 'U' ? '#FF6B6B' : 
                         base === 'A' ? '#4ECDC4' :
                         base === 'C' ? '#F7DC6F' : '#45B7D1'
                }}>
                  {base}
                </span>
              ))}
            </div>
          </div>
        ))}
        
        {/* Render ships */}
        {apiShips.map(ship => (
          <div key={ship.id}>
            {/* Ship trail */}
            {ship.trail.map((point, i) => (
              <div
                key={i}
                style={{
                  position: 'absolute',
                  left: point.x - 2,
                  top: point.y - 2,
                  width: '4px',
                  height: '4px',
                  borderRadius: '50%',
                  background: ship.color,
                  opacity: i / ship.trail.length * 0.5
                }}
              />
            ))}
            
            {/* Ship body */}
            <div
              style={{
                position: 'absolute',
                left: ship.x - ship.size / 2,
                top: ship.y - ship.size / 2,
                width: ship.size,
                height: ship.size,
                fontSize: ship.size,
                filter: `drop-shadow(0 0 10px ${ship.color})`,
                transform: `rotate(${Math.atan2(ship.targetY - ship.y, ship.targetX - ship.x)}rad)`
              }}
            >
              ⛵
            </div>
            
            {/* Cargo label */}
            <div
              style={{
                position: 'absolute',
                left: ship.x - 30,
                top: ship.y + ship.size / 2 + 5,
                fontSize: '8px',
                color: ship.color,
                background: 'rgba(0,0,0,0.8)',
                padding: '2px 5px',
                borderRadius: '3px',
                whiteSpace: 'nowrap'
              }}
            >
              {ship.cargo}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default CodeDNATranscription;