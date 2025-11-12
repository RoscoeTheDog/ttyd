# ttyd Theme and Font Configuration

## Overview

This document describes the configuration for ttyd to match PowerShell's appearance with custom fonts and themes, including issues encountered and their solutions.

## Final Working Configuration

### Font Settings
- **Font Family:** Cascadia Code (with Consolas fallback)
- **Font Size:** 12px
- **Line Height:** 1.2
- **Letter Spacing:** 0.6

### Cursor Settings
- **Style:** Bar
- **Blink:** Disabled (false)

### Theme
- **Color Scheme:** PowerShell Campbell Dark
- **Background:** #0C0C0C (very dark, almost black)
- **Foreground:** #CCCCCC
- **Renderer:** Canvas (optimized for VM environments)

### Complete Color Palette
```json
{
  "background": "#0C0C0C",
  "foreground": "#CCCCCC",
  "cursor": "#FFFFFF",
  "cursorAccent": "#000000",
  "selectionBackground": "#FFFFFF",
  "black": "#0C0C0C",
  "red": "#C50F1F",
  "green": "#13A10E",
  "yellow": "#C19C00",
  "blue": "#0037DA",
  "magenta": "#881798",
  "cyan": "#3A96DD",
  "white": "#CCCCCC",
  "brightBlack": "#767676",
  "brightRed": "#E74856",
  "brightGreen": "#16C60C",
  "brightYellow": "#F9F1A5",
  "brightBlue": "#3B78FF",
  "brightMagenta": "#B4009E",
  "brightCyan": "#61D6D6",
  "brightWhite": "#F2F2F2"
}
```

## Issues Encountered and Solutions

### Issue 1: PowerShell JSON Escaping
**Problem:** When passing theme configuration via PowerShell script using single quotes around JSON, the theme colors were not applied correctly. Background appeared grey instead of black.

**Cause:** PowerShell's handling of single-quoted strings with complex JSON caused improper escaping when passing arguments to ttyd.exe.

**Solution:** Use bash script for ttyd startup, which handles JSON escaping correctly:
```bash
./ttyd.exe -W -p 7681 -w "$USERPROFILE" \
  -t 'theme={"background":"#0C0C0C",...}' \
  cmd.exe
```

### Issue 2: Canvas Renderer Color Support
**Initial Concern:** Canvas renderer might not support full color themes.

**Resolution:** Canvas renderer fully supports custom themes. The issue was related to JSON escaping in PowerShell, not the renderer itself.

### Issue 3: Browser Caching
**Problem:** Configuration changes not appearing after server restart.

**Solution:** Hard refresh required after configuration changes:
- **Windows/Linux:** Ctrl+Shift+R or Ctrl+F5
- **macOS:** Cmd+Shift+R

### Issue 4: URL Parameter Overrides
**Discovery:** URL parameters always override server-side `-t` flags.

**Use Case:** Can append settings to URL for testing:
```
http://localhost:7681/?fontSize=12&lineHeight=1.2&cursorStyle=bar&cursorBlink=false
```

## Recommended Startup Scripts

### For Git Bash / MSYS2
Use `ttyd-custom.sh`:
```bash
./ttyd-custom.sh
```

### For PowerShell
Use `ttyd-start-fixed.ps1` (wrapper that calls bash script):
```powershell
.\ttyd-start-fixed.ps1
```

**Note:** Direct PowerShell script (`ttyd-start.ps1`) has JSON escaping issues with theme configuration. The `-fixed` version wraps the bash script to avoid this problem.

## Configuration Methods Comparison

### Method 1: Server-Side Flags (Recommended)
```bash
ttyd -t fontSize=12 -t lineHeight=1.2 -t 'theme={...}' cmd.exe
```
**Pros:** Permanent, users don't need to remember URL parameters
**Cons:** Requires correct shell escaping (bash works, PowerShell has issues)

### Method 2: URL Parameters
```
http://localhost:7681/?fontSize=12&lineHeight=1.2
```
**Pros:** Always works, overrides server settings
**Cons:** Must be bookmarked or typed each time

### Method 3: Hybrid (Used in ttyd-custom.sh)
Server-side flags + bash script for proper escaping
**Pros:** Best of both worlds - permanent and reliable
**Cons:** Requires bash/Git Bash on Windows

## Testing Configuration

To verify all settings are applied:

1. Start ttyd with custom configuration
2. Open http://localhost:7681 in browser
3. Hard refresh (Ctrl+Shift+R)
4. Check:
   - Background is very dark (#0C0C0C), not grey
   - Font is Cascadia Code (or Consolas fallback)
   - Text size matches PowerShell
   - Cursor is a bar and doesn't blink
   - ANSI colors match PowerShell Campbell scheme

## Copy/Paste Support

ttyd uses xterm.js which has built-in browser clipboard support:

- **Copy:** Select text with mouse (automatically copies)
- **Paste:**
  - Right-click, or
  - Ctrl+Shift+V (Windows/Linux)
  - Cmd+V (macOS)

**Note:** Ctrl+C and Ctrl+V are terminal control sequences (Ctrl+C = interrupt), so browsers use Ctrl+Shift variants.

## Related Files

- `ttyd-custom.sh` - Main startup script with correct JSON escaping
- `ttyd-start-fixed.ps1` - PowerShell wrapper for bash script
- `ttyd-start.ps1` - Direct PowerShell implementation (has theme issues)

## References

- ttyd documentation: https://github.com/tsl0922/ttyd
- xterm.js terminal options: https://xtermjs.org/docs/api/terminal/interfaces/iterminaloptions/
- PowerShell Campbell colors: Windows Terminal color schemes
