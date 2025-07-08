#!/usr/bin/env python3
"""
Font Preview Generator for Cursive Terminal Setup
Creates PNG images showing text samples in different fonts
"""
import os
from PIL import Image, ImageDraw, ImageFont
import sys

def create_font_preview(font_path, font_name, output_dir="docs/images"):
    """Create a preview image for a font showing cursive text samples"""
    
    # Ensure output directory exists
    os.makedirs(output_dir, exist_ok=True)
    
    # Image settings
    width, height = 800, 200
    background_color = (40, 44, 52)  # Dark background like terminal
    text_color = (171, 178, 191)     # Light gray text
    
    # Sample texts to showcase cursive features
    samples = [
        "function fibonacci(n) {",
        "  // Beautiful cursive code",
        "  return n <= 1 ? n : fib(n-1) + fib(n-2);",
        "}"
    ]
    
    try:
        # Create image
        img = Image.new('RGB', (width, height), background_color)
        draw = ImageDraw.Draw(img)
        
        # Try to load the font
        try:
            font = ImageFont.truetype(font_path, 16)
        except (OSError, IOError):
            print(f"Warning: Could not load {font_path}, using default font")
            font = ImageFont.load_default()
        
        # Draw the font name as header
        header_font = ImageFont.truetype(font_path, 20) if font_path else ImageFont.load_default()
        draw.text((20, 10), f"{font_name}", fill=(98, 209, 150), font=header_font)
        
        # Draw sample text lines
        y_offset = 50
        for line in samples:
            draw.text((20, y_offset), line, fill=text_color, font=font)
            y_offset += 25
        
        # Save the image
        output_path = os.path.join(output_dir, f"{font_name.lower().replace(' ', '_')}_preview.png")
        img.save(output_path)
        print(f"✅ Created preview: {output_path}")
        return output_path
        
    except Exception as e:
        print(f"❌ Error creating preview for {font_name}: {e}")
        return None

def generate_all_previews():
    """Generate previews for all installed cursive fonts"""
    
    # Font paths - common locations on macOS
    font_locations = [
        ("~/Library/Fonts/VictorMono-Italic.otf", "Victor Mono Italic"),
        ("~/Library/Fonts/CascadiaCodeItalic.otf", "Cascadia Code Italic"),
        ("~/Library/Fonts/JetBrainsMonoNL-Italic.ttf", "JetBrains Mono Italic"),
        ("~/Library/Fonts/FiraCode-Retina.otf", "Fira Code"),
        ("/System/Library/Fonts/SFNSMono.ttf", "SF Mono"),
        ("SFMonoOblique.ttf", "SF Mono Oblique (Custom)")
    ]
    
    print("🎨 Generating font previews...")
    created_previews = []
    
    for font_path, font_name in font_locations:
        # Expand user path
        expanded_path = os.path.expanduser(font_path)
        
        if os.path.exists(expanded_path):
            preview_path = create_font_preview(expanded_path, font_name)
            if preview_path:
                created_previews.append((font_name, preview_path))
        else:
            print(f"⚠️  Font not found: {expanded_path}")
    
    # Generate updated gallery markdown
    generate_gallery_with_images(created_previews)
    
    return created_previews

def generate_gallery_with_images(previews):
    """Generate an updated gallery markdown with image previews"""
    
    gallery_content = """# 🎨 Font Gallery

This gallery showcases the beautiful cursive fonts available in the cursive terminal setup.

## Font Previews

Each font below shows the same code sample to help you compare styles:

"""
    
    for font_name, preview_path in previews:
        # Convert absolute path to relative for markdown
        relative_path = os.path.relpath(preview_path, "docs")
        
        gallery_content += f"""### {font_name}

![{font_name} Preview]({relative_path})

---

"""
    
    gallery_content += """
## How to Test Fonts

Run the font comparison script to see these fonts in your terminal:

```bash
cd cursive-terminal-setup
./scripts/font_comparison.sh
```

## Installation Notes

- **Victor Mono**: Best overall cursive experience
- **Cascadia Code**: Microsoft's elegant approach
- **JetBrains Mono**: Subtle cursive with excellent readability
- **Fira Code**: Great ligatures with cursive italics
- **SF Mono Oblique**: Custom slanted version we created

Choose the font that matches your coding style and aesthetic preferences!
"""
    
    # Write the updated gallery
    os.makedirs("docs", exist_ok=True)
    with open("docs/FONT_GALLERY.md", "w") as f:
        f.write(gallery_content)
    
    print("✅ Updated docs/FONT_GALLERY.md with image previews")

if __name__ == "__main__":
    try:
        from PIL import Image, ImageDraw, ImageFont
    except ImportError:
        print("❌ Pillow not installed. Run: pip install Pillow")
        sys.exit(1)
    
    previews = generate_all_previews()
    
    if previews:
        print(f"\n🎉 Generated {len(previews)} font previews!")
        print("📁 Images saved to: docs/images/")
        print("📄 Updated gallery: docs/FONT_GALLERY.md")
    else:
        print("❌ No font previews could be generated")