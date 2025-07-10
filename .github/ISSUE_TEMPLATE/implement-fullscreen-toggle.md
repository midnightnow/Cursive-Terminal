---
name: Implement Fullscreen Toggle
about: Add cinematic fullscreen mode with keyboard shortcut
title: '[FEATURE] Implement fullscreen toggle (⌘⇧F)'
labels: good-first-issue, ui
assignees: ''
---

## 🏴‍☠️ Ahoy, contributor!

We need to implement a fullscreen toggle that transforms the terminal into a cinematic experience.

### 📋 Requirements

- [ ] Keyboard shortcut: `⌘⇧F` (Mac) / `Ctrl+Shift+F` (Windows/Linux)
- [ ] Smooth fade transition (300ms)
- [ ] Remember previous window size
- [ ] Return to exact previous position within 100ms
- [ ] Work in both Electron and web contexts

### 🛠️ Technical Details

**File to modify:** `scripts/immersive-persona-system.js`

**Key functions to implement:**
```javascript
enterCinematicMode() {
  // Store current window state
  // Fade to black
  // Enter fullscreen
  // Fade from black
}

exitCinematicMode() {
  // Fade to black
  // Exit fullscreen
  // Restore window state
  // Fade from black
}
```

### ✅ Acceptance Criteria

1. Pressing `⌘⇧F` toggles fullscreen
2. Transitions are smooth (no jarring jumps)
3. Previous window size/position restored exactly
4. Works on all platforms
5. Escape key also exits fullscreen

### 🎯 Bonus Points

- Add a subtle vignette effect in fullscreen
- Play a "woosh" sound on transition
- Show a toast notification: "Entering cinematic mode"

### 📚 Resources

- [Electron Fullscreen API](https://www.electronjs.org/docs/latest/api/browser-window#winsetfullscreenflag)
- [Fullscreen API for Web](https://developer.mozilla.org/en-US/docs/Web/API/Fullscreen_API)
- [Our immersive roadmap](../docs/IMMERSIVE_ROADMAP_V2.md)

### 🏴‍☠️ First time contributing?

1. Fork the repo
2. Create branch: `feature/fullscreen-toggle`
3. Make changes
4. Test on your machine
5. Submit PR with before/after GIF

**Need help?** Drop a comment below or join our Discord!

*"Fair winds and following seas!"* ⛵