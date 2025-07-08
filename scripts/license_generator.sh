#!/bin/bash
# License Generator for Cursive Terminal Setup
# Creates a proper MIT license for the repository

echo "📜 Generating MIT License..."

# Get current year
YEAR=$(date +%Y)

# Default to generic copyright holder
COPYRIGHT_HOLDER="Cursive Terminal Setup Contributors"

# Ask for copyright holder name (optional)
echo ""
echo "Who should be listed as the copyright holder?"
echo "Press Enter for default: '$COPYRIGHT_HOLDER'"
read -p "Copyright holder: " input_holder

if [[ -n "$input_holder" ]]; then
    COPYRIGHT_HOLDER="$input_holder"
fi

# Generate the MIT license
cat > LICENSE << EOF
MIT License

Copyright (c) $YEAR $COPYRIGHT_HOLDER

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

echo "✅ MIT License created successfully!"
echo ""
echo "📄 License saved to: LICENSE"
echo ""
echo "🎉 Your repository is now properly licensed for open source distribution!"