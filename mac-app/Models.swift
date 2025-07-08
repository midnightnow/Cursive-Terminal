import Foundation
import SwiftUI
import CoreText

// MARK: - Cursive Font Model
struct CursiveFont: Identifiable, Codable {
    let id = UUID()
    let name: String
    let fontName: String // PostScript name
    let style: String
    let description: String
    let designer: String
    let license: String
    let downloadURL: String
    let fileSize: String
    let rating: Int
    var isInstalled: Bool
    
    // Font characteristics
    let hasLigatures: Bool
    let cursiveLevel: CursiveLevel // How cursive it is
    let readabilityScore: Int // 1-10
    
    enum CursiveLevel: String, Codable, CaseIterable {
        case subtle = "Subtle"
        case moderate = "Moderate" 
        case full = "Full Cursive"
    }
    
    static let sampleFonts = [
        CursiveFont(
            name: "Victor Mono",
            fontName: "VictorMono-Italic",
            style: "Semi-connected cursive",
            description: "Beautiful cursive with connected letters, perfect for code",
            designer: "Rune Bjørnerås",
            license: "Open Font License",
            downloadURL: "https://github.com/rubjo/victor-mono/releases",
            fileSize: "2.1 MB",
            rating: 5,
            isInstalled: false,
            hasLigatures: true,
            cursiveLevel: .full,
            readabilityScore: 9
        ),
        CursiveFont(
            name: "Cascadia Code",
            fontName: "CascadiaCode-Italic",
            style: "Elegant cursive",
            description: "Microsoft's elegant take on cursive programming fonts",
            designer: "Microsoft",
            license: "Open Font License",
            downloadURL: "https://github.com/microsoft/cascadia-code/releases",
            fileSize: "1.8 MB",
            rating: 4,
            isInstalled: false,
            hasLigatures: true,
            cursiveLevel: .moderate,
            readabilityScore: 8
        ),
        CursiveFont(
            name: "JetBrains Mono",
            fontName: "JetBrainsMono-Italic",
            style: "Subtle cursive",
            description: "Subtle cursive styling with excellent readability",
            designer: "JetBrains",
            license: "Open Font License",
            downloadURL: "https://github.com/JetBrains/JetBrainsMono/releases",
            fileSize: "1.5 MB",
            rating: 4,
            isInstalled: false,
            hasLigatures: false,
            cursiveLevel: .subtle,
            readabilityScore: 10
        ),
        CursiveFont(
            name: "Fira Code",
            fontName: "FiraCode-Regular",
            style: "Ligature-rich",
            description: "Excellent ligatures with cursive italic support",
            designer: "Nikita Prokopov",
            license: "Open Font License",
            downloadURL: "https://github.com/tonsky/FiraCode/releases",
            fileSize: "1.2 MB",
            rating: 4,
            isInstalled: false,
            hasLigatures: true,
            cursiveLevel: .subtle,
            readabilityScore: 9
        ),
        CursiveFont(
            name: "SF Mono Oblique",
            fontName: "SFMono-Oblique",
            style: "Custom slanted",
            description: "Custom oblique version of Apple's SF Mono",
            designer: "Apple (Modified)",
            license: "Custom",
            downloadURL: "local://custom",
            fileSize: "800 KB",
            rating: 3,
            isInstalled: false,
            hasLigatures: false,
            cursiveLevel: .subtle,
            readabilityScore: 8
        )
    ]
}

// MARK: - Terminal Application Model
struct TerminalApp: Identifiable {
    let id = UUID()
    let name: String
    let bundleIdentifier: String
    let icon: String
    var isInstalled: Bool
    var configPath: String?
    
    static let supportedTerminals = [
        TerminalApp(
            name: "Terminal",
            bundleIdentifier: "com.apple.Terminal",
            icon: "terminal",
            isInstalled: false,
            configPath: "~/Library/Preferences/com.apple.Terminal.plist"
        ),
        TerminalApp(
            name: "iTerm2",
            bundleIdentifier: "com.googlecode.iterm2",
            icon: "terminal.fill",
            isInstalled: false,
            configPath: "~/Library/Preferences/com.googlecode.iterm2.plist"
        ),
        TerminalApp(
            name: "Alacritty",
            bundleIdentifier: "org.alacritty",
            icon: "square.and.arrow.up.on.square",
            isInstalled: false,
            configPath: "~/.config/alacritty/alacritty.yml"
        ),
        TerminalApp(
            name: "Hyper",
            bundleIdentifier: "co.zeit.hyper",
            icon: "macwindow",
            isInstalled: false,
            configPath: "~/.hyper.js"
        ),
        TerminalApp(
            name: "Warp",
            bundleIdentifier: "dev.warp.Warp-Stable",
            icon: "terminal.fill",
            isInstalled: false,
            configPath: "~/.warp/settings.yaml"
        )
    ]
}

// MARK: - Theme Model
struct CursiveTheme: Identifiable, Codable {
    let id = UUID()
    let name: String
    let description: String
    let author: String
    
