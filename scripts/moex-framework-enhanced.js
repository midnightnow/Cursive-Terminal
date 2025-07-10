#!/usr/bin/env node

/**
 * 🧬 MOEX (Multi-Objective Experience) Framework - Enhanced Edition
 * 
 * The world's first personality-driven terminal AI with advanced expert routing,
 * circuit breakers, parallel scoring, and pluggable expert registry.
 * 
 * Features:
 * - Parallel expert scoring for performance
 * - Circuit breaker patterns for reliability
 * - Health monitoring with automatic recovery
 * - Pluggable expert registry for extensibility
 * - Deterministic responses for consistency
 * - Captain Code personality integration
 * 
 * @version 0.1.1-moex-fixes
 * @author Captain Code MOEX Team
 */

import chalk from 'chalk';
import crypto from 'crypto';

// 🏴‍☠️ Circuit Breaker States
const CIRCUIT_STATES = {
  CLOSED: 'CLOSED',
  OPEN: 'OPEN', 
  HALF_OPEN: 'HALF_OPEN'
};

// ⚡ Expert Health Status
const HEALTH_STATUS = {
  HEALTHY: 'HEALTHY',
  DEGRADED: 'DEGRADED',
  FAILED: 'FAILED'
};

/**
 * 🔧 Circuit Breaker for Expert Reliability
 */
class ExpertCircuitBreaker {
  constructor(expertName, options = {}) {
    this.expertName = expertName;
    this.failureThreshold = options.failureThreshold || 5;
    this.recoveryTimeout = options.recoveryTimeout || 60000; // 60 seconds
    this.state = CIRCUIT_STATES.CLOSED;
    this.failureCount = 0;
    this.lastFailureTime = null;
    this.nextRetryTime = null;
  }

  async execute(expertFunction, ...args) {
    if (this.state === CIRCUIT_STATES.OPEN) {
      if (Date.now() < this.nextRetryTime) {
        throw new Error(`⚡ Circuit breaker OPEN for ${this.expertName}`);
      }
      this.state = CIRCUIT_STATES.HALF_OPEN;
    }

    try {
      const result = await expertFunction(...args);
      this.onSuccess();
      return result;
    } catch (error) {
      this.onFailure();
      throw error;
    }
  }

  onSuccess() {
    this.failureCount = 0;
    this.state = CIRCUIT_STATES.CLOSED;
    this.lastFailureTime = null;
    this.nextRetryTime = null;
  }

  onFailure() {
    this.failureCount++;
    this.lastFailureTime = Date.now();

    if (this.failureCount >= this.failureThreshold) {
      this.state = CIRCUIT_STATES.OPEN;
      this.nextRetryTime = Date.now() + this.recoveryTimeout;
      console.log(chalk.red(`🚨 Circuit breaker OPENED for ${this.expertName}`));
    }
  }

  getStatus() {
    return {
      expert: this.expertName,
      state: this.state,
      failureCount: this.failureCount,
      isHealthy: this.state === CIRCUIT_STATES.CLOSED,
      nextRetryTime: this.nextRetryTime
    };
  }
}

/**
 * 🧬 Enhanced Expert Base Class
 */
class MOEXExpert {
  constructor(name, specialty) {
    this.name = name;
    this.specialty = specialty;
    this.circuitBreaker = new ExpertCircuitBreaker(name);
    this.healthStatus = HEALTH_STATUS.HEALTHY;
    this.lastHealthCheck = Date.now();
    this.processCount = 0;
    this.successCount = 0;
  }

  // Abstract methods for experts to implement
  canHandle(prompt) {
    throw new Error('canHandle must be implemented by expert');
  }

  async process(prompt) {
    throw new Error('process must be implemented by expert');
  }

  // Enhanced scoring with circuit breaker protection
  async getConfidenceScore(prompt) {
    try {
      return await this.circuitBreaker.execute(() => {
        const score = this.calculateScore(prompt);
        this.updateHealthMetrics(true);
        return score;
      });
    } catch (error) {
      this.updateHealthMetrics(false);
      console.log(chalk.yellow(`⚠️ Expert ${this.name} scoring failed: ${error.message}`));
      return 0; // Failed experts get 0 score
    }
  }

