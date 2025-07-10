import React, { useState, useEffect, useRef } from 'react';
import { GitBranch, Package, Database, Cloud, Globe, Server, Anchor, ArrowUpDown } from 'lucide-react';

const CodeSupplyChain = () => {
  const [isRunning, setIsRunning] = useState(false);
  const [supplyRoutes, setSupplyRoutes] = useState([]);
  const [cargoShips, setCargoShips] = useState([]);
  const [ports, setPorts] = useState([]);
  const [tradeStats, setTradeStats] = useState({});
  const animationRef = useRef(null);

  // Port definitions - each represents a service/API
  const portDefinitions = [
    {
      id: 'local',
      name: 'Local Dev',
      icon: Anchor,
      x: 100,
      y: 300,
      color: '#4ECDC4',
      exports: ['code', 'commits'],
      imports: ['dependencies', 'config'],
      inventory: { code: 100, commits: 50 }
    },
    {
      id: 'github',
      name: 'GitHub',
      icon: GitBranch,
      x: 400,
      y: 150,
      color: '#F05032',
      exports: ['releases', 'issues'],
      imports: ['commits', 'prs'],
      inventory: { releases: 20, issues: 150 }
    },
    {
      id: 'npm',
      name: 'NPM Registry',
      icon: Package,
      x: 700,
      y: 200,
      color: '#CB3837',
      exports: ['packages', 'versions'],
      imports: ['builds', 'metadata'],
      inventory: { packages: 500, versions: 2000 }
    },
    {
      id: 'database',
      name: 'Database',
      icon: Database,
      x: 400,
      y: 450,
      color: '#336791',
      exports: ['data', 'backups'],
      imports: ['queries', 'migrations'],
      inventory: { data: 10000, backups: 100 }
    },
    {
      id: 'cdn',
      name: 'CDN',
      icon: Globe,
      x: 700,
      y: 400,
      color: '#FF9900',
      exports: ['assets', 'cache'],
      imports: ['builds', 'static'],
      inventory: { assets: 5000, cache: 1000 }
    },
    {
      id: 'api',
      name: 'API Server',
      icon: Server,
      x: 1000,
      y: 300,
      color: '#00D9FF',
      exports: ['responses', 'webhooks'],
      imports: ['requests', 'data'],
      inventory: { responses: 50000, webhooks: 1000 }
    },
    {
      id: 'cloud',
      name: 'Cloud Deploy',
      icon: Cloud,
      x: 1000,
      y: 100,
      color: '#FF6B6B',
      exports: ['instances', 'logs'],
      imports: ['containers', 'config'],
      inventory: { instances: 50, logs: 100000 }
    }
  ];

  // Initialize ports
  useEffect(() => {
    setPorts(portDefinitions);
    
    // Create trade routes between ports
    const routes = [];
    
    // Define supply chain connections
    const connections = [
      { from: 'local', to: 'github', cargo: 'commits', frequency: 'high' },
      { from: 'github', to: 'npm', cargo: 'releases', frequency: 'medium' },
      { from: 'github', to: 'cloud', cargo: 'code', frequency: 'high' },
      { from: 'npm', to: 'cdn', cargo: 'packages', frequency: 'medium' },
      { from: 'local', to: 'database', cargo: 'queries', frequency: 'high' },
      { from: 'database', to: 'api', cargo: 'data', frequency: 'high' },
      { from: 'api', to: 'cloud', cargo: 'responses', frequency: 'medium' },
      { from: 'cloud', to: 'cdn', cargo: 'assets', frequency: 'low' },
      // Bidirectional routes
      { from: 'api', to: 'database', cargo: 'requests', frequency: 'high' },
      { from: 'cdn', to: 'api', cargo: 'cache', frequency: 'medium' },
      { from: 'cloud', to: 'local', cargo: 'logs', frequency: 'low' }
    ];
    
    connections.forEach(conn => {
      const fromPort = portDefinitions.find(p => p.id === conn.from);
      const toPort = portDefinitions.find(p => p.id === conn.to);
      
      if (fromPort && toPort) {
        routes.push({
          id: `${conn.from}-${conn.to}`,
          from: fromPort,
          to: toPort,
          cargo: conn.cargo,
          frequency: conn.frequency,
          ships: []
        });
      }
    });
    
    setSupplyRoutes(routes);
  }, []);

  // Generate cargo ship
  const generateCargoShip = (route) => {
    const ship = {
      id: Date.now() + Math.random(),
      route: route,
      x: route.from.x,
      y: route.from.y,
      targetX: route.to.x,
      targetY: route.to.y,
      cargo: route.cargo,
      amount: Math.floor(Math.random() * 50) + 10,
      speed: route.frequency === 'high' ? 2 : route.frequency === 'medium' ? 1.5 : 1,
      progress: 0,
      color: route.from.color,
      size: 40,
      delivered: false
    };
    
    setCargoShips(prev => [...prev, ship]);
    
    // Update route ships count
    route.ships.push(ship.id);
  };

  // Animation loop
  useEffect(() => {
    let frame = 0;
    
    const animate = () => {
      if (isRunning) {
        frame++;
        
        // Generate ships based on route frequency
        supplyRoutes.forEach(route => {
          const spawnRate = route.frequency === 'high' ? 60 : 
                           route.frequency === 'medium' ? 120 : 180;
          
          if (frame % spawnRate === 0) {
            generateCargoShip(route);
          }
        });
        
        // Update ship positions
        setCargoShips(prev => prev.map(ship => {
          if (ship.delivered) return null;
          
          // Calculate progress along route
          const dx = ship.targetX - ship.route.from.x;
          const dy = ship.targetY - ship.route.from.y;
          const distance = Math.sqrt(dx * dx + dy * dy);
          
          ship.progress += ship.speed / distance;
          
          if (ship.progress >= 1) {
            // Ship reached destination
            ship.delivered = true;
            
            // Update port inventory
            setPorts(prevPorts => prevPorts.map(port => {
              if (port.id === ship.route.to.id) {
                return {
                  ...port,
                  inventory: {
                    ...port.inventory,
                    [ship.cargo]: (port.inventory[ship.cargo] || 0) + ship.amount
                  }
                };
              }
              return port;
            }));
            
            // Update trade stats
            setTradeStats(prev => ({
              ...prev,
              [ship.route.id]: (prev[ship.route.id] || 0) + ship.amount
            }));
            
            return null;
          }
          
          // Update position
          ship.x = ship.route.from.x + dx * ship.progress;
          ship.y = ship.route.from.y + dy * ship.progress;
          
          return ship;
        }).filter(Boolean));
      }
      
      animationRef.current = requestAnimationFrame(animate);
    };
    
    animationRef.current = requestAnimationFrame(animate);
    
    return () => {
      if (animationRef.current) {
        cancelAnimationFrame(animationRef.current);
      }
    };
  }, [isRunning, supplyRoutes]);

  // Render supply route
  const renderSupplyRoute = (route) => {
    const activeShips = cargoShips.filter(ship => ship.route.id === route.id).length;
    
    return (
      <g key={route.id}>
        <defs>
          <marker
            id={`arrow-${route.id}`}
            viewBox="0 0 10 10"
            refX="5"
            refY="5"
            markerWidth="5"
            markerHeight="5"
            orient="auto"
          >
            <path
              d="M 0 0 L 10 5 L 0 10 z"
              fill={route.from.color}
              opacity="0.5"
            />
          </marker>
        </defs>
        
        <line
          x1={route.from.x}
          y1={route.from.y}
          x2={route.to.x}
          y2={route.to.y}
          stroke={route.from.color}
          strokeWidth={route.frequency === 'high' ? 3 : route.frequency === 'medium' ? 2 : 1}
          strokeOpacity="0.3"
          strokeDasharray={route.frequency === 'low' ? "5,5" : "0"}
          markerEnd={`url(#arrow-${route.id})`}
        />
        
        {/* Route label */}
        <text
          x={(route.from.x + route.to.x) / 2}
          y={(route.from.y + route.to.y) / 2 - 10}
          fill={route.from.color}
          fontSize="10"
          textAnchor="middle"
          opacity="0.7"
        >
          {route.cargo} ({activeShips})
        </text>
      </g>
    );
  };

  // Render port
  const renderPort = (port) => {
    const Icon = port.icon;
    const totalInventory = Object.values(port.inventory).reduce((sum, val) => sum + val, 0);
    
    return (
      <g key={port.id}>
        {/* Port circle */}
        <circle
          cx={port.x}
          cy={port.y}
          r="50"
          fill={`${port.color}22`}
          stroke={port.color}
          strokeWidth="3"
        />
        
        {/* Port icon */}
        <foreignObject x={port.x - 20} y={port.y - 20} width="40" height="40">
          <Icon size={40} color={port.color} />
        </foreignObject>
        
        {/* Port name */}
        <text
          x={port.x}
          y={port.y + 70}
          fill={port.color}
          fontSize="14"
          fontWeight="bold"
          textAnchor="middle"
        >
          {port.name}
        </text>
        
        {/* Inventory indicator */}
        <text
          x={port.x}
          y={port.y + 85}
          fill={port.color}
          fontSize="10"
          textAnchor="middle"
          opacity="0.7"
        >
          Inventory: {totalInventory}
        </text>
      </g>
    );
  };

  return (
    <div style={{
      position: 'relative',
      width: '100%',
      height: '100vh',
      background: 'linear-gradient(135deg, #0a0a0a 0%, #0f1419 100%)',
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
        maxWidth: '350px'
      }}>
        <h2 style={{ color: '#4ECDC4', marginBottom: '15px', display: 'flex', alignItems: 'center', gap: '10px' }}>
          <ArrowUpDown size={24} />
          Code Supply Chain Network
        </h2>
        
        <p style={{ fontSize: '14px', marginBottom: '15px', opacity: 0.8 }}>
          Watch as ships carry code, data, and resources between different services in your development ecosystem.
        </p>
        
        <button
          onClick={() => setIsRunning(!isRunning)}
          style={{
            padding: '10px 20px',
            background: isRunning ? '#FF6B6B' : '#4ECDC4',
            border: 'none',
            borderRadius: '5px',
            color: 'white',
            cursor: 'pointer',
            width: '100%',
            fontSize: '16px',
            fontWeight: 'bold'
          }}
        >
          {isRunning ? '⏸️ Pause Supply Chain' : '▶️ Start Supply Chain'}
        </button>
        
        <div style={{ marginTop: '20px', fontSize: '12px' }}>
          <h3 style={{ color: '#F7DC6F', marginBottom: '10px' }}>Route Frequency:</h3>
          <div style={{ display: 'flex', flexDirection: 'column', gap: '5px' }}>
            <div>🚢🚢🚢 High - Every minute</div>
            <div>🚢🚢 Medium - Every 2 minutes</div>
            <div>🚢 Low - Every 3 minutes</div>
          </div>
        </div>
      </div>

      {/* Trade Stats */}
      <div style={{
        position: 'absolute',
        top: 20,
        right: 20,
        background: 'rgba(0,0,0,0.9)',
        padding: '20px',
        borderRadius: '10px',
        border: '2px solid #45B7D1',
        minWidth: '250px',
        maxHeight: '400px',
        overflow: 'auto'
      }}>
        <h3 style={{ color: '#45B7D1', marginBottom: '10px' }}>📊 Trade Statistics</h3>
        <div style={{ fontSize: '12px' }}>
          <div style={{ marginBottom: '10px' }}>
            Active Ships: {cargoShips.length} ⛵
          </div>
          <h4 style={{ color: '#F7DC6F', marginBottom: '5px' }}>Route Volumes:</h4>
          {Object.entries(tradeStats).map(([route, volume]) => (
            <div key={route} style={{ marginBottom: '3px' }}>
              {route}: {volume} units
            </div>
          ))}
        </div>
      </div>

      {/* Main SVG Canvas */}
      <svg
        width="100%"
        height="100%"
        style={{ position: 'absolute', top: 0, left: 0 }}
      >
        {/* Render supply routes */}
        {supplyRoutes.map(route => renderSupplyRoute(route))}
        
        {/* Render ports */}
        {ports.map(port => renderPort(port))}
        
        {/* Render cargo ships */}
        {cargoShips.map(ship => (
          <g key={ship.id}>
            {/* Ship shadow */}
            <ellipse
              cx={ship.x}
              cy={ship.y + 5}
              rx="20"
              ry="10"
              fill="black"
              opacity="0.3"
            />
            
            {/* Ship body */}
            <text
              x={ship.x}
              y={ship.y}
              fontSize={ship.size}
              textAnchor="middle"
              dominantBaseline="middle"
              style={{
                filter: `drop-shadow(0 0 10px ${ship.color})`,
                transform: `rotate(${Math.atan2(ship.targetY - ship.y, ship.targetX - ship.x)}rad)`,
                transformOrigin: `${ship.x}px ${ship.y}px`
              }}
            >
              ⛵
            </text>
            
            {/* Cargo label */}
            <rect
              x={ship.x - 30}
              y={ship.y + 25}
              width="60"
              height="20"
              fill="rgba(0,0,0,0.8)"
              rx="3"
            />
            <text
              x={ship.x}
              y={ship.y + 37}
              fill={ship.color}
              fontSize="10"
              textAnchor="middle"
              fontWeight="bold"
            >
              {ship.cargo}: {ship.amount}
            </text>
          </g>
        ))}
      </svg>

      {/* Ocean effect */}
      <div style={{
        position: 'absolute',
        bottom: 0,
        left: 0,
        right: 0,
        height: '150px',
        background: 'linear-gradient(to top, rgba(0, 102, 204, 0.3), transparent)',
        pointerEvents: 'none'
      }}>
        <div style={{
          position: 'absolute',
          width: '200%',
          height: '100%',
          background: 'repeating-linear-gradient(90deg, transparent, transparent 100px, rgba(255, 255, 255, 0.05) 100px, rgba(255, 255, 255, 0.05) 200px)',
          animation: 'wave 20s linear infinite'
        }} />
      </div>

      <style jsx>{`
        @keyframes wave {
          0% { transform: translateX(0); }
          100% { transform: translateX(-200px); }
        }
      `}</style>
    </div>
  );
};

export default CodeSupplyChain;