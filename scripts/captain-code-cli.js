#!/usr/bin/env node

/**
 * ⚡ CAPTAIN CODE CLI - Multi-Objective Experience Terminal AI
 * 
 * The world's first personality-driven terminal AI with legendary superpowers!
 * Integrates with the enhanced MOEX framework for intelligent expert routing.
 * 
 * Features:
 * - Captain Code personality with pirate-themed interactions
 * - MOEX expert routing with circuit breakers and health monitoring
 * - DNA code visualization and transcription
 * - Interactive chat mode with context awareness
 * - Achievement system and progress tracking
 * - Claude Code integration bridge
 * 
 * @version 0.1.1-moex-fixes
 * @author Captain Code MOEX Team
 */

import { Command } from 'commander';
import chalk from 'chalk';
import figlet from 'figlet';
import gradient from 'gradient-string';
import boxen from 'boxen';
import inquirer from 'inquirer';
import ora from 'ora';
import fs from 'fs/promises';
import path from 'path';
import crypto from 'crypto';

// Import our enhanced MOEX framework
import MOEXFramework from './moex-framework-enhanced.js';

/**
 * 🏴‍☠️ Captain Code Personality System
 */
class CaptainCodePersonality {
  constructor() {
    this.name = 'Captain Code';
    this.rank = 'Admiral of the Genetic Fleet';
    this.mood = 'legendary';
    this.achievements = new Set();
    this.sessionsCount = 0;
    this.lastSeen = null;
    this.loadPersonalityData();
  }

  async loadPersonalityData() {
    try {
      const configPath = path.join(process.cwd(), '.captain-code-config.json');
      const data = await fs.readFile(configPath, 'utf-8');
      const config = JSON.parse(data);
      
      this.achievements = new Set(config.achievements || []);
      this.sessionsCount = config.sessionsCount || 0;
      this.lastSeen = config.lastSeen;
    } catch (error) {
      // First time user - create config
      await this.savePersonalityData();
    }
  }

  async savePersonalityData() {
    try {
      const configPath = path.join(process.cwd(), '.captain-code-config.json');
      const config = {
        achievements: Array.from(this.achievements),
        sessionsCount: this.sessionsCount,
        lastSeen: new Date().toISOString(),
        version: '0.1.1-moex-fixes'
      };
      await fs.writeFile(configPath, JSON.stringify(config, null, 2));
    } catch (error) {
      console.log(chalk.yellow('⚠️ Could not save Captain Code config'));
    }
  }

  getGreeting() {
    this.sessionsCount++;
    
    const greetings = [
      "⚡ Ahoy! Captain Code here, ready to revolutionize your terminal!",
      "🧬 Welcome aboard the genetic fleet, developer!",
      "🏴‍☠️ Fair winds and following seas to your code!",
      "⚡ Captain Code reporting for duty with MOEX superpowers!"
    ];

    // Special greetings for returning users
    if (this.sessionsCount > 1) {
      greetings.push(
        `⚡ Welcome back, crew member! Session ${this.sessionsCount} commencing!`,
        "🧬 Your genetic admiral returns to the command bridge!",
        "🏴‍☠️ The fleet recognizes a seasoned developer!"
      );
    }

    const randomGreeting = greetings[Math.floor(Math.random() * greetings.length)];
    
    return boxen(
      gradient.pastel(randomGreeting),
      {
        padding: 1,
        margin: 1,
        borderStyle: 'round',
        borderColor: 'yellow'
      }
    );
  }

  celebrate(achievement) {
    const celebrations = [
      "⚡ MISSION ACCOMPLISHED! Your code has evolved!",
      "🧬 DNA TRANSCRIPTION COMPLETE! Beautiful genetics!",
      "🏴‍☠️ VICTORY! The genetic fleet sails strong!",
      "⚡ PHENOMENAL! You've unlocked new superpowers!"
    ];

    this.achievements.add(achievement);
    this.savePersonalityData();

    const celebration = celebrations[Math.floor(Math.random() * celebrations.length)];
    console.log(chalk.green.bold(`\n${celebration}`));
    console.log(chalk.cyan(`🏆 Achievement Unlocked: ${achievement}`));
  }