  calculateScore(prompt) {
    // Default implementation - experts should override
    return this.canHandle(prompt) ? 0.5 : 0;
  }

  updateHealthMetrics(success) {
    this.processCount++;
    if (success) this.successCount++;
    this.lastHealthCheck = Date.now();
    
    // Update health status based on success rate
    const successRate = this.successCount / this.processCount;
    if (successRate > 0.8) {
      this.healthStatus = HEALTH_STATUS.HEALTHY;
    } else if (successRate > 0.5) {
      this.healthStatus = HEALTH_STATUS.DEGRADED;
    } else {
      this.healthStatus = HEALTH_STATUS.FAILED;
    }
  }

  getHealthReport() {
    return {
      name: this.name,
      specialty: this.specialty,
      health: this.healthStatus,
      successRate: this.processCount > 0 ? (this.successCount / this.processCount) : 1,
      processCount: this.processCount,
      circuitBreaker: this.circuitBreaker.getStatus(),
      lastHealthCheck: this.lastHealthCheck
    };
  }
}

/**
 * 🧬 DNA Code Transcription Expert
 */
class DNAExpert extends MOEXExpert {
  constructor() {
    super('DNA Transcription Specialist', 'Genetic code visualization and analysis');
  }

  canHandle(prompt) {
    const dnaKeywords = ['dna', 'gene', 'genetic', 'sequence', 'base', 'transcribe', 'atgc'];
    return dnaKeywords.some(keyword => 
      prompt.toLowerCase().includes(keyword)
    );
  }

  calculateScore(prompt) {
    if (!this.canHandle(prompt)) return 0;
    
    const prompt_lower = prompt.toLowerCase();
    let score = 0.3; // Base score for DNA-related content
    
    // Boost score for specific DNA terms
    if (prompt_lower.includes('transcribe')) score += 0.4;
    if (prompt_lower.includes('sequence')) score += 0.3;
    if (prompt_lower.includes('base pair')) score += 0.4;
    if (prompt_lower.includes('genetic')) score += 0.2;
    
    return Math.min(score, 1.0);
  }

  async process(prompt) {
    try {
      const result = await this.circuitBreaker.execute(async () => {
        console.log(chalk.cyan('🧬 DNA Expert processing genetic transcription...'));
        
        // Enhanced DNA transcription with error handling
        const sequence = this.extractCodeSequence(prompt);
        const transcribed = this.transcribeToGeneticBases(sequence);
        
        return {
          expert: this.name,
          analysis: `🧬 Genetic Analysis Complete`,
          sequence: transcribed,
          basePairs: this.generateBasePairs(transcribed),
          visualization: this.createDNAVisualization(transcribed),
          confidence: await this.getConfidenceScore(prompt)
        };
      });
      
      this.updateHealthMetrics(true);
      return result;
    } catch (error) {
      this.updateHealthMetrics(false);
      throw error;
    }
  }

  extractCodeSequence(prompt) {
    // Extract code-like patterns for DNA mapping
    const codePattern = /(?:function|class|const|import|var|let)\s+\w+/gi;
    const matches = prompt.match(codePattern) || [];
    return matches.join(' ');
  }

  transcribeToGeneticBases(codeSequence) {
    // Map code elements to DNA bases with deterministic hashing
    const hash = crypto.createHash('md5').update(codeSequence).digest('hex');
    return hash.toUpperCase().replace(/[0-9]/g, '').slice(0, 16)
      .replace(/[EFHIJKLMNOPQRSTUVWXYZ]/g, 'A') // Map to A, T, G, C only
      .replace(/[ABCD]/g, match => ({ A: 'A', B: 'T', C: 'G', D: 'C' }[match]));
  }

  generateBasePairs(sequence) {
    // Create accurate base pairs: A↔T, G↔C
    return sequence.split('').map(base => {
      const complement = { A: 'T', T: 'A', G: 'C', C: 'G' }[base];
      return `${base}↔${complement}`;
    });
  }

  createDNAVisualization(sequence) {
    const colors = { A: '🔴', T: '🟢', G: '🔵', C: '🟣' };
    return sequence.split('').map(base => colors[base] || '⚪').join('');
  }
}

