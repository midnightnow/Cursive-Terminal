#!/usr/bin/env python3

"""Create a theme grid showcase image using PIL"""

from PIL import Image, ImageDraw, ImageFont
import os
import glob

# Configuration
THEME_DIR = "/Users/studio/Cursive-Terminal/docs/images/theme-demos"
OUTPUT_DIR = "/Users/studio/Cursive-Terminal/docs/images"
GRID_COLS = 6
GRID_ROWS = 5
THUMB_WIDTH = 400
THUMB_HEIGHT = 250
PADDING = 10
BG_COLOR = (10, 10, 10)  # Dark background

# Featured themes to show in order
FEATURED_THEMES = [
    "vampires-letter",
    "pirate-scroll",
    "ancient-papyrus",
    "rainbow-prism",
    "cursive-elegance",
    "neon-cyberpunk",
    
    "ocean-mist",
    "calligraphy-scroll",
    "tropical-paradise",
    "midnight-quill",
    "illuminated-manuscript",
    "aurora-borealis",
    
    "cursive-noir",
    "ivory-parchment",
    "sunset-festival",
    "forest-grove",
    "office-memo",
    "cotton-candy",
    
    "sunset-glow",
    "linen-manuscript",
    "receipt-paper",
    "cursive-garden",
    "legal-document",
    "invisible-ink",
    
    "blueprint-tech",
    "papyrus-scroll",
    "carbon-copy",
    "ditto-spirit",
    "linen-sheet",
    "calligraphy-flourish",
]

def create_theme_grid():
    """Create a grid of theme screenshots"""
    
    # Calculate final image size
    grid_width = GRID_COLS * (THUMB_WIDTH + PADDING) + PADDING
    grid_height = GRID_ROWS * (THUMB_HEIGHT + PADDING) + PADDING
    
    # Create base image
    grid_img = Image.new('RGB', (grid_width, grid_height), BG_COLOR)
    
    # Process each theme
    for idx, theme_name in enumerate(FEATURED_THEMES[:GRID_COLS * GRID_ROWS]):
        theme_path = os.path.join(THEME_DIR, theme_name, "demo.png")
        
        if os.path.exists(theme_path):
            # Load and resize theme image
            theme_img = Image.open(theme_path)
            theme_img.thumbnail((THUMB_WIDTH, THUMB_HEIGHT), Image.Resampling.LANCZOS)
            
            # Calculate position in grid
            col = idx % GRID_COLS
            row = idx // GRID_COLS
            x = PADDING + col * (THUMB_WIDTH + PADDING)
            y = PADDING + row * (THUMB_HEIGHT + PADDING)
            
            # Create frame with border
            frame = Image.new('RGB', (THUMB_WIDTH, THUMB_HEIGHT), (51, 51, 51))
            
            # Center the theme image in frame
            paste_x = (THUMB_WIDTH - theme_img.width) // 2
            paste_y = (THUMB_HEIGHT - theme_img.height) // 2
            frame.paste(theme_img, (paste_x, paste_y))
            
            # Paste frame into grid
            grid_img.paste(frame, (x, y))
            
            print(f"✅ Added {theme_name} at position ({col}, {row})")
        else:
            print(f"❌ Theme not found: {theme_name}")
    
    # Save the grid
    output_path = os.path.join(OUTPUT_DIR, "theme-gallery-grid.png")
    grid_img.save(output_path, optimize=True)
    print(f"\n🎨 Theme grid saved to: {output_path}")
    print(f"   Size: {grid_width}x{grid_height}px")

def create_preview_strips():
    """Create smaller preview strips for README"""
    
    # Dark themes preview (3x1)
    dark_themes = ["vampires-letter", "pirate-scroll", "midnight-quill"]
    create_strip(dark_themes, "dark-themes-preview.png")
    
    # Light themes preview (3x1)
    light_themes = ["ancient-papyrus", "calligraphy-scroll", "illuminated-manuscript"]
    create_strip(light_themes, "light-themes-preview.png")
    
    # Colorful themes preview (3x1)
    colorful_themes = ["rainbow-prism", "neon-cyberpunk", "tropical-paradise"]
    create_strip(colorful_themes, "colorful-themes-preview.png")

def create_strip(theme_names, output_name):
    """Create a horizontal strip of 3 themes"""
    strip_width = 3 * (THUMB_WIDTH + PADDING) + PADDING
    strip_height = THUMB_HEIGHT + 2 * PADDING
    
    strip_img = Image.new('RGB', (strip_width, strip_height), BG_COLOR)
    
    for idx, theme_name in enumerate(theme_names):
        theme_path = os.path.join(THEME_DIR, theme_name, "demo.png")
        
        if os.path.exists(theme_path):
            theme_img = Image.open(theme_path)
            theme_img.thumbnail((THUMB_WIDTH, THUMB_HEIGHT), Image.Resampling.LANCZOS)
            
            x = PADDING + idx * (THUMB_WIDTH + PADDING)
            y = PADDING
            
            strip_img.paste(theme_img, (x, y))
    
    output_path = os.path.join(OUTPUT_DIR, output_name)
    strip_img.save(output_path, optimize=True)
    print(f"✅ Created {output_name}")

if __name__ == "__main__":
    print("🎨 Creating theme showcase images...")
    print(f"   Theme directory: {THEME_DIR}")
    print(f"   Output directory: {OUTPUT_DIR}")
    print()
    
    # Check available themes
    available = [d for d in os.listdir(THEME_DIR) 
                 if os.path.isfile(os.path.join(THEME_DIR, d, "demo.png"))]
    print(f"📊 Found {len(available)} themes with screenshots")
    print()
    
    # Create main grid
    create_theme_grid()
    print()
    
    # Create preview strips
    print("📸 Creating preview strips...")
    create_preview_strips()
    
    print("\n✨ All done!")