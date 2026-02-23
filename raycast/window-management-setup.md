# Raycast Window Management Migration Guide

This guide helps you migrate from Slate to Raycast's built-in Window Management extension.

## Why Raycast?

- **Already installed** - You're already using Raycast (in brew-cask.sh)
- **No extra app** - One less background process running
- **Native integration** - Works seamlessly with Raycast launcher
- **Customizable** - Supports all your existing keyboard shortcuts

## Setup Instructions

### 1. Enable Window Management Extension

1. Open Raycast (`⌘ + Space`)
2. Type "Extensions" and press Enter
3. Search for "Window Management"
4. Click on it and ensure it's enabled

### 2. Configure Keyboard Shortcuts

Open Raycast Settings (`⌘ + ,`) → Extensions → Window Management

Configure the following shortcuts to match your Slate setup:

| Action | Shortcut | Description |
|--------|----------|-------------|
| **Left Half** | `⌥ + ←` | Push window to left half of screen |
| **Right Half** | `⌥ + →` | Push window to right half of screen |
| **Maximize** | `⌥ + ↑` | Maximize window to full screen |
| **Top Left** | `⌥ + ⇧ + ←` | Move to top-left quarter |
| **Top Right** | `⌥ + ⇧ + →` | Move to top-right quarter |
| **Bottom Left** | `⌥ + ⌃ + ←` | Move to bottom-left quarter |
| **Bottom Right** | `⌥ + ⌃ + →` | Move to bottom-right quarter |
| **Next Display** | `⌥ + ⌃ + ⌘ + →` | Move to next monitor |
| **Previous Display** | `⌥ + ⌃ + ⌘ + ←` | Move to previous monitor |

### 3. Additional Useful Shortcuts

Consider adding these for even more control:

- **Center** - Center window on screen
- **Next Third** - Cycle through thirds of the screen
- **First Third**, **Second Third**, **Last Third** - Snap to specific thirds
- **Almost Maximize** - Maximize but leave some margin

### 4. Optional: Disable Native macOS Shortcuts

To avoid conflicts, you may want to disable native macOS window management:

System Settings → Desktop & Dock → Windows → Disable:
- "Tiling by dragging windows to screen edges"
- Any conflicting keyboard shortcuts

## Migration Checklist

- [ ] Raycast Window Management extension enabled
- [ ] `⌥ + ←` configured for Left Half
- [ ] `⌥ + →` configured for Right Half
- [ ] `⌥ + ↑` configured for Maximize
- [ ] Quarter-screen shortcuts configured
- [ ] Multi-monitor shortcuts configured
- [ ] Test all shortcuts work correctly
- [ ] Remove `.slate` from your dotfiles
- [ ] Uninstall Slate application (if installed via Homebrew: `brew uninstall --cask slate`)

## Troubleshooting

### Shortcuts not working?
- Check Raycast has Accessibility permissions:  
  System Settings → Privacy & Security → Accessibility → Raycast (enabled)
- Ensure shortcuts don't conflict with other apps
- Try restarting Raycast

### Window not moving?
- Some apps (especially those with custom window management) may not work perfectly
- Try using the Raycast command palette instead: `⌘ + Space` → type "Left Half"

### Want to go back to Slate?
- Simply re-enable Slate and disable Raycast Window Management
- Your `.slate` config has been backed up in git history

## Comparison: Slate vs Raycast

| Feature | Slate | Raycast WM |
|---------|-------|------------|
| Config file | `.slate` text file | GUI settings |
| Custom layouts | ✅ Yes | ⚠️ Limited |
| Monitor-specific layouts | ✅ Yes | ❌ No |
| Window hints | ✅ Yes | ❌ No |
| Learning curve | Steep | Minimal |
| Performance | Good | Excellent |
| Maintenance | Unmaintained | Actively developed |

## Additional Resources

- [Raycast Window Management Documentation](https://www.raycast.com/extensions/window-management)
- [Raycast Shortcuts](https://www.raycast.com/shortcuts)

---

**Note:** This file was created as part of the dotfiles modernization. Your original `.slate` configuration has been preserved in git history.