/**
 * 🐛 Bug Hunter Expert - Enhanced Detective
 */
class BugHunterExpert extends MOEXExpert {
  constructor() {
    super('Bug Hunter Detective', 'Code debugging and error analysis');
  }

  canHandle(prompt) {
    const bugKeywords = ['error', 'bug', 'debug', 'fix', 'problem', 'issue', 'crash', 'fail'];
    return bugKeywords.some(keyword => 
      prompt.toLowerCase().includes(keyword)
    );
  }

  calculateScore(prompt) {
    if (!this.canHandle(prompt)) return 0;
    
    const prompt_lower = prompt.toLowerCase();
    let score = 0.4; // Base score for bug-related content
    
    // Boost score for critical debugging terms
    if (prompt_lower.includes('error')) score += 0.3;
    if (prompt_lower.includes('debug')) score += 0.4;
    if (prompt_lower.includes('crash')) score += 0.5;
    if (prompt_lower.includes('exception')) score += 0.4;
    
    return Math.min(score, 1.0);
  }

  async process(prompt) {
    try {
      const result = await this.circuitBreaker.execute(async () => {
        console.log(chalk.red('🐛 Bug Hunter on the case...'));
        
        // Deterministic bug selection based on prompt hash
        const bugHash = crypto.createHash('md5').update(prompt).digest('hex');
        const bugIndex = parseInt(bugHash.slice(0, 2), 16) % this.bugTypes.length;
        const selectedBug = this.bugTypes[bugIndex];
        
        return {
          expert: this.name,
          analysis: `🐛 Bug Analysis: ${selectedBug.type}`,
          severity: selectedBug.severity,
          solution: selectedBug.solution,
          prevention: selectedBug.prevention,
          confidence: await this.getConfidenceScore(prompt)
        };
      });
      
      this.updateHealthMetrics(true);
      return result;
    } catch (error) {
      this.updateHealthMetrics(false);
      throw error;
    }
  }

  get bugTypes() {
    return [
      {
        type: 'Null Pointer Exception',
        severity: 'HIGH',
        solution: 'Add null checks before accessing object properties',
        prevention: 'Use optional chaining (?.) and nullish coalescing (??)'
      },
      {
        type: 'Memory Leak',
        severity: 'MEDIUM',
        solution: 'Remove event listeners and clear intervals/timeouts',
        prevention: 'Use proper cleanup in useEffect or component unmount'
      },
      {
        type: 'Race Condition',
        severity: 'HIGH',
        solution: 'Implement proper async/await patterns or locks',
        prevention: 'Avoid shared state mutations, use atomic operations'
      },
      {
        type: 'Logic Error',
        severity: 'MEDIUM',
        solution: 'Review conditional statements and loop boundaries',
        prevention: 'Write comprehensive unit tests and code reviews'
      }
    ];
  }
}

/**
 * 🔄 Echo Expert - Reliable Fallback
 */
class EchoExpert extends MOEXExpert {
  constructor() {
    super('Echo Chamber', 'Reliable response generation and fallback handling');
  }

  canHandle(prompt) {
    return true; // Echo can handle anything as fallback
  }

  calculateScore(prompt) {
    // Echo always provides low but reliable score
    return 0.1;
  }

  async process(prompt) {
    try {
      const result = await this.circuitBreaker.execute(async () => {
        console.log(chalk.gray('🔄 Echo Expert providing reliable response...'));
        
        return {
          expert: this.name,
          analysis: '🔄 Echo Response Generated',
          response: `Acknowledged: "${prompt.slice(0, 100)}${prompt.length > 100 ? '...' : ''}"`,
          suggestions: [
            '💡 Try being more specific about what you need',
            '🧬 For code analysis, mention DNA or genetic terms',
            '🐛 For debugging help, mention error or bug details'
          ],
          confidence: await this.getConfidenceScore(prompt)
        };
      });
      
      this.updateHealthMetrics(true);
      return result;
    } catch (error) {
      this.updateHealthMetrics(false);
      throw error;
    }
  }
}

