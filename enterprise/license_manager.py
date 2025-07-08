#!/usr/bin/env python3
"""
Cursive Terminal - Enterprise License Management
Handles license validation, seat management, and feature restrictions
"""

import json
import hashlib
import hmac
import base64
import time
from datetime import datetime, timezone, timedelta
from pathlib import Path
from typing import Dict, List, Optional, Any, Tuple
import uuid
import requests
from dataclasses import dataclass, asdict
from cryptography.fernet import Fernet
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC

@dataclass
class License:
    """Represents an enterprise license"""
    license_key: str
    organization: str
    license_type: str  # starter, professional, enterprise
    max_seats: int
    features: List[str]
    issued_date: str
    expiry_date: str
    contact_email: str
    is_trial: bool = False
    is_active: bool = True

@dataclass
class Seat:
    """Represents a licensed seat assignment"""
    id: str
    license_key: str
    user_email: str
    user_name: str
    assigned_date: str
    last_activity: str
    device_fingerprint: str
    status: str = "active"  # active, inactive, suspended

@dataclass
class Feature:
    """Represents a licensed feature"""
    name: str
    description: str
    license_types: List[str]  # Which license types include this feature
    usage_limit: Optional[int] = None  # Usage limit if applicable

class LicenseManager:
    """Manages enterprise licenses and seat assignments"""
    
    # Available features by license type
    FEATURES = {
        "starter": [
            "basic_fonts",
            "terminal_config",
            "community_support"
        ],
        "professional": [
            "basic_fonts",
            "premium_fonts",
            "terminal_config",
            "team_management",
            "analytics",
            "priority_support"
        ],
        "enterprise": [
            "basic_fonts",
            "premium_fonts",
            "custom_fonts",
            "terminal_config",
            "team_management",
            "advanced_analytics",
            "sso_integration",
            "ldap_integration",
            "policy_management",
            "bulk_deployment",
            "api_access",
            "dedicated_support",
            "compliance_reporting"
        ]
    }
    
    def __init__(self, config_dir: str = "~/.config/cursive-terminal-enterprise"):
        self.config_dir = Path(config_dir).expanduser()
        self.config_dir.mkdir(parents=True, exist_ok=True)
        
        # License files
        self.license_file = self.config_dir / "license.json"
        self.seats_file = self.config_dir / "seats.json"
        self.usage_file = self.config_dir / "usage.json"
        
        # Encryption key for local storage
        self.encryption_key = self._get_or_create_encryption_key()
        
        # Load existing data
        self.license = self._load_license()
        self.seats = self._load_seats()
        self.usage_stats = self._load_usage_stats()
        
        # License server URL
        self.license_server = "https://license.cursiveterminal.com"
    
    def _get_or_create_encryption_key(self) -> bytes:
        """Get or create encryption key for local data"""
        key_file = self.config_dir / ".encryption_key"
        
        if key_file.exists():
            return key_file.read_bytes()
        
        # Generate new key
        key = Fernet.generate_key()
        key_file.write_bytes(key)
        key_file.chmod(0o600)  # Restrict permissions
        return key
    
    def _encrypt_data(self, data: str) -> str:
        """Encrypt sensitive data for local storage"""
        f = Fernet(self.encryption_key)
        return f.encrypt(data.encode()).decode()
    
    def _decrypt_data(self, encrypted_data: str) -> str:
        """Decrypt sensitive data from local storage"""
        f = Fernet(self.encryption_key)
        return f.decrypt(encrypted_data.encode()).decode()
    
    def _load_license(self) -> Optional[License]:
        """Load license from local storage"""
        if self.license_file.exists():
            try:
                with open(self.license_file) as f:
                    encrypted_data = f.read()
                    decrypted_data = self._decrypt_data(encrypted_data)
                    license_data = json.loads(decrypted_data)
                    return License(**license_data)
            except Exception as e:
                print(f"Error loading license: {e}")
        return None
    
    def _save_license(self) -> None:
        """Save license to local storage"""
        if self.license:
            license_data = asdict(self.license)
            encrypted_data = self._encrypt_data(json.dumps(license_data))
            with open(self.license_file, 'w') as f:
                f.write(encrypted_data)
    
    def _load_seats(self) -> List[Seat]:
        """Load seat assignments from local storage"""
        if self.seats_file.exists():
            try:
                with open(self.seats_file) as f:
                    data = json.load(f)
                    return [Seat(**seat) for seat in data]
            except Exception as e:
                print(f"Error loading seats: {e}")
        return []
    
    def _save_seats(self) -> None:
        """Save seat assignments to local storage"""
        with open(self.seats_file, 'w') as f:
            json.dump([asdict(seat) for seat in self.seats], f, indent=2)
    
    def _load_usage_stats(self) -> Dict[str, Any]:
        """Load usage statistics"""
        if self.usage_file.exists():
            try:
                with open(self.usage_file) as f:
                    return json.load(f)
            except Exception as e:
                print(f"Error loading usage stats: {e}")
        
        return {
            "daily_usage": {},
            "feature_usage": {},
            "user_activity": {},
            "last_updated": datetime.now(timezone.utc).isoformat()
        }
    
    def _save_usage_stats(self) -> None:
        """Save usage statistics"""
        self.usage_stats["last_updated"] = datetime.now(timezone.utc).isoformat()
        with open(self.usage_file, 'w') as f:
            json.dump(self.usage_stats, f, indent=2)
    
    def validate_license_key(self, license_key: str) -> Tuple[bool, str]:
        """Validate license key format and checksum"""
        if not license_key or len(license_key) != 36:
            return False, "Invalid license key format"
        
        # Extract components
        parts = license_key.split('-')
        if len(parts) != 5:
            return False, "Invalid license key format"
        
        # Validate checksum (simplified validation)
        key_data = '-'.join(parts[:4])
        expected_checksum = hashlib.md5(key_data.encode()).hexdigest()[:8]
        
        if parts[4][:8] != expected_checksum:
            return False, "Invalid license key checksum"
        
        return True, "Valid license key format"
    
    def activate_license(self, license_key: str, organization: str, 
                        contact_email: str) -> Tuple[bool, str]:
        """Activate a license key"""
        # Validate format first
        is_valid, message = self.validate_license_key(license_key)
        if not is_valid:
            return False, message
        
        try:
            # Contact license server for activation
            response = requests.post(f"{self.license_server}/activate", json={
                "license_key": license_key,
                "organization": organization,
                "contact_email": contact_email,
                "device_fingerprint": self._get_device_fingerprint()
            }, timeout=10)
            
            if response.status_code == 200:
                license_data = response.json()
                self.license = License(**license_data)
                self._save_license()
                return True, "License activated successfully"
            else:
                error_msg = response.json().get("error", "Activation failed")
                return False, error_msg
                
        except requests.RequestException as e:
            # Offline activation fallback
            return self._offline_activation(license_key, organization, contact_email)
    
    def _offline_activation(self, license_key: str, organization: str,
                           contact_email: str) -> Tuple[bool, str]:
        """Fallback offline activation"""
        # Create a trial license for offline use
        self.license = License(
            license_key=license_key,
            organization=organization,
            license_type="trial",
            max_seats=5,
            features=self.FEATURES["starter"],
            issued_date=datetime.now(timezone.utc).isoformat(),
            expiry_date=(datetime.now(timezone.utc) + timedelta(days=30)).isoformat(),
            contact_email=contact_email,
            is_trial=True,
            is_active=True
        )
        
        self._save_license()
        return True, "License activated in offline mode (30-day trial)"
    
    def deactivate_license(self) -> Tuple[bool, str]:
        """Deactivate the current license"""
        if not self.license:
            return False, "No active license found"
        
        try:
            # Notify license server
            requests.post(f"{self.license_server}/deactivate", json={
                "license_key": self.license.license_key,
                "device_fingerprint": self._get_device_fingerprint()
            }, timeout=5)
        except:
            pass  # Continue with local deactivation even if server is unreachable
        
        # Remove local license
        if self.license_file.exists():
            self.license_file.unlink()
        
        self.license = None
        return True, "License deactivated successfully"
    
    def check_license_status(self) -> Tuple[bool, str, Dict[str, Any]]:
        """Check current license status"""
        if not self.license:
            return False, "No license found", {}
        
        # Check expiry
        expiry_date = datetime.fromisoformat(self.license.expiry_date.replace('Z', '+00:00'))
        if datetime.now(timezone.utc) > expiry_date:
            return False, "License expired", {"expired": True, "expiry_date": self.license.expiry_date}
        
        # Check seat usage
        active_seats = len([s for s in self.seats if s.status == "active"])
        
        status_info = {
            "license_type": self.license.license_type,
            "organization": self.license.organization,
            "max_seats": self.license.max_seats,
            "used_seats": active_seats,
            "available_seats": self.license.max_seats - active_seats,
            "features": self.license.features,
            "is_trial": self.license.is_trial,
            "expiry_date": self.license.expiry_date
        }
        
        return True, "License active", status_info
    
    def assign_seat(self, user_email: str, user_name: str) -> Tuple[bool, str]:
        """Assign a seat to a user"""
        if not self.license:
            return False, "No active license"
        
        # Check if license is valid
        is_valid, message, _ = self.check_license_status()
        if not is_valid:
            return False, message
        
        # Check seat availability
        active_seats = len([s for s in self.seats if s.status == "active"])
        if active_seats >= self.license.max_seats:
            return False, "No available seats"
        
        # Check if user already has a seat
        existing_seat = self.get_user_seat(user_email)
        if existing_seat:
            return False, "User already has an assigned seat"
        
        # Create new seat
        seat = Seat(
            id=str(uuid.uuid4()),
            license_key=self.license.license_key,
            user_email=user_email,
            user_name=user_name,
            assigned_date=datetime.now(timezone.utc).isoformat(),
            last_activity=datetime.now(timezone.utc).isoformat(),
            device_fingerprint=self._get_device_fingerprint(),
            status="active"
        )
        
        self.seats.append(seat)
        self._save_seats()
        
        return True, "Seat assigned successfully"
    
    def revoke_seat(self, user_email: str) -> Tuple[bool, str]:
        """Revoke a seat from a user"""
        for seat in self.seats:
            if seat.user_email == user_email:
                seat.status = "inactive"
                self._save_seats()
                return True, "Seat revoked successfully"
        
        return False, "User seat not found"
    
    def get_user_seat(self, user_email: str) -> Optional[Seat]:
        """Get seat information for a user"""
        for seat in self.seats:
            if seat.user_email == user_email and seat.status == "active":
                return seat
        return None
    
    def has_feature(self, feature: str) -> bool:
        """Check if current license includes a feature"""
        if not self.license:
            return False
        
        return feature in self.license.features
    
    def update_user_activity(self, user_email: str) -> None:
        """Update last activity for a user"""
        seat = self.get_user_seat(user_email)
        if seat:
            seat.last_activity = datetime.now(timezone.utc).isoformat()
            self._save_seats()
    
    def track_feature_usage(self, feature: str, user_email: str) -> None:
        """Track feature usage for analytics"""
        today = datetime.now(timezone.utc).date().isoformat()
        
        # Update daily usage
        if today not in self.usage_stats["daily_usage"]:
            self.usage_stats["daily_usage"][today] = {}
        
        if feature not in self.usage_stats["daily_usage"][today]:
            self.usage_stats["daily_usage"][today][feature] = 0
        
        self.usage_stats["daily_usage"][today][feature] += 1
        
        # Update feature usage
        if feature not in self.usage_stats["feature_usage"]:
            self.usage_stats["feature_usage"][feature] = {"total": 0, "users": set()}
        
        self.usage_stats["feature_usage"][feature]["total"] += 1
        self.usage_stats["feature_usage"][feature]["users"].add(user_email)
        
        # Convert sets to lists for JSON serialization
        for feat_data in self.usage_stats["feature_usage"].values():
            if isinstance(feat_data["users"], set):
                feat_data["users"] = list(feat_data["users"])
        
        # Update user activity
        if user_email not in self.usage_stats["user_activity"]:
            self.usage_stats["user_activity"][user_email] = {
                "last_activity": "",
                "total_usage": 0,
                "features_used": set()
            }
        
        self.usage_stats["user_activity"][user_email]["last_activity"] = datetime.now(timezone.utc).isoformat()
        self.usage_stats["user_activity"][user_email]["total_usage"] += 1
        self.usage_stats["user_activity"][user_email]["features_used"].add(feature)
        
        # Convert sets to lists
        for user_data in self.usage_stats["user_activity"].values():
            if isinstance(user_data["features_used"], set):
                user_data["features_used"] = list(user_data["features_used"])
        
        self._save_usage_stats()
    
    def generate_usage_report(self, days: int = 30) -> Dict[str, Any]:
        """Generate usage report for the license"""
        if not self.license:
            return {"error": "No active license"}
        
        cutoff_date = (datetime.now(timezone.utc) - timedelta(days=days)).date().isoformat()
        
        # Filter recent usage
        recent_usage = {}
        for date, usage in self.usage_stats["daily_usage"].items():
            if date >= cutoff_date:
                recent_usage[date] = usage
        
        # Calculate totals
        total_usage = sum(
            sum(day_usage.values()) for day_usage in recent_usage.values()
        )
        
        # Active users
        active_users = set()
        for user_email, user_data in self.usage_stats["user_activity"].items():
            last_activity = datetime.fromisoformat(user_data["last_activity"].replace('Z', '+00:00'))
            if (datetime.now(timezone.utc) - last_activity).days <= days:
                active_users.add(user_email)
        
        return {
            "license_info": {
                "license_type": self.license.license_type,
                "organization": self.license.organization,
                "max_seats": self.license.max_seats,
                "used_seats": len([s for s in self.seats if s.status == "active"])
            },
            "usage_period": f"Last {days} days",
            "total_usage": total_usage,
            "active_users": len(active_users),
            "daily_usage": recent_usage,
            "feature_usage": self.usage_stats["feature_usage"],
            "most_used_features": sorted(
                self.usage_stats["feature_usage"].items(),
                key=lambda x: x[1]["total"],
                reverse=True
            )[:10]
        }
    
    def sync_with_server(self) -> Tuple[bool, str]:
        """Sync license status with server"""
        if not self.license:
            return False, "No license to sync"
        
        try:
            response = requests.post(f"{self.license_server}/sync", json={
                "license_key": self.license.license_key,
                "device_fingerprint": self._get_device_fingerprint(),
                "usage_stats": self.usage_stats
            }, timeout=10)
            
            if response.status_code == 200:
                sync_data = response.json()
                
                # Update license if changed
                if "license" in sync_data:
                    self.license = License(**sync_data["license"])
                    self._save_license()
                
                return True, "Sync successful"
            else:
                return False, f"Sync failed: {response.json().get('error', 'Unknown error')}"
                
        except requests.RequestException as e:
            return False, f"Sync failed: {str(e)}"
    
    def _get_device_fingerprint(self) -> str:
        """Generate device fingerprint for license binding"""
        import platform
        import getpass
        
        device_info = {
            "hostname": platform.node(),
            "platform": platform.platform(),
            "user": getpass.getuser(),
            "python_version": platform.python_version()
        }
        
        device_string = json.dumps(device_info, sort_keys=True)
        return hashlib.sha256(device_string.encode()).hexdigest()[:16]
    
    def get_seat_list(self) -> List[Dict[str, Any]]:
        """Get list of all seats with status"""
        seats_info = []
        for seat in self.seats:
            last_activity = datetime.fromisoformat(seat.last_activity.replace('Z', '+00:00'))
            days_inactive = (datetime.now(timezone.utc) - last_activity).days
            
            seats_info.append({
                "id": seat.id,
                "user_email": seat.user_email,
                "user_name": seat.user_name,
                "assigned_date": seat.assigned_date,
                "last_activity": seat.last_activity,
                "days_inactive": days_inactive,
                "status": seat.status
            })
        
        return sorted(seats_info, key=lambda x: x["assigned_date"])