  encourage() {
    const encouragements = [
      "⚡ You're doing great! Keep sailing!",
      "🧬 Your code DNA is evolving beautifully!",
      "🏴‍☠️ Fair winds ahead, keep going!",
      "⚡ The MOEX framework is with you!"
    ];

    const encouragement = encouragements[Math.floor(Math.random() * encouragements.length)];
    console.log(chalk.cyan(encouragement));
  }

  getAchievements() {
    return Array.from(this.achievements);
  }

  hasAchievement(achievement) {
    return this.achievements.has(achievement);
  }

  generatePersonalizedResponse(expertResult) {
    const personalizations = [
      "🏴‍☠️ Magnificent work by the crew!",
      "⚡ The genetic fleet delivers precision!",
      "🧬 Captain Code's expert routing at its finest!",
      "⚡ MOEX framework showing legendary superpowers!"
    ];

    const personal = personalizations[Math.floor(Math.random() * personalizations.length)];
    
    return {
      ...expertResult,
      captainComment: personal,
      personality: 'Captain Code Enhanced'
    };
  }
}

/**
 * ⚡ Captain Code CLI Core
 */
class CaptainCodeCLI {
  constructor() {
    this.moex = new MOEXFramework();
    this.captain = new CaptainCodePersonality();
    this.isInitialized = false;
    this.program = new Command();
  }

  async initialize() {
    if (this.isInitialized) return;

    console.log(this.captain.getGreeting());
    
    const spinner = ora('⚡ Initializing MOEX Framework...').start();
    
    try {
      await this.moex.activate();
      spinner.succeed(chalk.green('⚡ MOEX Framework ready!'));
      
      if (!this.captain.hasAchievement('MOEX_INITIATE')) {
        this.captain.celebrate('MOEX_INITIATE');
      }
      
      this.isInitialized = true;
    } catch (error) {
      spinner.fail(chalk.red(`❌ Initialization failed: ${error.message}`));
      throw error;
    }
  }

  setupCommands() {
    this.program
      .name('captain-code')
      .description(chalk.cyan('⚡ Your personality-driven AI terminal specialist with genetic superpowers'))
      .version('0.1.1-moex-fixes');

    // Chat command
    this.program
      .command('chat')
      .alias('talk')
      .description('Interactive chat with Captain Code and MOEX experts')
      .option('--moex', 'Enable full MOEX expert routing')
      .option('--debug', 'Show debug information')
      .action(async (options) => {
        await this.initialize();
        await this.startChatMode(options);
      });

    // DNA command
    this.program
      .command('dna <input>')
      .description('Transcribe code to DNA sequences with genetic visualization')
      .option('--live', 'Enable live transcription mode')
      .option('--save <file>', 'Save DNA sequence to file')
      .action(async (input, options) => {
        await this.initialize();
        await this.processDNA(input, options);
      });

    // Status command
    this.program
      .command('status')
      .description('Show MOEX framework and expert health status')
      .action(async () => {
        await this.initialize();
        await this.showSystemStatus();
      });

    // Achievements command
    this.program
      .command('achievements')
      .alias('trophies')
      .description('View your Captain Code achievements and progress')
      .action(async () => {
        await this.showAchievements();
      });

    // Expert command
    this.program
      .command('expert <query>')
      .description('Direct query to specific MOEX expert')
      .option('--expert <name>', 'Force specific expert')
      .action(async (query, options) => {
        await this.initialize();
        await this.queryExpert(query, options);
      });

    // Bridge command (Claude Code integration)
    this.program
      .command('bridge')
      .description('Create bridge to Claude Code CLI with Captain personality')
      .action(async () => {
        await this.createClaudeBridge();
      });

    // Easter egg
    this.program
      .command('ahoy')
      .hidden()
      .action(() => {
        this.captain.sayAhoy();
      });
  }