/**
 * 🌐 Terminal Expert - Command Line Specialist
 */
class TerminalExpert extends MOEXExpert {
  constructor() {
    super('Terminal Command Specialist', 'Shell commands and terminal operations');
  }

  canHandle(prompt) {
    const terminalKeywords = ['command', 'terminal', 'shell', 'bash', 'cli', 'script', 'run'];
    return terminalKeywords.some(keyword => 
      prompt.toLowerCase().includes(keyword)
    );
  }

  calculateScore(prompt) {
    if (!this.canHandle(prompt)) return 0;
    
    const prompt_lower = prompt.toLowerCase();
    let score = 0.3;
    
    if (prompt_lower.includes('terminal')) score += 0.4;
    if (prompt_lower.includes('command')) score += 0.3;
    if (prompt_lower.includes('shell')) score += 0.3;
    if (prompt_lower.includes('script')) score += 0.2;
    
    return Math.min(score, 1.0);
  }

  async process(prompt) {
    try {
      const result = await this.circuitBreaker.execute(async () => {
        console.log(chalk.blue('🌐 Terminal Expert analyzing command...'));
        
        return {
          expert: this.name,
          analysis: '🌐 Terminal Command Analysis',
          suggestions: [
            '📁 Use `ls -la` to list files with details',
            '🔍 Use `grep` to search file contents',
            '⚡ Use `&&` to chain commands',
            '🚀 Use `nohup` for background processes'
          ],
          safety: 'Always review commands before execution',
          confidence: await this.getConfidenceScore(prompt)
        };
      });
      
      this.updateHealthMetrics(true);
      return result;
    } catch (error) {
      this.updateHealthMetrics(false);
      throw error;
    }
  }
}

/**
 * 📚 Pluggable Expert Registry
 */
class ExpertRegistry {
  constructor() {
    this.experts = new Map();
    this.categories = new Map();
    this.loadDefaultExperts();
  }

  loadDefaultExperts() {
    // Register core experts
    this.register(new DNAExpert());
    this.register(new BugHunterExpert());
    this.register(new TerminalExpert());
    this.register(new EchoExpert()); // Always register Echo as fallback
  }

  register(expert) {
    if (!(expert instanceof MOEXExpert)) {
      throw new Error('Expert must extend MOEXExpert class');
    }
    
    this.experts.set(expert.name, expert);
    
    // Categorize expert
    const category = expert.specialty.split(' ')[0].toLowerCase();
    if (!this.categories.has(category)) {
      this.categories.set(category, []);
    }
    this.categories.get(category).push(expert.name);
    
    console.log(chalk.green(`✅ Registered expert: ${expert.name}`));
  }

  unregister(expertName) {
    if (expertName === 'Echo Chamber') {
      throw new Error('Cannot unregister fallback Echo expert');
    }
    
    this.experts.delete(expertName);
    console.log(chalk.yellow(`🗑️ Unregistered expert: ${expertName}`));
  }

  getExpert(name) {
    return this.experts.get(name);
  }

  getAllExperts() {
    return Array.from(this.experts.values());
  }

  getExpertsByCategory(category) {
    const expertNames = this.categories.get(category.toLowerCase()) || [];
    return expertNames.map(name => this.experts.get(name));
  }

  getHealthReport() {
    return Array.from(this.experts.values()).map(expert => expert.getHealthReport());
  }
}

/**
 * ⚡ Enhanced MOEX Framework Core
 */
class MOEXFramework {
  constructor() {
    this.registry = new ExpertRegistry();
    this.healthMonitor = new HealthMonitor(this.registry);
    this.isActive = false;
    this.totalRequests = 0;
    this.lastRequestTime = null;
  }

  async activate() {
    console.log(chalk.yellow('⚡ Activating Enhanced MOEX Framework...'));
    
    // Start health monitoring
    this.healthMonitor.start();
    
    // Run system diagnostics
    await this.runDiagnostics();
    
    this.isActive = true;
    console.log(chalk.green('✅ MOEX Framework fully activated!'));
    
    return this.getSystemStatus();
  }

