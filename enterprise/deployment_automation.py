#!/usr/bin/env python3
"""
Cursive Terminal - Enterprise Deployment Automation
Automates large-scale deployments with parallel processing and monitoring
"""

import asyncio
import json
import os
import subprocess
import tempfile
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import datetime, timezone
from pathlib import Path
from typing import Dict, List, Optional, Any, Callable, Tuple
import uuid
import paramiko
import psutil
import time
from dataclasses import dataclass, asdict
from enum import Enum

class DeploymentStatus(Enum):
    PENDING = "pending"
    RUNNING = "running"
    SUCCESS = "success"
    FAILED = "failed"
    CANCELLED = "cancelled"
    TIMEOUT = "timeout"

class DeploymentMethod(Enum):
    SSH = "ssh"
    ANSIBLE = "ansible"
    PUPPET = "puppet"
    CHEF = "chef"
    POWERSHELL = "powershell"
    LOCAL_SCRIPT = "local_script"

@dataclass
class Target:
    """Represents a deployment target machine"""
    id: str
    hostname: str
    ip_address: str
    os_type: str  # macos, linux, windows
    architecture: str  # x64, arm64
    ssh_user: Optional[str] = None
    ssh_key_path: Optional[str] = None
    ssh_port: int = 22
    tags: List[str] = None
    metadata: Dict[str, Any] = None

@dataclass
class DeploymentTask:
    """Represents a single deployment task"""
    id: str
    target_id: str
    deployment_id: str
    method: DeploymentMethod
    script_content: str
    status: DeploymentStatus
    started_at: Optional[str] = None
    completed_at: Optional[str] = None
    output: str = ""
    error: str = ""
    exit_code: Optional[int] = None
    retry_count: int = 0
    max_retries: int = 3

@dataclass
class Deployment:
    """Represents a complete deployment operation"""
    id: str
    name: str
    description: str
    targets: List[str]  # Target IDs
    method: DeploymentMethod
    script_template: str
    variables: Dict[str, Any]
    status: DeploymentStatus
    created_at: str
    started_at: Optional[str] = None
    completed_at: Optional[str] = None
    success_count: int = 0
    failure_count: int = 0
    timeout_seconds: int = 300
    parallel_limit: int = 10
    tasks: List[DeploymentTask] = None

