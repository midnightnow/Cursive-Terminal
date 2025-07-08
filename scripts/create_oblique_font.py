#!/usr/bin/env python3
"""
Script to create an oblique (slanted) version of a monospace font
that maintains monospace spacing while giving a cursive appearance.
"""

import fontforge
import sys
import os

def create_oblique_font(input_font_path, output_font_path, slant_angle=15):
    """
    Create an oblique version of a font by applying a slant transformation.
    
    Args:
        input_font_path: Path to the input font file
        output_font_path: Path where the oblique font will be saved
        slant_angle: Angle of slant in degrees (default: 15)
    """
    try:
        # Open the font
        font = fontforge.open(input_font_path)
        
        # Select all glyphs
        font.selection.all()
        
        # Apply slant transformation
        # Convert angle to radians for the skew matrix
        import math
        slant_radians = math.radians(slant_angle)
        
        # Create transformation matrix for slant (skew transformation)
        # Matrix format: [xx, xy, yx, yy, dx, dy]
        # For skew: [1, 0, tan(angle), 1, 0, 0]
        skew_matrix = (1, 0, math.tan(slant_radians), 1, 0, 0)
        
        # Apply the transformation
        font.transform(skew_matrix)
        
        # Update font metadata
        original_name = font.fontname
        font.fontname = f"{original_name}Oblique"
        font.fullname = f"{font.fullname} Oblique"
        font.familyname = f"{font.familyname} Oblique"
        
        # Generate the new font
        font.generate(output_font_path)
        print(f"Successfully created oblique font: {output_font_path}")
        
        # Close the font
        font.close()
        
    except Exception as e:
        print(f"Error creating oblique font: {e}")
        sys.exit(1)

def main():
    # Default to using SF Mono (macOS default monospace font)
    input_font = "/System/Library/Fonts/SFNSMono.ttf"
    output_font = "/Users/studio/SFMonoOblique.ttf"
    
    if len(sys.argv) > 1:
        input_font = sys.argv[1]
    if len(sys.argv) > 2:
        output_font = sys.argv[2]
    
    if not os.path.exists(input_font):
        print(f"Error: Input font file not found: {input_font}")
        sys.exit(1)
    
    print(f"Creating oblique version of: {input_font}")
    print(f"Output will be saved to: {output_font}")
    
    create_oblique_font(input_font, output_font)

if __name__ == "__main__":
    main()