  async runDiagnostics() {
    console.log(chalk.cyan('🔍 Running system diagnostics...'));
    
    const experts = this.registry.getAllExperts();
    const diagnostics = await Promise.allSettled(
      experts.map(async expert => {
        try {
          // Test each expert with a simple prompt
          await expert.getConfidenceScore('test diagnostic prompt');
          return { expert: expert.name, status: 'HEALTHY' };
        } catch (error) {
          return { expert: expert.name, status: 'FAILED', error: error.message };
        }
      })
    );
    
    diagnostics.forEach(result => {
      if (result.status === 'fulfilled') {
        const { expert, status } = result.value;
        const color = status === 'HEALTHY' ? chalk.green : chalk.red;
        console.log(color(`  ${status === 'HEALTHY' ? '✅' : '❌'} ${expert}: ${status}`));
      }
    });
  }

  async processRequest(prompt) {
    if (!this.isActive) {
      throw new Error('MOEX Framework not activated. Call activate() first.');
    }

    this.totalRequests++;
    this.lastRequestTime = Date.now();

    console.log(chalk.cyan(`\n⚡ MOEX Processing Request #${this.totalRequests}`));
    console.log(chalk.gray(`Prompt: "${prompt.slice(0, 80)}${prompt.length > 80 ? '...' : ''}"`));

    try {
      // Step 1: Parallel expert scoring
      const experts = this.registry.getAllExperts();
      const scores = await this.scoreExpertsInParallel(experts, prompt);
      
      // Step 2: Select best expert
      const bestExpert = this.selectBestExpert(scores);
      
      if (!bestExpert.expert) {
        throw new Error('No expert available to handle request');
      }

      console.log(chalk.yellow(`🎯 Selected: ${bestExpert.expert.name} (confidence: ${bestExpert.score.toFixed(2)})`));
      
      // Step 3: Process with selected expert
      const result = await bestExpert.expert.process(prompt);
      
      // Step 4: Enhance result with metadata
      return {
        ...result,
        metadata: {
          requestId: this.generateRequestId(),
          timestamp: new Date().toISOString(),
          processingTime: Date.now() - this.lastRequestTime,
          expertScores: scores.map(s => ({ expert: s.expert.name, score: s.score })),
          systemHealth: this.healthMonitor.getHealthSummary()
        }
      };

    } catch (error) {
      console.error(chalk.red(`❌ MOEX Processing Error: ${error.message}`));
      
      // Fallback to Echo expert
      const echoExpert = this.registry.getExpert('Echo Chamber');
      if (echoExpert) {
        return await echoExpert.process(prompt);
      }
      
      throw error;
    }
  }

  async scoreExpertsInParallel(experts, prompt) {
    const scoringPromises = experts.map(async expert => {
      try {
        const score = await expert.getConfidenceScore(prompt);
        return { expert, score };
      } catch (error) {
        console.log(chalk.red(`⚠️ Scoring failed for ${expert.name}: ${error.message}`));
        return { expert, score: 0 };
      }
    });

    return await Promise.all(scoringPromises);
  }

  selectBestExpert(scores) {
    let bestScore = -Infinity;
    let bestExpert = null;

    for (const { expert, score } of scores) {
      if (score > bestScore) {
        bestScore = score;
        bestExpert = expert;
      }
    }

    return { expert: bestExpert, score: bestScore };
  }

