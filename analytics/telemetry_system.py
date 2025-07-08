#!/usr/bin/env python3
"""
Cursive Terminal - Privacy-First Analytics and Telemetry System
Tracks usage patterns while respecting user privacy
"""

import json
import hashlib
import uuid
from datetime import datetime, timezone
import platform
import subprocess
import os
from pathlib import Path
from typing import Dict, List, Optional, Any
import requests
from dataclasses import dataclass, asdict
import sqlite3

@dataclass
class TelemetryEvent:
    """Represents a single telemetry event"""
    event_type: str
    timestamp: str
    session_id: str
    user_id_hash: str
    platform: str
    terminal: Optional[str]
    font: Optional[str]
    properties: Dict[str, Any]
    version: str

class PrivacyManager:
    """Manages user privacy settings and data anonymization"""
    
    def __init__(self, config_dir: str = "~/.config/cursive-terminal"):
        self.config_dir = Path(config_dir).expanduser()
        self.config_dir.mkdir(parents=True, exist_ok=True)
        self.privacy_file = self.config_dir / "privacy.json"
        self.user_id_file = self.config_dir / "user_id"
        
    def get_privacy_settings(self) -> Dict[str, bool]:
        """Get user privacy preferences"""
        default_settings = {
            "analytics_enabled": True,
            "error_reporting": True,
            "usage_statistics": True,
            "performance_metrics": True,
            "font_popularity": True,
            "terminal_detection": True,
            "crash_reports": True,
            "feature_usage": True
        }
        
        if self.privacy_file.exists():
            try:
                with open(self.privacy_file) as f:
                    return {**default_settings, **json.load(f)}
            except Exception:
                pass
        
        return default_settings
    
    def update_privacy_settings(self, settings: Dict[str, bool]) -> None:
        """Update user privacy preferences"""
        current = self.get_privacy_settings()
        current.update(settings)
        
        with open(self.privacy_file, 'w') as f:
            json.dump(current, f, indent=2)
    
    def get_anonymous_user_id(self) -> str:
        """Get or create anonymous user ID"""
        if self.user_id_file.exists():
            try:
                with open(self.user_id_file) as f:
                    return f.read().strip()
            except Exception:
                pass
        
        # Create new anonymous ID
        user_id = str(uuid.uuid4())
        try:
            with open(self.user_id_file, 'w') as f:
                f.write(user_id)
        except Exception:
            pass
        
        return user_id
    
    def hash_identifier(self, identifier: str) -> str:
        """Create a privacy-safe hash of an identifier"""
        return hashlib.sha256(identifier.encode()).hexdigest()[:16]

class SystemDetector:
    """Detects system information for telemetry"""
    
    @staticmethod
    def get_platform_info() -> Dict[str, str]:
        """Get basic platform information"""
        return {
            "os": platform.system(),
            "os_version": platform.release(),
            "arch": platform.machine(),
            "python_version": platform.python_version()
        }
    
    @staticmethod
    def detect_terminal() -> Optional[str]:
        """Detect which terminal is being used"""
        terminal_vars = [
            ("TERM_PROGRAM", {
                "iTerm.app": "iTerm2",
                "Apple_Terminal": "Terminal.app",
                "vscode": "VS Code Terminal",
                "Hyper": "Hyper"
            }),
            ("TERMINAL_EMULATOR", {
                "JetBrains-JediTerm": "JetBrains Terminal"
            })
        ]
        
        for var, mapping in terminal_vars:
            value = os.environ.get(var)
            if value in mapping:
                return mapping[value]
        
        # Check for specific terminal processes
        try:
            result = subprocess.run(['ps', 'aux'], capture_output=True, text=True)
            processes = result.stdout.lower()
            
            if 'alacritty' in processes:
                return "Alacritty"
            elif 'warp' in processes:
                return "Warp"
            elif 'kitty' in processes:
                return "Kitty"
        except Exception:
            pass
        
        return os.environ.get("TERM", "Unknown")
    
    @staticmethod
    def get_font_info() -> Dict[str, Any]:
        """Get information about installed fonts"""
        font_info = {
            "victor_mono": False,
            "cascadia_code": False,
            "jetbrains_mono": False,
            "fira_code": False,
            "total_fonts": 0
        }
        
        font_dir = Path.home() / "Library" / "Fonts"
        if font_dir.exists():
            fonts = list(font_dir.glob("*.otf")) + list(font_dir.glob("*.ttf"))
            font_info["total_fonts"] = len(fonts)
            
            font_names = [f.name.lower() for f in fonts]
            font_info["victor_mono"] = any("victormono" in name for name in font_names)
            font_info["cascadia_code"] = any("cascadia" in name for name in font_names)
            font_info["jetbrains_mono"] = any("jetbrains" in name for name in font_names)
            font_info["fira_code"] = any("fira" in name for name in font_names)
        
        return font_info

