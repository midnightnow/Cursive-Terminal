import Foundation
import SwiftUI
import CoreText
import AppKit

// MARK: - Font Manager
class FontManager: ObservableObject {
    @Published var fonts: [CursiveFont] = []
    @Published var isLoading = false
    @Published var installationStatus: [UUID: InstallationStatus] = [:]
    
    private let fileManager = FileManager.default
    private let fontDirectory = URL(fileURLWithPath: NSHomeDirectory())
        .appendingPathComponent("Library/Fonts")
    
    init() {
        loadFonts()
    }
    
    func loadFonts() {
        isLoading = true
        
        // Load sample fonts and check installation status
        var loadedFonts = CursiveFont.sampleFonts
        
        for i in 0..<loadedFonts.count {
            loadedFonts[i].isInstalled = isFontInstalled(loadedFonts[i])
            installationStatus[loadedFonts[i].id] = loadedFonts[i].isInstalled ? .installed : .notInstalled
        }
        
        DispatchQueue.main.async {
            self.fonts = loadedFonts
            self.isLoading = false
        }
    }
    
    func installFont(_ font: CursiveFont) {
        guard !font.isInstalled else { return }
        
        installationStatus[font.id] = .downloading
        
        // For demo purposes, we'll simulate font installation
        // In a real app, you'd download from font.downloadURL
        
        DispatchQueue.global(qos: .userInitiated).async {
            // Simulate download time
            Thread.sleep(forTimeInterval: 2.0)
            
            DispatchQueue.main.async {
                self.installationStatus[font.id] = .installing
            }
            
            // Simulate installation time
            Thread.sleep(forTimeInterval: 1.0)
            
            // For real implementation, you would:
            // 1. Download font from URL
            // 2. Install using CTFontManagerRegisterFontsForURL
            // 3. Update font status
            
            DispatchQueue.main.async {
                self.installationStatus[font.id] = .installed
                
                // Update font in array
                if let index = self.fonts.firstIndex(where: { $0.id == font.id }) {
                    self.fonts[index].isInstalled = true
                }
                
                // Send notification
                self.sendInstallationNotification(font: font, success: true)
            }
        }
    }
    
    private func isFontInstalled(_ font: CursiveFont) -> Bool {
        // Check if font is installed by trying to create it
        if let _ = NSFont(name: font.fontName, size: 12) {
            return true
        }
        
        // Also check in font directory
        let fontPath = fontDirectory.appendingPathComponent("\(font.fontName).otf")
        return fileManager.fileExists(atPath: fontPath.path)
    }
    
    private func installFontFile(at url: URL) throws {
        var error: Unmanaged<CFError>?
        
        if !CTFontManagerRegisterFontsForURL(url as CFURL, .process, &error) {
            if let error = error?.takeRetainedValue() {
                throw error
            } else {
                throw CursiveTerminalError.installationFailed
            }
        }
    }
    
    private func sendInstallationNotification(font: CursiveFont, success: Bool) {
        let content = UNMutableNotificationContent()
        content.title = success ? "Font Installed!" : "Installation Failed"
        content.body = success ? 
            "\(font.name) is ready to use in your terminal" :
            "Failed to install \(font.name). Please try again."
        content.sound = .default
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil
        )
        
        UNUserNotificationCenter.current().add(request)
    }
}

// MARK: - Terminal Detector
class TerminalDetector: ObservableObject {
    @Published var terminals: [TerminalApp] = []
    @Published var isScanning = false
    
    private let workspace = NSWorkspace.shared
    
    init() {
        detectTerminals()
    }
    
    func detectTerminals() {
        isScanning = true
        
        DispatchQueue.global(qos: .userInitiated).async {
            var detectedTerminals = TerminalApp.supportedTerminals
            
            for i in 0..<detectedTerminals.count {
                detectedTerminals[i].isInstalled = self.isTerminalInstalled(detectedTerminals[i])
            }
            
            DispatchQueue.main.async {
                self.terminals = detectedTerminals
                self.isScanning = false
            }
        }
    }
    
    private func isTerminalInstalled(_ terminal: TerminalApp) -> Bool {
        return workspace.urlForApplication(withBundleIdentifier: terminal.bundleIdentifier) != nil
    }
    
    func openTerminal(_ terminal: TerminalApp) {
        guard let url = workspace.urlForApplication(withBundleIdentifier: terminal.bundleIdentifier) else {
            return
        }
        
        workspace.open(url)
    }
    
    func configureTerminal(_ terminal: TerminalApp, with font: CursiveFont) {
        // Implementation would depend on the specific terminal
        switch terminal.bundleIdentifier {
        case "com.apple.Terminal":
            configureTerminalApp(font: font)
        case "com.googlecode.iterm2":
            configureITerm2(font: font)
        default:
            break
        }
    }
    