  generateRequestId() {
    return `moex_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
  }

  getSystemStatus() {
    return {
      active: this.isActive,
      totalRequests: this.totalRequests,
      lastRequestTime: this.lastRequestTime,
      expertsRegistered: this.registry.getAllExperts().length,
      expertHealth: this.registry.getHealthReport(),
      healthMonitor: this.healthMonitor.getStatus()
    };
  }

  async shutdown() {
    console.log(chalk.yellow('⚡ Shutting down MOEX Framework...'));
    this.healthMonitor.stop();
    this.isActive = false;
    console.log(chalk.gray('✅ MOEX Framework shutdown complete'));
  }
}

/**
 * 🏥 Health Monitor for System Reliability
 */
class HealthMonitor {
  constructor(registry) {
    this.registry = registry;
    this.isRunning = false;
    this.checkInterval = 30000; // 30 seconds
    this.intervalId = null;
    this.healthHistory = [];
  }

  start() {
    if (this.isRunning) return;
    
    console.log(chalk.cyan('🏥 Starting health monitor...'));
    this.isRunning = true;
    
    this.intervalId = setInterval(() => {
      this.performHealthCheck();
    }, this.checkInterval);
  }

  stop() {
    if (!this.isRunning) return;
    
    this.isRunning = false;
    if (this.intervalId) {
      clearInterval(this.intervalId);
      this.intervalId = null;
    }
    console.log(chalk.gray('🏥 Health monitor stopped'));
  }

  performHealthCheck() {
    const experts = this.registry.getAllExperts();
    const healthReport = {
      timestamp: new Date().toISOString(),
      totalExperts: experts.length,
      healthyExperts: 0,
      degradedExperts: 0,
      failedExperts: 0,
      experts: []
    };

    experts.forEach(expert => {
      const health = expert.getHealthReport();
      healthReport.experts.push(health);
      
      switch (health.health) {
        case HEALTH_STATUS.HEALTHY:
          healthReport.healthyExperts++;
          break;
        case HEALTH_STATUS.DEGRADED:
          healthReport.degradedExperts++;
          break;
        case HEALTH_STATUS.FAILED:
          healthReport.failedExperts++;
          break;
      }
    });

    // Store health history (keep last 10 checks)
    this.healthHistory.push(healthReport);
    if (this.healthHistory.length > 10) {
      this.healthHistory.shift();
    }

    // Alert on system health issues
    if (healthReport.failedExperts > 0) {
      console.log(chalk.red(`🚨 Health Alert: ${healthReport.failedExperts} experts failed`));
    }
  }

  getHealthSummary() {
    const latest = this.healthHistory[this.healthHistory.length - 1];
    if (!latest) return { status: 'NO_DATA' };

    const overallHealth = latest.failedExperts === 0 ? 
      (latest.degradedExperts === 0 ? 'HEALTHY' : 'DEGRADED') : 
      'CRITICAL';

    return {
      status: overallHealth,
      healthy: latest.healthyExperts,
      degraded: latest.degradedExperts,
      failed: latest.failedExperts,
      total: latest.totalExperts,
      lastCheck: latest.timestamp
    };
  }

  getStatus() {
    return {
      running: this.isRunning,
      checkInterval: this.checkInterval,
      historyLength: this.healthHistory.length,
      summary: this.getHealthSummary()
    };
  }
}

// 🚀 Export the enhanced framework
export {
  MOEXFramework,
  MOEXExpert,
  ExpertRegistry,
  DNAExpert,
  BugHunterExpert,
  TerminalExpert,
  EchoExpert,
  ExpertCircuitBreaker,
  HealthMonitor,
  CIRCUIT_STATES,
  HEALTH_STATUS
};

// 🎯 Default export for easy usage
export default MOEXFramework;

// 💫 Demo function for testing
export async function runMOEXDemo() {
  console.log(chalk.bold.yellow('\n🚀 MOEX Framework Enhanced Demo\n'));
  
  const moex = new MOEXFramework();
  
  try {
    // Activate framework
    await moex.activate();
    
    // Test various prompts
    const testPrompts = [
      'Help me transcribe this code to DNA sequence: function calculate() { return 42; }',
      'I have an error in my JavaScript code that keeps crashing',
      'What terminal command should I use to list files?',
      'This is a generic question about programming'
    ];
    
    for (const prompt of testPrompts) {
      console.log(chalk.cyan(`\n📝 Testing: "${prompt}"`));
      const result = await moex.processRequest(prompt);
      console.log(chalk.green(`✅ Result: ${result.analysis}`));
    }
    
    // Show system status
    console.log(chalk.yellow('\n📊 Final System Status:'));
    console.log(JSON.stringify(moex.getSystemStatus(), null, 2));
    
  } catch (error) {
    console.error(chalk.red(`❌ Demo Error: ${error.message}`));
  } finally {
    await moex.shutdown();
  }
}

// Run demo if this file is executed directly
if (import.meta.url === `file://${process.argv[1]}`) {
  runMOEXDemo();
}