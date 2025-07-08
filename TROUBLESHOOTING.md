# 🔧 Troubleshooting Guide

## Common Issues and Solutions

### 🚫 "I don't see any cursive text"

**Problem**: Terminal shows regular text instead of cursive.

**Solutions**:
1. **Check font setting**: Make sure you selected the *Italic* variant
   - ❌ Wrong: "Victor Mono"
   - ✅ Correct: "Victor Mono Italic"

2. **Restart terminal**: Sometimes terminals need a restart to apply font changes

3. **Test italic support**:
   ```bash
   echo -e "\e[3mThis should be italic/cursive\e[0m"
   ```
   If you see `[3m` codes, your terminal doesn't support ANSI escape codes.

### 🔤 "Font not showing in font picker"

**Problem**: Can't find Victor Mono or other fonts in terminal preferences.

**Solutions**:
1. **Verify installation**:
   ```bash
   ls ~/Library/Fonts/ | grep -i victor
   ```

2. **Restart terminal app**: Fully quit (⌘Q) and reopen

3. **Check font book**: Open Font Book app and search for the font

4. **Reinstall font**:
   ```bash
   brew reinstall font-victor-mono
   ```

### 📝 "Only some text is cursive"

**Problem**: Only italic-formatted text shows as cursive, not everything.

**Solution**: You have the regular font selected. To make EVERYTHING cursive:
- Change main font from "Victor Mono Regular" to "Victor Mono Italic"

### 🎨 "Colors look wrong"

**Problem**: Terminal colors don't match the screenshots.

**Solutions**:
1. **Apply theme**:
   ```bash
   source ~/.config/terminal-themes/cursive-elegance.sh
   ```

2. **Check terminal color settings**: Some terminals override color schemes

3. **Reset to defaults**: In terminal preferences, reset color scheme first

### ⚡ "Terminal feels slow"

**Problem**: Performance issues after setup.

**Solutions**:
1. **Disable transparency**: Transparency can slow down rendering
2. **Reduce font size**: Larger fonts = more rendering work
3. **Turn off ligatures**: In terminal preferences, disable ligatures
4. **Use lighter weight**: Try "Victor Mono Light Italic" instead

### 🖥️ "iTerm2 profile won't import"

**Problem**: Can't import the cursive profile JSON.

**Solution**:
1. Open iTerm2 Preferences
2. Go to Profiles → Other Actions → Import JSON Profiles
3. Select `configs/cursive_iterm_profile.json`
4. If that fails, manually create profile with Victor Mono Italic

### 💻 "VS Code not showing cursive"

**Problem**: VS Code doesn't use cursive fonts.

**Solution**: Add to VS Code settings.json:
```json
{
  "editor.fontFamily": "'Victor Mono', monospace",
  "editor.fontLigatures": true,
  "editor.fontSize": 14,
  "editor.fontWeight": "normal",
  "editor.tokenColorCustomizations": {
    "textMateRules": [
      {
        "scope": [
          "comment",
          "string",
          "variable.language"
        ],
        "settings": {
          "fontStyle": "italic"
        }
      }
    ]
  }
}
```

### 🔍 "Can't see the difference"

**Problem**: All fonts look the same.

**Solutions**:
1. **Check font size**: Cursive details show better at 12-16pt
2. **Compare lowercase**: Cursive is most obvious in lowercase letters
3. **Look for connections**: Victor Mono has semi-connected letters
4. **Test with code**:
   ```javascript
   // This comment should look very cursive
   const message = "Strings too!";
   ```

### 🆘 "Nothing works!"

**Nuclear option** - Complete reset:
```bash
# Backup current setup
mv ~/.zshrc ~/.zshrc.backup

# Reinstall everything
brew reinstall font-victor-mono
./install.sh

# Restart terminal
# Set font to "Victor Mono Italic"
# Run test
./scripts/cursive_font_demo.sh
```

## Still Need Help?

1. **Check your terminal**: Some terminals have limited font support
2. **Try a different terminal**: iTerm2 has the best font rendering on macOS
3. **File an issue**: https://github.com/yourusername/cursive-terminal-setup/issues

---

Remember: The most common issue is not selecting the **Italic** variant of the font!