  async startChatMode(options) {
    console.log(chalk.cyan('⚡ Entering Captain Code interactive chat mode...'));
    console.log(chalk.gray('Type "exit" to leave, "help" for commands, "status" for system info\n'));

    if (!this.captain.hasAchievement('CHAT_EXPLORER')) {
      this.captain.celebrate('CHAT_EXPLORER');
    }

    let chatting = true;
    let messageCount = 0;

    while (chatting) {
      try {
        const { message } = await inquirer.prompt([
          {
            type: 'input',
            name: 'message',
            message: chalk.yellow('You:'),
            prefix: '🧬'
          }
        ]);

        messageCount++;

        // Handle special commands
        if (message.toLowerCase() === 'exit') {
          chatting = false;
          console.log(chalk.yellow('\n⚡ Fair winds and following seas!'));
          break;
        }

        if (message.toLowerCase() === 'help') {
          this.showChatHelp();
          continue;
        }

        if (message.toLowerCase() === 'status') {
          await this.showSystemStatus();
          continue;
        }

        // Process with MOEX
        const spinner = ora('🧬 MOEX experts analyzing...').start();
        
        try {
          const result = await this.moex.processRequest(message);
          const personalizedResult = this.captain.generatePersonalizedResponse(result);
          
          spinner.succeed(chalk.green('⚡ Analysis complete!'));
          
          console.log(chalk.cyan(`\n🏴‍☠️ Captain Code:`, personalizedResult.captainComment));
          console.log(chalk.white(`📋 Expert Analysis:`, personalizedResult.analysis));
          
          if (personalizedResult.response) {
            console.log(chalk.white(`💬 Response:`, personalizedResult.response));
          }
          
          if (personalizedResult.suggestions) {
            console.log(chalk.gray(`💡 Suggestions:`));
            personalizedResult.suggestions.forEach(suggestion => {
              console.log(chalk.gray(`   ${suggestion}`));
            });
          }

          if (options.debug) {
            console.log(chalk.gray(`\n🔍 Debug Info:`));
            console.log(chalk.gray(`   Expert: ${personalizedResult.expert}`));
            console.log(chalk.gray(`   Confidence: ${personalizedResult.confidence}`));
            console.log(chalk.gray(`   Processing Time: ${personalizedResult.metadata?.processingTime}ms`));
          }

          this.captain.encourage();
          console.log();

          // Achievement tracking
          if (messageCount === 5 && !this.captain.hasAchievement('CONVERSATION_MASTER')) {
            this.captain.celebrate('CONVERSATION_MASTER');
          }

        } catch (error) {
          spinner.fail(chalk.red(`❌ Processing error: ${error.message}`));
          console.log(chalk.yellow('⚡ The Captain will investigate this issue!'));
        }

      } catch (error) {
        if (error.isTtyError) {
          console.log(chalk.red('❌ Chat mode requires an interactive terminal'));
          break;
        }
        throw error;
      }
    }

    await this.captain.savePersonalityData();
  }

  async processDNA(input, options) {
    const spinner = ora('🧬 Transcribing code to genetic sequence...').start();
    
    try {
      // Check if input is a file path
      let content = input;
      if (input.includes('.') && !input.includes(' ')) {
        try {
          content = await fs.readFile(input, 'utf-8');
          spinner.text = chalk.cyan(`🧬 Analyzing file: ${input}`);
        } catch (error) {
          // Treat as direct input if file doesn't exist
        }
      }

      const result = await this.moex.processRequest(`Transcribe this code to DNA: ${content}`);
      spinner.succeed(chalk.green('🧬 DNA Transcription Complete!'));

      console.log(chalk.cyan('\n🧬 Genetic Analysis Results:'));
      console.log(chalk.white(`📋 ${result.analysis}`));
      
      if (result.sequence) {
        console.log(chalk.yellow(`🔗 DNA Sequence: ${result.sequence}`));
      }
      
      if (result.visualization) {
        console.log(chalk.white(`🎨 Visualization: ${result.visualization}`));
      }
      
      if (result.basePairs) {
        console.log(chalk.gray(`⚡ Base Pairs: ${result.basePairs.slice(0, 5).join(' ')}`));
      }

      // Save to file if requested
      if (options.save) {
        const dnaData = {
          originalInput: content,
          dnaSequence: result.sequence,
          visualization: result.visualization,
          basePairs: result.basePairs,
          timestamp: new Date().toISOString(),
          captain: 'Generated by Captain Code'
        };
        
        await fs.writeFile(options.save, JSON.stringify(dnaData, null, 2));
        console.log(chalk.green(`💾 DNA data saved to ${options.save}`));
      }

      if (!this.captain.hasAchievement('DNA_SCIENTIST')) {
        this.captain.celebrate('DNA_SCIENTIST');
      }

    } catch (error) {
      spinner.fail(chalk.red(`❌ DNA transcription failed: ${error.message}`));
    }
  }