class DeploymentEngine:
    """Main deployment automation engine"""
    
    def __init__(self, config_dir: str = "~/.config/cursive-terminal-enterprise"):
        self.config_dir = Path(config_dir).expanduser()
        self.config_dir.mkdir(parents=True, exist_ok=True)
        
        # Storage files
        self.targets_file = self.config_dir / "deployment_targets.json"
        self.deployments_file = self.config_dir / "deployments.json"
        self.templates_dir = self.config_dir / "deployment_templates"
        self.templates_dir.mkdir(exist_ok=True)
        
        # Load data
        self.targets = self._load_targets()
        self.deployments = self._load_deployments()
        
        # Runtime state
        self.active_deployments = {}
        self.executor = ThreadPoolExecutor(max_workers=20)
        
        # SSH connection pool
        self.ssh_connections = {}
        
        # Create default templates
        self._create_default_templates()
    
    def _load_targets(self) -> List[Target]:
        """Load deployment targets"""
        if self.targets_file.exists():
            try:
                with open(self.targets_file) as f:
                    data = json.load(f)
                    return [Target(**target) for target in data]
            except Exception as e:
                print(f"Error loading targets: {e}")
        return []
    
    def _save_targets(self) -> None:
        """Save deployment targets"""
        with open(self.targets_file, 'w') as f:
            json.dump([asdict(target) for target in self.targets], f, indent=2)
    
    def _load_deployments(self) -> List[Deployment]:
        """Load deployment history"""
        if self.deployments_file.exists():
            try:
                with open(self.deployments_file) as f:
                    data = json.load(f)
                    deployments = []
                    for deploy_data in data:
                        if 'tasks' in deploy_data and deploy_data['tasks']:
                            deploy_data['tasks'] = [DeploymentTask(**task) for task in deploy_data['tasks']]
                        deployment = Deployment(**deploy_data)
                        deployment.method = DeploymentMethod(deployment.method)
                        deployment.status = DeploymentStatus(deployment.status)
                        deployments.append(deployment)
                    return deployments
            except Exception as e:
                print(f"Error loading deployments: {e}")
        return []
    
    def _save_deployments(self) -> None:
        """Save deployment history"""
        deployments_data = []
        for deployment in self.deployments:
            deploy_dict = asdict(deployment)
            deploy_dict['method'] = deployment.method.value
            deploy_dict['status'] = deployment.status.value
            if deploy_dict['tasks']:
                for task in deploy_dict['tasks']:
                    task['method'] = task['method'].value if hasattr(task['method'], 'value') else task['method']
                    task['status'] = task['status'].value if hasattr(task['status'], 'value') else task['status']
            deployments_data.append(deploy_dict)
        
        with open(self.deployments_file, 'w') as f:
            json.dump(deployments_data, f, indent=2)
    
    def _create_default_templates(self) -> None:
        """Create default deployment templates"""
        templates = {
            "cursive_terminal_install.sh": """#!/bin/bash
# Cursive Terminal Installation Script
set -e

echo "Starting Cursive Terminal installation on $(hostname)"

# Variables (will be replaced by deployment engine)
FONT_NAME="${font_name:-Victor Mono}"
TERMINAL_APP="${terminal_app:-auto}"
ORGANIZATION="${organization:-Default}"

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi

echo "Detected OS: $OS"

# Download cursive terminal setup
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

if command -v curl >/dev/null 2>&1; then
    curl -L -o cursive-terminal.tar.gz "https://github.com/cursive-terminal/setup/archive/main.tar.gz"
elif command -v wget >/dev/null 2>&1; then
    wget -O cursive-terminal.tar.gz "https://github.com/cursive-terminal/setup/archive/main.tar.gz"
else
    echo "Neither curl nor wget found"
    exit 1
fi

tar -xzf cursive-terminal.tar.gz
cd cursive-terminal-setup-main

# Make scripts executable
chmod +x scripts/*.sh

# Run installation
if [[ "$OS" == "macos" ]]; then
    ./scripts/install_macos.sh
elif [[ "$OS" == "linux" ]]; then
    ./scripts/install_linux.sh
fi

# Configure font
echo "Configuring font: $FONT_NAME"
if [[ -f "scripts/configure_font.sh" ]]; then
    ./scripts/configure_font.sh "$FONT_NAME" "$TERMINAL_APP"
fi

# Cleanup
cd /
rm -rf "$TEMP_DIR"

echo "Cursive Terminal installation completed successfully"
""",

            "uninstall_cursive_terminal.sh": """#!/bin/bash
# Cursive Terminal Uninstallation Script
set -e

echo "Starting Cursive Terminal uninstallation on $(hostname)"

# Remove fonts
if [[ "$OSTYPE" == "darwin"* ]]; then
    FONT_DIR="$HOME/Library/Fonts"
    rm -f "$FONT_DIR"/VictorMono-*.otf
    rm -f "$FONT_DIR"/CascadiaCode-*.ttf
    rm -f "$FONT_DIR"/JetBrainsMono-*.ttf
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    FONT_DIR="$HOME/.local/share/fonts"
    rm -f "$FONT_DIR"/VictorMono-*.otf
    rm -f "$FONT_DIR"/CascadiaCode-*.ttf
    rm -f "$FONT_DIR"/JetBrainsMono-*.ttf
    fc-cache -f -v
fi

# Remove configuration
rm -rf "$HOME/.config/cursive-terminal"
rm -rf "$HOME/.cursive-terminal"

echo "Cursive Terminal uninstallation completed"
""",

            "update_team_config.py": """#!/usr/bin/env python3
# Team Configuration Update Script

import json
import os
import sys
from pathlib import Path

def update_team_config():
    # Variables (will be replaced by deployment engine)
    config_data = ${team_config_json}
    
    config_dir = Path.home() / ".config" / "cursive-terminal-enterprise"
    config_dir.mkdir(parents=True, exist_ok=True)
    
    config_file = config_dir / "team_config.json"
    
    # Backup existing config
    if config_file.exists():
        backup_file = config_dir / f"team_config.backup.{int(time.time())}.json"
        config_file.rename(backup_file)
        print(f"Backed up existing config to {backup_file}")
    
    # Write new config
    with open(config_file, 'w') as f:
        json.dump(config_data, f, indent=2)
    
    print(f"Team configuration updated: {config_file}")

if __name__ == "__main__":
    update_team_config()
""",

            "health_check.sh": """#!/bin/bash
# Cursive Terminal Health Check Script

echo "Cursive Terminal Health Check Report"
echo "===================================="
echo "Hostname: $(hostname)"
echo "Date: $(date)"
echo "User: $(whoami)"
echo ""

# Check OS
echo "Operating System:"
if [[ "$OSTYPE" == "darwin"* ]]; then
    sw_vers
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    cat /etc/os-release | head -5
fi
echo ""

# Check fonts
echo "Installed Cursive Fonts:"
if [[ "$OSTYPE" == "darwin"* ]]; then
    FONT_DIR="$HOME/Library/Fonts"
else
    FONT_DIR="$HOME/.local/share/fonts"
fi

FOUND_FONTS=0
for font in "VictorMono" "CascadiaCode" "JetBrainsMono"; do
    if ls "$FONT_DIR"/*$font* >/dev/null 2>&1; then
        echo "  ✓ $font found"
        FOUND_FONTS=$((FOUND_FONTS + 1))
    else
        echo "  ✗ $font not found"
    fi
done

echo "Total fonts found: $FOUND_FONTS"
echo ""

# Check terminal
echo "Terminal Detection:"
if [[ -n "$TERM_PROGRAM" ]]; then
    echo "  Terminal: $TERM_PROGRAM"
    if [[ -n "$TERM_PROGRAM_VERSION" ]]; then
        echo "  Version: $TERM_PROGRAM_VERSION"
    fi
else
    echo "  Terminal: Unknown"
fi

# Check configuration
echo ""
echo "Configuration Status:"
CONFIG_DIR="$HOME/.config/cursive-terminal"
if [[ -d "$CONFIG_DIR" ]]; then
    echo "  ✓ Configuration directory exists"
    if [[ -f "$CONFIG_DIR/settings.json" ]]; then
        echo "  ✓ Settings file exists"
    else
        echo "  ✗ Settings file missing"
    fi
else
    echo "  ✗ Configuration directory missing"
fi

echo ""
echo "Health check completed"
"""
        }
        
        for filename, content in templates.items():
            template_file = self.templates_dir / filename
            if not template_file.exists():
                template_file.write_text(content)
    
    def add_target(self, hostname: str, ip_address: str, os_type: str,
                   architecture: str = "x64", ssh_user: str = None,
                   ssh_key_path: str = None, tags: List[str] = None,
                   metadata: Dict[str, Any] = None) -> Target:
        """Add a deployment target"""
        target = Target(
            id=str(uuid.uuid4()),
            hostname=hostname,
            ip_address=ip_address,
            os_type=os_type,
            architecture=architecture,
            ssh_user=ssh_user,
            ssh_key_path=ssh_key_path,
            tags=tags or [],
            metadata=metadata or {}
        )
        
        self.targets.append(target)
        self._save_targets()
        return target
    
    def remove_target(self, target_id: str) -> bool:
        """Remove a deployment target"""
        for i, target in enumerate(self.targets):
            if target.id == target_id:
                self.targets.pop(i)
                self._save_targets()
                return True
        return False
    
    def get_targets_by_tags(self, tags: List[str]) -> List[Target]:
        """Get targets that match any of the specified tags"""
        matching_targets = []
        for target in self.targets:
            if any(tag in target.tags for tag in tags):
                matching_targets.append(target)
        return matching_targets
    
    def create_deployment(self, name: str, description: str,
                         target_ids: List[str], method: DeploymentMethod,
                         script_template: str, variables: Dict[str, Any] = None,
                         timeout_seconds: int = 300,
                         parallel_limit: int = 10) -> Deployment:
        """Create a new deployment"""
        deployment = Deployment(
            id=str(uuid.uuid4()),
            name=name,
            description=description,
            targets=target_ids,
            method=method,
            script_template=script_template,
            variables=variables or {},
            status=DeploymentStatus.PENDING,
            created_at=datetime.now(timezone.utc).isoformat(),
            timeout_seconds=timeout_seconds,
            parallel_limit=parallel_limit,
            tasks=[]
        )
        
        # Create tasks for each target
        for target_id in target_ids:
            task = DeploymentTask(
                id=str(uuid.uuid4()),
                target_id=target_id,
                deployment_id=deployment.id,
                method=method,
                script_content=self._render_script(script_template, variables),
                status=DeploymentStatus.PENDING
            )
            deployment.tasks.append(task)
        
        self.deployments.append(deployment)
        self._save_deployments()
        return deployment
    
    def _render_script(self, template: str, variables: Dict[str, Any]) -> str:
        """Render script template with variables"""
        script = template
        for key, value in variables.items():
            if isinstance(value, dict) or isinstance(value, list):
                # For complex data, use JSON encoding
                placeholder = f"${{{key}}}"
                script = script.replace(placeholder, json.dumps(value))
            else:
                # For simple values, direct replacement
                placeholder = f"${{{key}}}"
                script = script.replace(placeholder, str(value))
        return script
    
    async def execute_deployment(self, deployment_id: str,
                                progress_callback: Callable[[str, Dict], None] = None) -> bool:
        """Execute a deployment asynchronously"""
        deployment = self.get_deployment(deployment_id)
        if not deployment:
            return False
        
        deployment.status = DeploymentStatus.RUNNING
        deployment.started_at = datetime.now(timezone.utc).isoformat()
        self._save_deployments()
        
        self.active_deployments[deployment_id] = deployment
        
        try:
            # Execute tasks in parallel with limit
            semaphore = asyncio.Semaphore(deployment.parallel_limit)
            tasks = []
            
            for task in deployment.tasks:
                task_coroutine = self._execute_task(task, semaphore, progress_callback)
                tasks.append(asyncio.create_task(task_coroutine))
            
            # Wait for all tasks to complete
            results = await asyncio.gather(*tasks, return_exceptions=True)
            
            # Count successes and failures
            deployment.success_count = 0
            deployment.failure_count = 0
            
            for i, result in enumerate(results):
                if isinstance(result, Exception):
                    deployment.tasks[i].status = DeploymentStatus.FAILED
                    deployment.tasks[i].error = str(result)
                    deployment.failure_count += 1
                elif result:
                    deployment.tasks[i].status = DeploymentStatus.SUCCESS
                    deployment.success_count += 1
                else:
                    deployment.tasks[i].status = DeploymentStatus.FAILED
                    deployment.failure_count += 1
            
            # Determine overall status
            if deployment.failure_count == 0:
                deployment.status = DeploymentStatus.SUCCESS
            elif deployment.success_count == 0:
                deployment.status = DeploymentStatus.FAILED
            else:
                deployment.status = DeploymentStatus.SUCCESS  # Partial success
            
            deployment.completed_at = datetime.now(timezone.utc).isoformat()
            
        except Exception as e:
            deployment.status = DeploymentStatus.FAILED
            deployment.completed_at = datetime.now(timezone.utc).isoformat()
            print(f"Deployment failed: {e}")
        
        finally:
            self._save_deployments()
            if deployment_id in self.active_deployments:
                del self.active_deployments[deployment_id]
        
        return deployment.status == DeploymentStatus.SUCCESS
    
    async def _execute_task(self, task: DeploymentTask, semaphore: asyncio.Semaphore,
                           progress_callback: Callable[[str, Dict], None] = None) -> bool:
        """Execute a single deployment task"""
        async with semaphore:
            target = self.get_target(task.target_id)
            if not target:
                task.error = "Target not found"
                return False
            
            task.status = DeploymentStatus.RUNNING
            task.started_at = datetime.now(timezone.utc).isoformat()
            
            if progress_callback:
                progress_callback("task_started", {
                    "task_id": task.id,
                    "target": target.hostname,
                    "status": task.status.value
                })
            
            try:
                success = await self._execute_task_method(task, target)
                
                if success:
                    task.status = DeploymentStatus.SUCCESS
                else:
                    task.status = DeploymentStatus.FAILED
                
                task.completed_at = datetime.now(timezone.utc).isoformat()
                
                if progress_callback:
                    progress_callback("task_completed", {
                        "task_id": task.id,
                        "target": target.hostname,
                        "status": task.status.value,
                        "success": success
                    })
                
                return success
                
            except Exception as e:
                task.status = DeploymentStatus.FAILED
                task.error = str(e)
                task.completed_at = datetime.now(timezone.utc).isoformat()
                
                if progress_callback:
                    progress_callback("task_failed", {
                        "task_id": task.id,
                        "target": target.hostname,
                        "error": str(e)
                    })
                
                return False
    
    async def _execute_task_method(self, task: DeploymentTask, target: Target) -> bool:
        """Execute task using the specified method"""
        if task.method == DeploymentMethod.SSH:
            return await self._execute_ssh_task(task, target)
        elif task.method == DeploymentMethod.LOCAL_SCRIPT:
            return await self._execute_local_script_task(task, target)
        elif task.method == DeploymentMethod.ANSIBLE:
            return await self._execute_ansible_task(task, target)
        else:
            task.error = f"Unsupported deployment method: {task.method}"
            return False
    
    async def _execute_ssh_task(self, task: DeploymentTask, target: Target) -> bool:
        """Execute task via SSH"""
        try:
            # Create SSH client
            ssh = paramiko.SSHClient()
            ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            
            # Connect
            if target.ssh_key_path:
                key = paramiko.RSAKey.from_private_key_file(target.ssh_key_path)
                ssh.connect(
                    target.ip_address,
                    port=target.ssh_port,
                    username=target.ssh_user,
                    pkey=key,
                    timeout=30
                )
            else:
                # For demo purposes - in production, always use key auth
                ssh.connect(
                    target.ip_address,
                    port=target.ssh_port,
                    username=target.ssh_user,
                    timeout=30
                )
            
            # Create temporary script file
            with tempfile.NamedTemporaryFile(mode='w', suffix='.sh', delete=False) as f:
                f.write(task.script_content)
                temp_script = f.name
            
            # Upload and execute script
            sftp = ssh.open_sftp()
            remote_script = f"/tmp/cursive_deploy_{task.id}.sh"
            sftp.put(temp_script, remote_script)
            sftp.close()
            
            # Make script executable and run
            stdin, stdout, stderr = ssh.exec_command(f"chmod +x {remote_script} && {remote_script}")
            
            # Wait for completion with timeout
            stdout.channel.settimeout(task.timeout_seconds if hasattr(task, 'timeout_seconds') else 300)
            
            task.output = stdout.read().decode()
            task.error = stderr.read().decode()
            task.exit_code = stdout.channel.recv_exit_status()
            
            # Cleanup
            ssh.exec_command(f"rm -f {remote_script}")
            ssh.close()
            os.unlink(temp_script)
            
            return task.exit_code == 0
            
        except Exception as e:
            task.error = str(e)
            return False
    
    async def _execute_local_script_task(self, task: DeploymentTask, target: Target) -> bool:
        """Execute task as local script (for testing)"""
        try:
            # Create temporary script file
            with tempfile.NamedTemporaryFile(mode='w', suffix='.sh', delete=False) as f:
                f.write(task.script_content)
                temp_script = f.name
            
            # Make executable
            os.chmod(temp_script, 0o755)
            
            # Execute
            process = await asyncio.create_subprocess_exec(
                temp_script,
                stdout=asyncio.subprocess.PIPE,
                stderr=asyncio.subprocess.PIPE
            )
            
            stdout, stderr = await asyncio.wait_for(
                process.communicate(),
                timeout=300
            )
            
            task.output = stdout.decode()
            task.error = stderr.decode()
            task.exit_code = process.returncode
            
            # Cleanup
            os.unlink(temp_script)
            
            return task.exit_code == 0
            
        except asyncio.TimeoutError:
            task.error = "Script execution timed out"
            task.exit_code = -1
            return False
        except Exception as e:
            task.error = str(e)
            return False
    
    async def _execute_ansible_task(self, task: DeploymentTask, target: Target) -> bool:
        """Execute task using Ansible"""
        # This would integrate with Ansible for more complex deployments
        # For now, fall back to SSH
        return await self._execute_ssh_task(task, target)
    
    def get_deployment(self, deployment_id: str) -> Optional[Deployment]:
        """Get deployment by ID"""
        for deployment in self.deployments:
            if deployment.id == deployment_id:
                return deployment
        return None
    
    def get_target(self, target_id: str) -> Optional[Target]:
        """Get target by ID"""
        for target in self.targets:
            if target.id == target_id:
                return target
        return None
    
    def cancel_deployment(self, deployment_id: str) -> bool:
        """Cancel a running deployment"""
        if deployment_id in self.active_deployments:
            deployment = self.active_deployments[deployment_id]
            deployment.status = DeploymentStatus.CANCELLED
            self._save_deployments()
            return True
        return False
    
    def get_deployment_status(self, deployment_id: str) -> Dict[str, Any]:
        """Get detailed deployment status"""
        deployment = self.get_deployment(deployment_id)
        if not deployment:
            return {"error": "Deployment not found"}
        
        task_status = {}
        for task in deployment.tasks:
            target = self.get_target(task.target_id)
            task_status[task.id] = {
                "target": target.hostname if target else "Unknown",
                "status": task.status.value,
                "started_at": task.started_at,
                "completed_at": task.completed_at,
                "exit_code": task.exit_code,
                "has_output": bool(task.output),
                "has_error": bool(task.error)
            }
        
        return {
            "deployment": {
                "id": deployment.id,
                "name": deployment.name,
                "status": deployment.status.value,
                "success_count": deployment.success_count,
                "failure_count": deployment.failure_count,
                "total_tasks": len(deployment.tasks),
                "created_at": deployment.created_at,
                "started_at": deployment.started_at,
                "completed_at": deployment.completed_at
            },
            "tasks": task_status
        }
    
    def list_templates(self) -> List[str]:
        """List available deployment templates"""
        return [f.name for f in self.templates_dir.glob("*") if f.is_file()]
    
    def get_template_content(self, template_name: str) -> Optional[str]:
        """Get content of a deployment template"""
        template_file = self.templates_dir / template_name
        if template_file.exists():
            return template_file.read_text()
        return None

