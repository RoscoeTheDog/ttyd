# TTYD Windows Development Setup - Summary

## Final Configuration

This is a local fork of ttyd configured for Windows development/debugging use.

### What Works
- **ttyd 1.7.7** (official Windows binary from GitHub releases)
- **Single-command startup** via `ttyd-start.ps1`
- **cmd.exe terminal** in browser on port 7681
- **Working directory fix** applied (resolves error 123)

### Quick Start
```powershell
# From project root
.\ttyd-start.ps1

# Access in browser
http://localhost:7681
```

### File Structure
```
ttyd/
├── ttyd.exe                                    # Official binary (1.7.7)
├── ttyd-start.ps1                              # Startup script with bugfix
├── README.md                                   # Updated with Windows fork section
└── .claude/context/
    ├── windows-error123-fix.md                 # Technical documentation of the fix
    └── SETUP-SUMMARY.md                        # This file
```

### What Was Removed
- `scripts/` directory (11 bash scripts for tmux/MSYS2 setup)
- All temporary test scripts
- Old log files
- Duplicate documentation

### The Bug & Fix

**Problem:** ttyd 1.7.7 on Windows crashes with "CreateProcessW failed with error 123" when browser connects.

**Cause:** ttyd fails to resolve current working directory on Windows.

**Solution:** Add `-w` flag with explicit working directory:
```powershell
ttyd.exe -W -p 7681 -w "$env:USERPROFILE" cmd.exe
```

**References:**
- GitHub Issue: https://github.com/tsl0922/ttyd/issues/1292
- Full details: `.claude/context/windows-error123-fix.md`

### Development Notes

- **Not for production** - This is a development/debugging tool
- **Windows-specific** - The `-w` flag workaround is required only on Windows
- **No tmux** - Removed all tmux/MSYS2 complexity for simplicity
- **Clean environment** - Clears MSYS2 variables that can interfere

### Binary Info
- **Source:** https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.win32.exe
- **Version:** 1.7.7-40e79c7
- **Size:** 1.4M
- **Type:** PE32+ executable (native Windows)

### Alternative Shells

To use bash instead of cmd.exe:
```powershell
# Edit ttyd-start.ps1, change last line to:
& ".\ttyd.exe" -W -p 7681 -w "$env:USERPROFILE" bash.exe
```

To use PowerShell:
```powershell
& ".\ttyd.exe" -W -p 7681 -w "$env:USERPROFILE" powershell.exe
```

### Troubleshooting

**Still getting error 123?**
- Ensure you're using the `-w` flag
- Verify the working directory path exists
- Run from PowerShell (not Git Bash or MSYS2)

**Port already in use?**
- Change port in `ttyd-start.ps1`: `-p 8080`
- Or kill existing ttyd: `taskkill /F /IM ttyd.exe`

**Can't connect in browser?**
- Check firewall settings
- Try: http://127.0.0.1:7681 instead of localhost