def main():
    """Example usage and testing"""
    # Initialize license manager
    license_mgr = LicenseManager()
    
    # Example license activation
    success, message = license_mgr.activate_license(
        "CT-ENTY-2025-DEV1-12345678",
        "Acme Corporation",
        "admin@acme.com"
    )
    print(f"Activation: {success} - {message}")
    
    if success:
        # Check license status
        is_valid, status_msg, info = license_mgr.check_license_status()
        print(f"License Status: {is_valid} - {status_msg}")
        print(f"License Info: {json.dumps(info, indent=2)}")
        
        # Assign seats
        license_mgr.assign_seat("alice@acme.com", "Alice Johnson")
        license_mgr.assign_seat("bob@acme.com", "Bob Smith")
        
        # Track some feature usage
        license_mgr.track_feature_usage("team_management", "alice@acme.com")
        license_mgr.track_feature_usage("analytics", "alice@acme.com")
        license_mgr.track_feature_usage("premium_fonts", "bob@acme.com")
        
        # Generate usage report
        report = license_mgr.generate_usage_report()
        print("Usage Report:")
        print(json.dumps(report, indent=2))
        
        # Get seat list
        seats = license_mgr.get_seat_list()
        print("\nSeat Assignments:")
        for seat in seats:
            print(f"  {seat['user_name']} ({seat['user_email']}) - {seat['status']}")

if __name__ == "__main__":
    main()