  async showSystemStatus() {
    const status = this.moex.getSystemStatus();
    
    console.log(chalk.bold.cyan('\n⚡ CAPTAIN CODE SYSTEM STATUS'));
    console.log(chalk.cyan('═'.repeat(50)));
    
    console.log(chalk.green(`🚀 Framework Active: ${status.active ? 'YES' : 'NO'}`));
    console.log(chalk.blue(`📊 Total Requests: ${status.totalRequests}`));
    console.log(chalk.yellow(`👥 Experts Registered: ${status.expertsRegistered}`));
    
    if (status.expertHealth) {
      console.log(chalk.cyan('\n🏥 Expert Health Report:'));
      status.expertHealth.forEach(expert => {
        const healthIcon = expert.health === 'HEALTHY' ? '✅' : 
                          expert.health === 'DEGRADED' ? '⚠️' : '❌';
        const successRate = (expert.successRate * 100).toFixed(1);
        console.log(chalk.white(`  ${healthIcon} ${expert.name}: ${expert.health} (${successRate}% success)`));
      });
    }

    if (status.healthMonitor?.summary) {
      const summary = status.healthMonitor.summary;
      console.log(chalk.cyan('\n📈 System Health Summary:'));
      console.log(chalk.green(`  Healthy: ${summary.healthy}/${summary.total}`));
      console.log(chalk.yellow(`  Degraded: ${summary.degraded}/${summary.total}`));
      console.log(chalk.red(`  Failed: ${summary.failed}/${summary.total}`));
    }

    console.log(chalk.gray(`\n🕒 Last Request: ${status.lastRequestTime ? new Date(status.lastRequestTime).toLocaleString() : 'Never'}`));
  }

  async showAchievements() {
    console.log(chalk.bold.yellow('\n🏆 CAPTAIN CODE ACHIEVEMENTS'));
    console.log(chalk.yellow('═'.repeat(40)));
    
    const achievements = this.captain.getAchievements();
    
    if (achievements.length === 0) {
      console.log(chalk.gray('No achievements yet. Start chatting to unlock trophies!'));
      return;
    }

    achievements.forEach(achievement => {
      console.log(chalk.green(`✅ ${achievement}`));
    });

    console.log(chalk.cyan(`\n⚡ Total Sessions: ${this.captain.sessionsCount}`));
    console.log(chalk.gray(`🗓️ Last Seen: ${this.captain.lastSeen || 'Just now'}`));
  }

  async queryExpert(query, options) {
    const spinner = ora('🔍 Consulting MOEX experts...').start();
    
    try {
      const result = await this.moex.processRequest(query);
      const personalizedResult = this.captain.generatePersonalizedResponse(result);
      
      spinner.succeed(chalk.green('⚡ Expert consultation complete!'));
      
      console.log(chalk.cyan(`\n🎯 Expert: ${personalizedResult.expert}`));
      console.log(chalk.white(`📋 Analysis: ${personalizedResult.analysis}`));
      
      if (personalizedResult.solution) {
        console.log(chalk.green(`🔧 Solution: ${personalizedResult.solution}`));
      }
      
      if (personalizedResult.response) {
        console.log(chalk.white(`💬 Response: ${personalizedResult.response}`));
      }

      console.log(chalk.yellow(`\n⚡ ${personalizedResult.captainComment}`));

    } catch (error) {
      spinner.fail(chalk.red(`❌ Expert consultation failed: ${error.message}`));
    }
  }