    private func configureTerminalApp(font: CursiveFont) {
        // Use AppleScript to configure Terminal.app
        let script = """
        tell application "Terminal"
            set current settings of front window to settings set "Basic"
            set font name of current settings of front window to "\(font.fontName)"
        end tell
        """
        
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: script) {
            scriptObject.executeAndReturnError(&error)
        }
    }
    
    private func configureITerm2(font: CursiveFont) {
        // Use AppleScript to configure iTerm2
        let script = """
        tell application "iTerm"
            tell current profile of current session of current window
                set font name to "\(font.fontName)"
            end tell
        end tell
        """
        
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: script) {
            scriptObject.executeAndReturnError(&error)
        }
    }
}

// MARK: - Theme Manager
class ThemeManager: ObservableObject {
    @Published var themes: [CursiveTheme] = []
    @Published var selectedTheme: CursiveTheme?
    @Published var isLoading = false
    
    init() {
        loadThemes()
    }
    
    func loadThemes() {
        isLoading = true
        
        DispatchQueue.main.async {
            self.themes = CursiveTheme.defaultThemes
            self.selectedTheme = self.themes.first
            self.isLoading = false
        }
    }
    
    func applyTheme(_ theme: CursiveTheme, to terminal: TerminalApp) {
        // Implementation would create and apply terminal color schemes
        switch terminal.bundleIdentifier {
        case "com.apple.Terminal":
            applyThemeToTerminalApp(theme)
        case "com.googlecode.iterm2":
            applyThemeToITerm2(theme)
        default:
            break
        }
    }
    
    private func applyThemeToTerminalApp(_ theme: CursiveTheme) {
        // Create and apply Terminal.app color scheme
        // This would involve creating a .terminal profile file
    }
    
    private func applyThemeToITerm2(_ theme: CursiveTheme) {
        // Create and apply iTerm2 color scheme
        // This would involve creating a .itermcolors file
    }
    
    func exportTheme(_ theme: CursiveTheme) -> URL? {
        // Export theme as a file that can be shared
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        do {
            let data = try encoder.encode(theme)
            let url = FileManager.default.temporaryDirectory
                .appendingPathComponent("\(theme.name).cursivetheme")
            
            try data.write(to: url)
            return url
        } catch {
            print("Error exporting theme: \(error)")
            return nil
        }
    }
    
    func importTheme(from url: URL) -> Bool {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let theme = try decoder.decode(CursiveTheme.self, from: data)
            
            DispatchQueue.main.async {
                self.themes.append(theme)
            }
            
            return true
        } catch {
            print("Error importing theme: \(error)")
            return false
        }
    }
}

// MARK: - Update Manager
class UpdateManager: ObservableObject {
    @Published var isUpdateAvailable = false
    @Published var latestVersion = ""
    @Published var updateNotes = ""
    
    private let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    
    func checkForUpdates() {
        // In a real app, this would check a remote endpoint
        // For demo purposes, we'll simulate an update check
        
        DispatchQueue.global(qos: .background).async {
            // Simulate network request
            Thread.sleep(forTimeInterval: 1.0)
            
            DispatchQueue.main.async {
                // Simulate update available
                self.isUpdateAvailable = false // Set to true to test
                self.latestVersion = "1.1.0"
                self.updateNotes = "• Added new cursive fonts\n• Improved terminal detection\n• Bug fixes and performance improvements"
            }
        }
    }
}

// MARK: - Analytics Manager (Privacy-focused)
class AnalyticsManager: ObservableObject {
    private let userDefaults = UserDefaults.standard
    
    func trackFontInstallation(_ font: CursiveFont) {
        // Track font installation for improving the app (no personal data)
        let count = userDefaults.integer(forKey: "font_installs_\(font.name)") + 1
        userDefaults.set(count, forKey: "font_installs_\(font.name)")
    }
    
    func trackTerminalConfiguration(_ terminal: TerminalApp) {
        // Track terminal usage to understand user preferences
        let count = userDefaults.integer(forKey: "terminal_configs_\(terminal.name)") + 1
        userDefaults.set(count, forKey: "terminal_configs_\(terminal.name)")
    }
    
    func getUsageStats() -> [String: Int] {
        // Return anonymous usage statistics
        var stats: [String: Int] = [:]
        
        for font in CursiveFont.sampleFonts {
            stats["font_\(font.name)"] = userDefaults.integer(forKey: "font_installs_\(font.name)")
        }
        
        for terminal in TerminalApp.supportedTerminals {
            stats["terminal_\(terminal.name)"] = userDefaults.integer(forKey: "terminal_configs_\(terminal.name)")
        }
        
        return stats
    }
}