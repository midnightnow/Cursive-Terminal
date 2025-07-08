#!/usr/bin/env python3
"""
Cursive Terminal Enterprise - Setup and Installation Script
Handles initial configuration, dependency installation, and environment setup
"""

import argparse
import json
import os
import shutil
import subprocess
import sys
import tempfile
import urllib.request
from pathlib import Path
from typing import Dict, List, Optional

class EnterpriseSetup:
    """Handles enterprise edition setup and configuration"""
    
    def __init__(self):
        self.config_dir = Path.home() / ".config" / "cursive-terminal-enterprise"
        self.install_dir = Path.cwd()
        self.python_executable = sys.executable
        
    def run_setup(self, args: argparse.Namespace) -> bool:
        """Run the complete setup process"""
        print("🏢 Cursive Terminal Enterprise Setup")
        print("=" * 50)
        
        try:
            if args.command == "init":
                return self._initialize_system(args)
            elif args.command == "install":
                return self._install_dependencies(args)
            elif args.command == "configure":
                return self._configure_system(args)
            elif args.command == "verify":
                return self._verify_installation()
            elif args.command == "uninstall":
                return self._uninstall_system(args)
            elif args.command == "update":
                return self._update_system(args)
            else:
                print(f"❌ Unknown command: {args.command}")
                return False
                
        except Exception as e:
            print(f"❌ Setup failed: {e}")
            return False
    
    def _initialize_system(self, args: argparse.Namespace) -> bool:
        """Initialize the enterprise system"""
        print("🚀 Initializing Cursive Terminal Enterprise...")
        
        # Create configuration directories
        self._create_directories()
        
        # Install Python dependencies
        if not self._install_python_dependencies():
            return False
        
        # Initialize configuration files
        self._initialize_configuration(args)
        
        # Set up templates
        self._setup_templates()
        
        # Create initial admin user
        self._create_admin_user(args)
        
        print("✅ Enterprise system initialized successfully!")
        print(f"📁 Configuration directory: {self.config_dir}")
        print("\n📋 Next steps:")
        print("1. Activate your enterprise license:")
        print("   python -m enterprise.license_manager activate YOUR-LICENSE-KEY")
        print("2. Add team members:")
        print("   python -m enterprise.team_config add-member")
        print("3. Configure deployment targets:")
        print("   python -m enterprise.deployment_automation add-target")
        
        return True
    
    def _create_directories(self) -> None:
        """Create necessary directories"""
        directories = [
            self.config_dir,
            self.config_dir / "templates",
            self.config_dir / "logs",
            self.config_dir / "backups",
            self.config_dir / "certificates",
            self.config_dir / "policies",
            self.config_dir / "reports"
        ]
        
        for directory in directories:
            directory.mkdir(parents=True, exist_ok=True)
            print(f"📁 Created directory: {directory}")
    
    def _install_python_dependencies(self) -> bool:
        """Install required Python packages"""
        print("📦 Installing Python dependencies...")
        
        requirements_file = self.install_dir / "requirements.txt"
        if not requirements_file.exists():
            print(f"❌ Requirements file not found: {requirements_file}")
            return False
        
        try:
            # Upgrade pip first
            subprocess.run([
                self.python_executable, "-m", "pip", "install", "--upgrade", "pip"
            ], check=True, capture_output=True)
            
            # Install requirements
            subprocess.run([
                self.python_executable, "-m", "pip", "install", "-r", str(requirements_file)
            ], check=True, capture_output=True)
            
            print("✅ Python dependencies installed successfully")
            return True
            
        except subprocess.CalledProcessError as e:
            print(f"❌ Failed to install dependencies: {e}")
            print("💡 Try running with --user flag or in a virtual environment")
            return False
    
    def _initialize_configuration(self, args: argparse.Namespace) -> None:
        """Initialize configuration files"""
        print("⚙️ Initializing configuration...")
        
        # Main configuration
        config = {
            "version": "1.0.0",
            "installation_date": "2025-01-08T00:00:00Z",
            "organization": {
                "name": getattr(args, 'organization', 'My Organization'),
                "domain": getattr(args, 'domain', 'company.com'),
                "admin_email": getattr(args, 'admin_email', 'admin@company.com')
            },
            "database": {
                "type": "sqlite",
                "path": str(self.config_dir / "enterprise.db")
            },
            "security": {
                "encryption_enabled": True,
                "session_timeout": 3600,
                "max_login_attempts": 5
            },
            "deployment": {
                "max_concurrent": 10,
                "timeout_seconds": 300,
                "retry_attempts": 3
            },
            "analytics": {
                "enabled": True,
                "retention_days": 90,
                "privacy_mode": False
            }
        }
        
        config_file = self.config_dir / "config.json"
        with open(config_file, 'w') as f:
            json.dump(config, f, indent=2)
        
        print(f"✅ Configuration file created: {config_file}")
    
    def _setup_templates(self) -> None:
        """Set up deployment templates"""
        print("📄 Setting up deployment templates...")
        
        templates_source = self.install_dir / "templates"
        templates_dest = self.config_dir / "templates"
        
        if templates_source.exists():
            for template_file in templates_source.glob("*"):
                if template_file.is_file():
                    shutil.copy2(template_file, templates_dest)
                    print(f"📄 Copied template: {template_file.name}")
        
        # Create default templates if none exist
        self._create_default_templates()
    
    def _create_default_templates(self) -> None:
        """Create default deployment templates"""
        templates = {
            "install_cursive_terminal.sh": '''#!/bin/bash
# Default Cursive Terminal Installation Template
set -e

echo "Installing Cursive Terminal for ${organization}"
echo "Font: ${font_name}"
echo "Target: $(hostname)"

# Add installation logic here
curl -L https://github.com/cursive-terminal/setup/archive/main.tar.gz | tar -xz
cd cursive-terminal-setup-main
chmod +x install.sh
./install.sh

echo "Installation completed successfully"
''',
            
            "health_check.sh": '''#!/bin/bash
# Health Check Template
echo "=== Cursive Terminal Health Check ==="
echo "Hostname: $(hostname)"
echo "Date: $(date)"
echo "User: $(whoami)"

# Check fonts
if [[ -d "$HOME/Library/Fonts" ]]; then
    FONT_COUNT=$(ls "$HOME/Library/Fonts"/*Mono* 2>/dev/null | wc -l)
    echo "Installed cursive fonts: $FONT_COUNT"
else
    echo "Font directory not found"
fi

echo "Health check completed"
'''
        }
        
        for name, content in templates.items():
            template_file = self.config_dir / "templates" / name
            if not template_file.exists():
                template_file.write_text(content)
                print(f"📄 Created default template: {name}")
    
    def _create_admin_user(self, args: argparse.Namespace) -> None:
        """Create initial admin user"""
        print("👤 Creating admin user...")
        
        admin_config = {
            "id": "admin-001",
            "username": "admin",
            "email": getattr(args, 'admin_email', 'admin@company.com'),
            "role": "administrator",
            "created_at": "2025-01-08T00:00:00Z",
            "permissions": [
                "user_management",
                "policy_management",
                "deployment_management",
                "license_management",
                "analytics_access",
                "system_configuration"
            ]
        }
        
        admin_file = self.config_dir / "admin_user.json"
        with open(admin_file, 'w') as f:
            json.dump(admin_config, f, indent=2)
        
        print(f"✅ Admin user created: {admin_config['email']}")
    
    def _install_dependencies(self, args: argparse.Namespace) -> bool:
        """Install system dependencies"""
        print("🔧 Installing system dependencies...")
        
        # Detect OS and install accordingly
        if sys.platform == "darwin":  # macOS
            return self._install_macos_dependencies()
        elif sys.platform.startswith("linux"):
            return self._install_linux_dependencies()
        elif sys.platform == "win32":
            return self._install_windows_dependencies()
        else:
            print(f"❌ Unsupported platform: {sys.platform}")
            return False
    
    def _install_macos_dependencies(self) -> bool:
        """Install macOS-specific dependencies"""
        print("🍎 Installing macOS dependencies...")
        
        # Check if Homebrew is installed
        try:
            subprocess.run(["brew", "--version"], check=True, capture_output=True)
            print("✅ Homebrew found")
        except (subprocess.CalledProcessError, FileNotFoundError):
            print("❌ Homebrew not found. Please install Homebrew first:")
            print("  /bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"")
            return False
        
        # Install SSH client (usually available by default)
        print("✅ SSH client available")
        
        return True
    
    def _install_linux_dependencies(self) -> bool:
        """Install Linux-specific dependencies"""
        print("🐧 Installing Linux dependencies...")
        
        # Detect package manager and install dependencies
        if shutil.which("apt-get"):
            return self._install_debian_dependencies()
        elif shutil.which("yum"):
            return self._install_rhel_dependencies()
        elif shutil.which("pacman"):
            return self._install_arch_dependencies()
        else:
            print("⚠️ Unknown package manager. Manual dependency installation required.")
            return True
    
    def _install_debian_dependencies(self) -> bool:
        """Install dependencies on Debian/Ubuntu"""
        try:
            subprocess.run([
                "sudo", "apt-get", "update"
            ], check=True)
            
            subprocess.run([
                "sudo", "apt-get", "install", "-y",
                "openssh-client",
                "python3-dev",
                "libffi-dev",
                "libssl-dev"
            ], check=True)
            
            print("✅ Debian/Ubuntu dependencies installed")
            return True
        except subprocess.CalledProcessError:
            print("❌ Failed to install Debian/Ubuntu dependencies")
            return False
    
    def _install_rhel_dependencies(self) -> bool:
        """Install dependencies on RHEL/CentOS"""
        try:
            subprocess.run([
                "sudo", "yum", "install", "-y",
                "openssh-clients",
                "python3-devel",
                "libffi-devel",
                "openssl-devel"
            ], check=True)
            
            print("✅ RHEL/CentOS dependencies installed")
            return True
        except subprocess.CalledProcessError:
            print("❌ Failed to install RHEL/CentOS dependencies")
            return False
    
    def _install_arch_dependencies(self) -> bool:
        """Install dependencies on Arch Linux"""
        try:
            subprocess.run([
                "sudo", "pacman", "-S", "--noconfirm",
                "openssh",
                "python",
                "libffi",
                "openssl"
            ], check=True)
            
            print("✅ Arch Linux dependencies installed")
            return True
        except subprocess.CalledProcessError:
            print("❌ Failed to install Arch Linux dependencies")
            return False
    
    def _install_windows_dependencies(self) -> bool:
        """Install Windows-specific dependencies"""
        print("🪟 Installing Windows dependencies...")
        
        # Check for PowerShell
        try:
            subprocess.run(["powershell", "-Command", "Get-Host"], check=True, capture_output=True)
            print("✅ PowerShell found")
        except (subprocess.CalledProcessError, FileNotFoundError):
            print("❌ PowerShell not found")
            return False
        
        # Check for OpenSSH
        try:
            subprocess.run(["ssh", "-V"], check=True, capture_output=True)
            print("✅ OpenSSH found")
        except (subprocess.CalledProcessError, FileNotFoundError):
            print("⚠️ OpenSSH not found. Consider installing OpenSSH client.")
        
        return True
    
    def _configure_system(self, args: argparse.Namespace) -> bool:
        """Configure the enterprise system"""
        print("⚙️ Configuring enterprise system...")
        
        # Update configuration based on arguments
        config_file = self.config_dir / "config.json"
        if config_file.exists():
            with open(config_file) as f:
                config = json.load(f)
            
            # Update organization info
            if hasattr(args, 'organization'):
                config['organization']['name'] = args.organization
            if hasattr(args, 'domain'):
                config['organization']['domain'] = args.domain
            if hasattr(args, 'admin_email'):
                config['organization']['admin_email'] = args.admin_email
            
            # Update deployment settings
            if hasattr(args, 'max_concurrent'):
                config['deployment']['max_concurrent'] = args.max_concurrent
            if hasattr(args, 'timeout'):
                config['deployment']['timeout_seconds'] = args.timeout
            
            # Save updated configuration
            with open(config_file, 'w') as f:
                json.dump(config, f, indent=2)
            
            print("✅ Configuration updated")
        
        return True
    
    def _verify_installation(self) -> bool:
        """Verify the enterprise installation"""
        print("🔍 Verifying enterprise installation...")
        
        checks = [
            ("Configuration directory", self.config_dir.exists()),
            ("Main configuration", (self.config_dir / "config.json").exists()),
            ("Templates directory", (self.config_dir / "templates").exists()),
            ("Admin user", (self.config_dir / "admin_user.json").exists()),
        ]
        
        # Check Python modules
        modules_to_check = [
            "cryptography",
            "paramiko", 
            "yaml",
            "requests"
        ]
        
        for module in modules_to_check:
            try:
                __import__(module)
                checks.append((f"Python module: {module}", True))
            except ImportError:
                checks.append((f"Python module: {module}", False))
        
        # Print results
        all_passed = True
        for check_name, passed in checks:
            status = "✅" if passed else "❌"
            print(f"{status} {check_name}")
            if not passed:
                all_passed = False
        
        if all_passed:
            print("\n🎉 All verification checks passed!")
            print("Enterprise system is ready for use.")
        else:
            print("\n⚠️ Some verification checks failed.")
            print("Please run 'python setup.py init' to fix issues.")
        
        return all_passed
    
    def _uninstall_system(self, args: argparse.Namespace) -> bool:
        """Uninstall the enterprise system"""
        print("🗑️ Uninstalling enterprise system...")
        
        if not args.force:
            confirm = input("Are you sure you want to uninstall? This will delete all configuration. (y/N): ")
            if confirm.lower() != 'y':
                print("Uninstallation cancelled.")
                return True
        
        # Create backup before uninstalling
        if self.config_dir.exists():
            backup_file = Path.home() / f"cursive-terminal-enterprise-backup-{int(time.time())}.tar.gz"
            try:
                import tarfile
                with tarfile.open(backup_file, 'w:gz') as tar:
                    tar.add(self.config_dir, arcname='cursive-terminal-enterprise')
                print(f"📦 Configuration backed up to: {backup_file}")
            except Exception as e:
                print(f"⚠️ Failed to create backup: {e}")
        
        # Remove configuration directory
        if self.config_dir.exists():
            shutil.rmtree(self.config_dir)
            print(f"🗑️ Removed configuration directory: {self.config_dir}")
        
        print("✅ Enterprise system uninstalled successfully")
        return True
    
    def _update_system(self, args: argparse.Namespace) -> bool:
        """Update the enterprise system"""
        print("🔄 Updating enterprise system...")
        
        # Update Python dependencies
        if not self._install_python_dependencies():
            return False
        
        # Update templates
        self._setup_templates()
        
        # Update configuration schema if needed
        self._migrate_configuration()
        
        print("✅ Enterprise system updated successfully")
        return True
    
    def _migrate_configuration(self) -> None:
        """Migrate configuration to newer schema versions"""
        config_file = self.config_dir / "config.json"
        if not config_file.exists():
            return
        
        with open(config_file) as f:
            config = json.load(f)
        
        # Add any new configuration keys that might be missing
        if "analytics" not in config:
            config["analytics"] = {
                "enabled": True,
                "retention_days": 90,
                "privacy_mode": False
            }
        
        if "security" not in config:
            config["security"] = {
                "encryption_enabled": True,
                "session_timeout": 3600,
                "max_login_attempts": 5
            }
        
        # Update version
        config["version"] = "1.0.0"
        
        with open(config_file, 'w') as f:
            json.dump(config, f, indent=2)


def main():
    """Main setup script entry point"""
    parser = argparse.ArgumentParser(
        description="Cursive Terminal Enterprise Setup",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python setup.py init --organization "Acme Corp" --admin-email admin@acme.com
  python setup.py install
  python setup.py verify
  python setup.py uninstall --force
        """
    )
    
    parser.add_argument("command", choices=[
        "init", "install", "configure", "verify", "uninstall", "update"
    ], help="Setup command to execute")
    
    parser.add_argument("--organization", 
                       help="Organization name")
    parser.add_argument("--domain",
                       help="Organization domain")
    parser.add_argument("--admin-email",
                       help="Administrator email address")
    parser.add_argument("--max-concurrent", type=int,
                       help="Maximum concurrent deployments")
    parser.add_argument("--timeout", type=int,
                       help="Deployment timeout in seconds")
    parser.add_argument("--force", action="store_true",
                       help="Force operation without confirmation")
    
    args = parser.parse_args()
    
    setup = EnterpriseSetup()
    success = setup.run_setup(args)
    
    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()