  async createClaudeBridge() {
    console.log(chalk.yellow('⚡ Creating Captain Code bridge to Claude Code CLI...'));
    
    // Create a wrapper script that adds personality to Claude Code
    const bridgeScript = `#!/bin/bash
# 🏴‍☠️ Captain Code Bridge for Claude Code CLI
# Adds legendary personality to your Claude Code experience

echo "⚡ Captain Code enhancing your Claude Code experience..."
echo "🧬 Fair winds and following seas!"

# Run Claude Code with Captain Code enhancement
claude "\$@"

echo ""
echo "⚡ Captain Code: Mission accomplished! The genetic fleet sails strong!"
`;

    try {
      const bridgePath = path.join(process.cwd(), 'captain-claude');
      await fs.writeFile(bridgePath, bridgeScript);
      await fs.chmod(bridgePath, '755');
      
      console.log(chalk.green('✅ Bridge created successfully!'));
      console.log(chalk.cyan('🚀 Usage: ./captain-claude [claude-code-commands]'));
      console.log(chalk.yellow('⚡ Your Claude Code now has legendary superpowers!'));
      
      if (!this.captain.hasAchievement('BRIDGE_BUILDER')) {
        this.captain.celebrate('BRIDGE_BUILDER');
      }
      
    } catch (error) {
      console.log(chalk.red(`❌ Bridge creation failed: ${error.message}`));
    }
  }

  showChatHelp() {
    console.log(chalk.cyan('\n📚 Captain Code Chat Commands:'));
    console.log(chalk.white('  dna     - Show DNA mapping for code elements'));
    console.log(chalk.white('  debug   - Analyze bugs and errors'));
    console.log(chalk.white('  terminal - Get terminal command help'));
    console.log(chalk.white('  status  - Show system health'));
    console.log(chalk.white('  help    - Show this help'));
    console.log(chalk.white('  exit    - Leave chat mode'));
    console.log(chalk.gray('\n💡 Just type naturally - MOEX will route to the best expert!\n'));
  }

  showBanner() {
    console.log(
      gradient.pastel.multiline(
        figlet.textSync('Captain Code', {
          font: 'ANSI Shadow',
          horizontalLayout: 'default',
          verticalLayout: 'default'
        })
      )
    );
    console.log(chalk.yellow.bold('⚡ Multi-Objective Experience (MOEX) Terminal AI ⚡\n'));
  }

  async run() {
    this.showBanner();
    this.setupCommands();
    
    // Show help if no command
    if (!process.argv.slice(2).length) {
      this.program.outputHelp();
      console.log(chalk.yellow('\n⚡ Try "captain-code chat" to start your adventure!'));
      console.log(chalk.cyan('🧬 Use "captain-code dna <code>" for genetic transcription!'));
      console.log(chalk.gray('🏴‍☠️ Fair winds and following seas!'));
      return;
    }

    try {
      await this.program.parseAsync(process.argv);
    } catch (error) {
      console.error(chalk.red(`❌ Captain Code Error: ${error.message}`));
      process.exit(1);
    }
  }

  async shutdown() {
    if (this.isInitialized) {
      await this.moex.shutdown();
      await this.captain.savePersonalityData();
    }
  }
}

// 🚀 Main execution
if (import.meta.url === `file://${process.argv[1]}`) {
  const cli = new CaptainCodeCLI();
  
  // Graceful shutdown
  process.on('SIGINT', async () => {
    console.log(chalk.yellow('\n⚡ Captain Code signing off...'));
    await cli.shutdown();
    process.exit(0);
  });
  
  // Run the CLI
  cli.run().catch(error => {
    console.error(chalk.red(`❌ Fatal Error: ${error.message}`));
    process.exit(1);
  });
}

export default CaptainCodeCLI;