async def main():
    """Example usage and testing"""
    # Initialize deployment engine
    engine = DeploymentEngine()
    
    # Add some test targets
    target1 = engine.add_target(
        hostname="dev-server-1",
        ip_address="192.168.1.100",
        os_type="linux",
        ssh_user="deploy",
        tags=["development", "linux"]
    )
    
    target2 = engine.add_target(
        hostname="dev-server-2",
        ip_address="192.168.1.101",
        os_type="macos",
        ssh_user="deploy",
        tags=["development", "macos"]
    )
    
    # Create deployment using template
    template_content = engine.get_template_content("cursive_terminal_install.sh")
    
    deployment = engine.create_deployment(
        name="Install Cursive Terminal",
        description="Deploy cursive terminal to development servers",
        target_ids=[target1.id, target2.id],
        method=DeploymentMethod.LOCAL_SCRIPT,  # Use local for testing
        script_template=template_content,
        variables={
            "font_name": "Victor Mono",
            "terminal_app": "auto",
            "organization": "Acme Corp"
        },
        parallel_limit=2
    )
    
    print(f"Created deployment: {deployment.id}")
    
    # Define progress callback
    def progress_callback(event: str, data: Dict):
        print(f"Progress: {event} - {data}")
    
    # Execute deployment
    print("Starting deployment...")
    success = await engine.execute_deployment(deployment.id, progress_callback)
    
    print(f"Deployment completed: {'Success' if success else 'Failed'}")
    
    # Get final status
    status = engine.get_deployment_status(deployment.id)
    print("Final Status:")
    print(json.dumps(status, indent=2))

if __name__ == "__main__":
    asyncio.run(main())