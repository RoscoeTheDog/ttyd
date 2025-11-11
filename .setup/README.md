# ttyd Development Environment Setup

This directory contains environment setup scripts for the ttyd development branch.

## Purpose

These scripts configure your shell environment to use the ttyd binary from this development branch, allowing you to test local changes without global installation.

## Files

- `bash_env.sh` - Setup for Bash/MSYS2/Git Bash
- `powershell_env.ps1` - Setup for PowerShell
- `README.md` - This file

## Installation

### Bash/Git Bash/MSYS2

Add to `~/.bashrc`:

```bash
# Source ttyd dev environment
if [ -f "$HOME/Documents/GitHub/ttyd/.setup/bash_env.sh" ]; then
    source "$HOME/Documents/GitHub/ttyd/.setup/bash_env.sh"
fi
```

### PowerShell

Add to `~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1`:

```powershell
# Source ttyd dev environment
$ttydEnvPath = "$env:USERPROFILE\Documents\GitHub\ttyd\.setup\powershell_env.ps1"
if (Test-Path $ttydEnvPath) {
    . $ttydEnvPath
}
```

## What Gets Added to PATH

1. **ttyd binary**: `<repo_root>/ttyd.exe`
2. **WinGet**: `%LOCALAPPDATA%\Microsoft\WindowsApps`
3. **Scoop** (if installed): `%USERPROFILE%\scoop\shims`

## Usage

After sourcing the environment scripts, you can run:

```bash
# Check version
ttyd --version

# Run PowerShell in browser
ttyd "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"

# Run with custom port
ttyd -p 8080 cmd.exe
```

## Notes

- These scripts detect the repository root automatically
- PATH additions are idempotent (won't duplicate if already present)
- Scoop support is conditional (only adds if installed)
- Changes take effect in new shell sessions

## Uninstall

To remove ttyd from your PATH, simply remove the source lines from your shell profile and restart your shell.
