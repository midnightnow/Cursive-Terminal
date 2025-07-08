import SwiftUI
import CoreText
import Foundation

// MARK: - Main App
@main
struct CursiveTerminalApp: App {
    @StateObject private var fontManager = FontManager()
    @StateObject private var terminalDetector = TerminalDetector()
    @StateObject private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(fontManager)
                .environmentObject(terminalDetector)
                .environmentObject(themeManager)
                .frame(minWidth: 800, minHeight: 600)
        }
        .windowStyle(.titleBar)
        .windowToolbarStyle(.unified)
    }
}

// MARK: - Content View
struct ContentView: View {
    @EnvironmentObject var fontManager: FontManager
    @EnvironmentObject var terminalDetector: TerminalDetector
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HeaderView()
            
            // Tab Bar
            TabBarView(selectedTab: $selectedTab)
            
            // Content Area
            TabView(selection: $selectedTab) {
                FontGalleryView()
                    .tabItem { Label("Fonts", systemImage: "textformat") }
                    .tag(0)
                
                ThemeView()
                    .tabItem { Label("Themes", systemImage: "paintpalette") }
                    .tag(1)
                
                TerminalView()
                    .tabItem { Label("Terminals", systemImage: "terminal") }
                    .tag(2)
                
                ToolsView()
                    .tabItem { Label("Tools", systemImage: "wrench.and.screwdriver") }
                    .tag(3)
                
                SettingsView()
                    .tabItem { Label("Settings", systemImage: "gear") }
                    .tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .onAppear {
            fontManager.loadFonts()
            terminalDetector.detectTerminals()
        }
    }
}

// MARK: - Header View
struct HeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Cursive Terminal")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Transform your terminal with beautiful cursive fonts")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {
                // Help action
            }) {
                Image(systemName: "questionmark.circle")
                    .font(.title2)
            }
            .buttonStyle(.borderless)
        }
        .padding()
        .background(Color(NSColor.controlBackgroundColor))
    }
}

// MARK: - Tab Bar View
struct TabBarView: View {
    @Binding var selectedTab: Int
    
    let tabs = [
        ("Fonts", "textformat"),
        ("Themes", "paintpalette"),
        ("Terminals", "terminal"),
        ("Tools", "wrench.and.screwdriver"),
        ("Settings", "gear")
    ]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<tabs.count, id: \.self) { index in
                Button(action: {
                    selectedTab = index
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: tabs[index].1)
                            .font(.system(size: 16))
                        Text(tabs[index].0)
                            .font(.caption)
                    }
                    .foregroundColor(selectedTab == index ? .accentColor : .secondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }
                .buttonStyle(.borderless)
            }
        }
        .background(Color(NSColor.controlBackgroundColor))
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(NSColor.separatorColor)),
            alignment: .bottom
        )
    }
}

// MARK: - Font Gallery View
struct FontGalleryView: View {
    @EnvironmentObject var fontManager: FontManager
    @State private var selectedFont: CursiveFont?
    
    var body: some View {
        HSplitView {
            // Font List
            VStack(alignment: .leading, spacing: 0) {
                Text("Available Fonts")
                    .font(.headline)
                    .padding()
                
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        ForEach(fontManager.fonts) { font in
                            FontCardView(font: font, isSelected: selectedFont?.id == font.id)
                                .onTapGesture {
                                    selectedFont = font
                                }
                        }
                    }
                    .padding()
                }
            }
            .frame(minWidth: 400)
            
            // Preview Area
            VStack(alignment: .leading, spacing: 16) {
                if let font = selectedFont {
                    FontPreviewView(font: font)
                } else {
                    Text("Select a font to see preview")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(minWidth: 400)
            .padding()
        }
    }
}

// MARK: - Font Card View
struct FontCardView: View {
    let font: CursiveFont
    let isSelected: Bool
    @EnvironmentObject var fontManager: FontManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Font Name and Rating
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(font.name)
                        .font(.headline)
                    Text(font.style)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                HStack(spacing: 2) {
                    ForEach(0..<5) { index in
                        Image(systemName: index < font.rating ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                            .font(.caption)
                    }
                }
            }
            
            // Preview Text
            Text("function cursive() {\n  // Beautiful code\n  return true;\n}")
                .font(.custom(font.fontName, size: 12))
                .foregroundColor(.primary)
                .padding(8)
                .background(Color(NSColor.textBackgroundColor))
                .cornerRadius(6)
            
            // Install Button
            HStack {
                if font.isInstalled {
                    Label("Installed", systemImage: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.caption)
                } else {
                    Button("Install") {
                        fontManager.installFont(font)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.small)
                }
                
                Spacer()
                
                Text(font.license)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(NSColor.controlBackgroundColor))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color.accentColor : Color.clear, lineWidth: 2)
        )
    }
}

// MARK: - Font Preview View
struct FontPreviewView: View {
    let font: CursiveFont
    @State private var previewText = """
    // Welcome to cursive coding!
    function fibonacci(n) {
        if (n <= 1) return n;
        return fibonacci(n - 1) + fibonacci(n - 2);
    }
    
    const greeting = "Hello, beautiful code!";
    console.log(greeting);
    
    // Cursive makes programming feel like poetry ✨
    """
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                VStack(alignment: .leading) {
                    Text(font.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(font.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                if font.isInstalled {
                    Button("Apply to Terminal") {
                        // Apply font action
                    }
                    .buttonStyle(.borderedProminent)
                } else {
                    Button("Install Font") {
                        // Install font action
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            
            // Preview Editor
            ScrollView {
                TextEditor(text: $previewText)
                    .font(.custom(font.fontName, size: 14))
                    .padding()
                    .background(Color(NSColor.textBackgroundColor))
                    .cornerRadius(8)
                    .frame(minHeight: 300)
            }
            
            // Font Info
            VStack(alignment: .leading, spacing: 8) {
                Text("Font Details")
                    .font(.headline)
                
                HStack {
                    Label("Designer", systemImage: "person.circle")
                    Text(font.designer)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                
                HStack {
                    Label("License", systemImage: "doc.text")
                    Text(font.license)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                
                HStack {
                    Label("File Size", systemImage: "doc.circle")
                    Text(font.fileSize)
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            .padding()
            .background(Color(NSColor.controlBackgroundColor))
            .cornerRadius(8)
        }
    }
}

// MARK: - Other Views (Simplified)
struct ThemeView: View {
    var body: some View {
        Text("Themes coming soon!")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct TerminalView: View {
    @EnvironmentObject var terminalDetector: TerminalDetector
    
    var body: some View {
        VStack {
            Text("Detected Terminals")
                .font(.headline)
            
            ForEach(terminalDetector.terminals) { terminal in
                HStack {
                    Image(systemName: terminal.icon)
                    Text(terminal.name)
                    Spacer()
                    Button("Configure") {
                        // Configure terminal
                    }
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ToolsView: View {
    var body: some View {
        Text("Tools coming soon!")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings coming soon!")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}