class LocalDatabase:
    """Local SQLite database for storing telemetry before transmission"""
    
    def __init__(self, db_path: str = "~/.config/cursive-terminal/telemetry.db"):
        self.db_path = Path(db_path).expanduser()
        self.db_path.parent.mkdir(parents=True, exist_ok=True)
        self.init_database()
    
    def init_database(self) -> None:
        """Initialize the local database"""
        with sqlite3.connect(self.db_path) as conn:
            conn.execute("""
                CREATE TABLE IF NOT EXISTS events (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    event_type TEXT NOT NULL,
                    timestamp TEXT NOT NULL,
                    session_id TEXT NOT NULL,
                    user_id_hash TEXT NOT NULL,
                    platform TEXT NOT NULL,
                    terminal TEXT,
                    font TEXT,
                    properties TEXT,
                    version TEXT NOT NULL,
                    transmitted BOOLEAN DEFAULT FALSE,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
            """)
            
            conn.execute("""
                CREATE INDEX IF NOT EXISTS idx_timestamp ON events(timestamp)
            """)
            
            conn.execute("""
                CREATE INDEX IF NOT EXISTS idx_transmitted ON events(transmitted)
            """)
    
    def store_event(self, event: TelemetryEvent) -> None:
        """Store an event in the local database"""
        with sqlite3.connect(self.db_path) as conn:
            conn.execute("""
                INSERT INTO events (
                    event_type, timestamp, session_id, user_id_hash,
                    platform, terminal, font, properties, version
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, (
                event.event_type,
                event.timestamp,
                event.session_id,
                event.user_id_hash,
                event.platform,
                event.terminal,
                event.font,
                json.dumps(event.properties),
                event.version
            ))
    
    def get_untransmitted_events(self, limit: int = 100) -> List[Dict]:
        """Get events that haven't been transmitted yet"""
        with sqlite3.connect(self.db_path) as conn:
            conn.row_factory = sqlite3.Row
            cursor = conn.execute("""
                SELECT * FROM events 
                WHERE transmitted = FALSE 
                ORDER BY created_at ASC 
                LIMIT ?
            """, (limit,))
            return [dict(row) for row in cursor.fetchall()]
    
    def mark_transmitted(self, event_ids: List[int]) -> None:
        """Mark events as transmitted"""
        if not event_ids:
            return
            
        with sqlite3.connect(self.db_path) as conn:
            placeholders = ','.join('?' * len(event_ids))
            conn.execute(f"""
                UPDATE events 
                SET transmitted = TRUE 
                WHERE id IN ({placeholders})
            """, event_ids)
    
    def cleanup_old_events(self, days_old: int = 30) -> None:
        """Remove old transmitted events"""
        with sqlite3.connect(self.db_path) as conn:
            conn.execute("""
                DELETE FROM events 
                WHERE transmitted = TRUE 
                AND datetime(created_at) < datetime('now', '-{} days')
            """.format(days_old))

class TelemetryCollector:
    """Main telemetry collection and transmission system"""
    
    def __init__(self, version: str = "1.0.0", endpoint: str = None):
        self.version = version
        self.endpoint = endpoint or "https://analytics.cursiveterminal.com/collect"
        self.session_id = str(uuid.uuid4())
        
        self.privacy = PrivacyManager()
        self.detector = SystemDetector()
        self.database = LocalDatabase()
        
        # Get system info once per session
        self.platform_info = self.detector.get_platform_info()
        self.terminal = self.detector.detect_terminal()
        self.font_info = self.detector.get_font_info()
        
    def is_enabled(self, category: str = "analytics_enabled") -> bool:
        """Check if a specific category of telemetry is enabled"""
        settings = self.privacy.get_privacy_settings()
        return settings.get(category, False)
    
    def create_event(self, event_type: str, properties: Dict[str, Any] = None, 
                    font: str = None) -> TelemetryEvent:
        """Create a telemetry event"""
        return TelemetryEvent(
            event_type=event_type,
            timestamp=datetime.now(timezone.utc).isoformat(),
            session_id=self.session_id,
            user_id_hash=self.privacy.hash_identifier(self.privacy.get_anonymous_user_id()),
            platform=f"{self.platform_info['os']} {self.platform_info['os_version']}",
            terminal=self.terminal,
            font=font,
            properties=properties or {},
            version=self.version
        )
    
    def track_event(self, event_type: str, properties: Dict[str, Any] = None,
                   font: str = None, category: str = "analytics_enabled") -> None:
        """Track a telemetry event"""
        if not self.is_enabled(category):
            return
        
        try:
            event = self.create_event(event_type, properties, font)
            self.database.store_event(event)
            
            # Try to transmit immediately (non-blocking)
            self.transmit_events(max_events=1)
            
        except Exception as e:
            print(f"Error tracking event: {e}")
    
    def track_installation(self, font_name: str, success: bool, 
                          install_method: str = "script") -> None:
        """Track font installation events"""
        if not self.is_enabled("font_popularity"):
            return
            
        self.track_event("font_installation", {
            "success": success,
            "install_method": install_method,
            "existing_fonts": self.font_info["total_fonts"]
        }, font=font_name, category="font_popularity")
    
    def track_terminal_config(self, terminal: str, font: str, 
                            theme: str = None, automated: bool = True) -> None:
        """Track terminal configuration events"""
        if not self.is_enabled("usage_statistics"):
            return
            
        self.track_event("terminal_configuration", {
            "theme": theme,
            "automated": automated,
            "terminal_version": os.environ.get("TERM_PROGRAM_VERSION")
        }, font=font, category="usage_statistics")
    
    def track_error(self, error_type: str, error_message: str, 
                   context: Dict[str, Any] = None) -> None:
        """Track error events"""
        if not self.is_enabled("error_reporting"):
            return
            
        # Hash error message to protect privacy
        error_hash = self.privacy.hash_identifier(error_message)
        
        self.track_event("error", {
            "error_type": error_type,
            "error_hash": error_hash,
            "context": context or {}
        }, category="error_reporting")
    
    def track_performance(self, operation: str, duration_ms: int,
                         success: bool = True) -> None:
        """Track performance metrics"""
        if not self.is_enabled("performance_metrics"):
            return
            
        self.track_event("performance", {
            "operation": operation,
            "duration_ms": duration_ms,
            "success": success
        }, category="performance_metrics")
    
    def track_feature_usage(self, feature: str, action: str = "used",
                           properties: Dict[str, Any] = None) -> None:
        """Track feature usage"""
        if not self.is_enabled("feature_usage"):
            return
            
        self.track_event("feature_usage", {
            "feature": feature,
            "action": action,
            **(properties or {})
        }, category="feature_usage")
    
    def transmit_events(self, max_events: int = 100) -> bool:
        """Transmit stored events to the analytics endpoint"""
        if not self.is_enabled("analytics_enabled"):
            return False
        
        try:
            events = self.database.get_untransmitted_events(max_events)
            if not events:
                return True
            
            # Convert to transmission format
            payload = {
                "events": [
                    {
                        "type": event["event_type"],
                        "timestamp": event["timestamp"],
                        "session_id": event["session_id"],
                        "user_id": event["user_id_hash"],
                        "platform": event["platform"],
                        "terminal": event["terminal"],
                        "font": event["font"],
                        "properties": json.loads(event["properties"]),
                        "version": event["version"]
                    }
                    for event in events
                ],
                "meta": {
                    "client_version": self.version,
                    "transmission_time": datetime.now(timezone.utc).isoformat()
                }
            }
            
            # Transmit with timeout
            response = requests.post(
                self.endpoint,
                json=payload,
                timeout=10,
                headers={
                    "Content-Type": "application/json",
                    "User-Agent": f"CursiveTerminal/{self.version}"
                }
            )
            
            if response.status_code == 200:
                # Mark events as transmitted
                event_ids = [event["id"] for event in events]
                self.database.mark_transmitted(event_ids)
                return True
            else:
                print(f"Failed to transmit events: {response.status_code}")
                return False
                
        except Exception as e:
            print(f"Error transmitting events: {e}")
            return False
    
    def generate_usage_report(self, days: int = 30) -> Dict[str, Any]:
        """Generate a local usage report"""
        with sqlite3.connect(self.database.db_path) as conn:
            conn.row_factory = sqlite3.Row
            
            # Get events from last N days
            cursor = conn.execute("""
                SELECT event_type, font, properties, timestamp
                FROM events 
                WHERE datetime(timestamp) > datetime('now', '-{} days')
                ORDER BY timestamp DESC
            """.format(days))
            
            events = [dict(row) for row in cursor.fetchall()]
        
        # Analyze events
        report = {
            "total_events": len(events),
            "date_range": f"Last {days} days",
            "font_usage": {},
            "terminal_usage": {},
            "feature_usage": {},
            "error_count": 0
        }
        
        for event in events:
            # Count font usage
            if event["font"]:
                report["font_usage"][event["font"]] = report["font_usage"].get(event["font"], 0) + 1
            
            # Count feature usage
            if event["event_type"] == "feature_usage":
                properties = json.loads(event["properties"] or "{}")
                feature = properties.get("feature", "unknown")
                report["feature_usage"][feature] = report["feature_usage"].get(feature, 0) + 1
            
            # Count errors
            if event["event_type"] == "error":
                report["error_count"] += 1
        
        return report

def main():
    """Example usage and testing"""
    collector = TelemetryCollector(version="1.0.0")
    
    # Test various tracking functions
    collector.track_installation("Victor Mono", True, "homebrew")
    collector.track_terminal_config("iTerm2", "Victor Mono", "cursive-elegance")
    collector.track_feature_usage("font_preview", "generated")
    collector.track_performance("font_installation", 2500, True)
    
    # Generate and display usage report
    report = collector.generate_usage_report(30)
    print(json.dumps(report, indent=2))
    
    # Attempt to transmit events
    success = collector.transmit_events()
    print(f"Transmission successful: {success}")

if __name__ == "__main__":
    main()