    // Colors
    let backgroundColor: String
    let foregroundColor: String
    let cursorColor: String
    let selectionColor: String
    
    // ANSI Colors (16 colors)
    let ansiColors: [String]
    
    // Metadata
    let createdDate: Date
    let downloadCount: Int
    let rating: Double
    
    static let defaultThemes = [
        CursiveTheme(
            name: "Cursive Elegance",
            description: "Purple and gold theme optimized for cursive fonts",
            author: "Cursive Terminal",
            backgroundColor: "#1A1625",
            foregroundColor: "#E8E3E3",
            cursorColor: "#FFD700",
            selectionColor: "#6B5B95",
            ansiColors: [
                "#1A1625", "#FF6B6B", "#4ECDC4", "#FFD700",
                "#6B5B95", "#C44569", "#88D8B0", "#E8E3E3",
                "#2D2139", "#FF8A80", "#80CBC4", "#FFF176",
                "#9575CD", "#F06292", "#A7FFEB", "#FFFFFF"
            ],
            createdDate: Date(),
            downloadCount: 1250,
            rating: 4.8
        ),
        CursiveTheme(
            name: "Cursive Noir",
            description: "Elegant black and silver for sophisticated coding",
            author: "Cursive Terminal",
            backgroundColor: "#0A0A0A",
            foregroundColor: "#C0C0C0",
            cursorColor: "#FFFFFF",
            selectionColor: "#404040",
            ansiColors: [
                "#0A0A0A", "#DC143C", "#00FF00", "#FFD700",
                "#4169E1", "#9400D3", "#00CED1", "#C0C0C0",
                "#1A1A1A", "#F5A9A9", "#90EE90", "#FFFF99",
                "#87CEEB", "#DDA0DD", "#AFEEEE", "#FFFFFF"
            ],
            createdDate: Date(),
            downloadCount: 890,
            rating: 4.6
        )
    ]
}

// MARK: - App Settings Model
class AppSettings: ObservableObject {
    @Published var selectedFont: String = ""
    @Published var selectedTheme: String = ""
    @Published var autoBackup: Bool = true
    @Published var showNotifications: Bool = true
    @Published var checkForUpdates: Bool = true
    @Published var previewFontSize: Double = 14.0
    @Published var defaultTerminal: String = ""
    
    // Premium features
    @Published var isPro: Bool = false
    @Published var proExpiryDate: Date?
    
    init() {
        loadSettings()
    }
    
    func loadSettings() {
        // Load from UserDefaults
        let defaults = UserDefaults.standard
        selectedFont = defaults.string(forKey: "selectedFont") ?? ""
        selectedTheme = defaults.string(forKey: "selectedTheme") ?? ""
        autoBackup = defaults.bool(forKey: "autoBackup")
        showNotifications = defaults.bool(forKey: "showNotifications")
        checkForUpdates = defaults.bool(forKey: "checkForUpdates")
        previewFontSize = defaults.double(forKey: "previewFontSize")
        defaultTerminal = defaults.string(forKey: "defaultTerminal") ?? ""
        isPro = defaults.bool(forKey: "isPro")
        
        if let expiryDate = defaults.object(forKey: "proExpiryDate") as? Date {
            proExpiryDate = expiryDate
        }
    }
    
    func saveSettings() {
        let defaults = UserDefaults.standard
        defaults.set(selectedFont, forKey: "selectedFont")
        defaults.set(selectedTheme, forKey: "selectedTheme")
        defaults.set(autoBackup, forKey: "autoBackup")
        defaults.set(showNotifications, forKey: "showNotifications")
        defaults.set(checkForUpdates, forKey: "checkForUpdates")
        defaults.set(previewFontSize, forKey: "previewFontSize")
        defaults.set(defaultTerminal, forKey: "defaultTerminal")
        defaults.set(isPro, forKey: "isPro")
        defaults.set(proExpiryDate, forKey: "proExpiryDate")
    }
}

// MARK: - Installation Status
enum InstallationStatus {
    case notInstalled
    case downloading
    case installing
    case installed
    case failed(Error)
    
    var description: String {
        switch self {
        case .notInstalled:
            return "Not Installed"
        case .downloading:
            return "Downloading..."
        case .installing:
            return "Installing..."
        case .installed:
            return "Installed"
        case .failed(let error):
            return "Failed: \(error.localizedDescription)"
        }
    }
}

// MARK: - Error Types
enum CursiveTerminalError: LocalizedError {
    case fontNotFound
    case installationFailed
    case terminalNotSupported
    case configurationError
    case networkError
    case permissionDenied
    
    var errorDescription: String? {
        switch self {
        case .fontNotFound:
            return "Font file not found"
        case .installationFailed:
            return "Font installation failed"
        case .terminalNotSupported:
            return "Terminal application not supported"
        case .configurationError:
            return "Configuration error"
        case .networkError:
            return "Network connection error"
        case .permissionDenied:
            return "Permission denied"
        }
    }
}