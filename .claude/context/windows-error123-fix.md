# TTYD Windows Error 123 Fix

## Issue
ttyd version 1.7.7 on Windows has a bug where it fails with:
```
CreateProcessW failed with error 123: The filename, directory name, or volume label syntax is incorrect.
```

This error occurs when a browser connects to ttyd via WebSocket, even though ttyd starts successfully and listens on the port.

## Root Cause
ttyd 1.7.7 has a bug on Windows where it fails to properly resolve the current working directory when spawning the child process (cmd.exe, PowerShell, etc.) via the CreateProcessW API.

## References
- GitHub Issue: https://github.com/tsl0922/ttyd/issues/1292
- Related: https://github.com/tsl0922/ttyd/issues/1410

## Solution
**Add the `-w` flag with an explicit working directory:**

```powershell
ttyd.exe -W -p 7681 -w "C:\Users\Admin" cmd.exe
```

The `-w` flag explicitly sets the working directory, bypassing the buggy directory resolution code in ttyd 1.7.7.

## Working Configuration

### Primary Script: `ttyd-start.ps1`
Located at project root for easy access:
```powershell
# Clean environment and start ttyd with bugfix
$env:TERM = $null
$env:MSYSTEM = $null
$env:SHELL = $null

& ".\ttyd.exe" -W -p 7681 -w "$env:USERPROFILE" cmd.exe
```

### Usage
```powershell
# Start ttyd server
.\ttyd-start.ps1

# Access in browser
http://localhost:7681
```

### Alternative: Use bash instead of cmd
```powershell
& ".\ttyd.exe" -W -p 7681 -w "$env:USERPROFILE" bash.exe
```

## Alternative Solutions (Not Used)

1. **Downgrade to ttyd 1.7.3**: Version 1.7.3 reportedly works without the `-w` flag, but we're using 1.7.7 with the workaround.

2. **Full path to cmd.exe**: Using `C:\Windows\System32\cmd.exe` alone doesn't fix the issue - the `-w` flag is still required.

## Current Setup

- **Binary**: Official ttyd 1.7.7 (`ttyd.win32.exe` from GitHub releases)
- **Location**: Project root (`C:\Users\Admin\Documents\GitHub\ttyd\ttyd.exe`)
- **Workaround**: `-w` flag with working directory
- **Use Case**: Development debugging tool (not production)

## Notes

- The bug is specific to Windows
- The `-w` flag MUST come before the command argument
- Correct: `ttyd -W -w DIR cmd.exe`
- Wrong: `ttyd -W cmd.exe -w DIR` (passes `-w` to cmd.exe, not ttyd)

## VM Performance Optimization

### Renderer Selection

ttyd uses **WebGL by default**, which requires GPU acceleration. In VM environments, this causes lag/poor performance.

**Solution**: Use canvas renderer for better VM performance:
```powershell
& ".\ttyd.exe" -W -p 7681 -w "$env:USERPROFILE" -t rendererType=canvas cmd.exe
```

### Available Renderers
### Available Renderers

- **`canvas`** (✅ Recommended for VMs): CPU-based Canvas2D rendering with full terminal features, no GPU required, smooth performance in VMs
- **`webgl`** (Default): GPU-accelerated WebGL rendering, best performance on real hardware but laggy in VMs without GPU passthrough  
- **`dom`**: DOM-based fallback renderer, limited features but maximum compatibility
The `ttyd-start.ps1` script is already configured with canvas renderer for optimal VM performance.
