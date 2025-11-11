# ttyd Development Branch Installation

## Overview

This setup configures your shell environment to use the ttyd binary from this development branch, keeping all setup files containerized within the repository.

## Structure

```
ttyd/
├── .setup/
│   ├── bash_env.sh          # Bash/MSYS2/Git Bash setup
│   ├── powershell_env.ps1   # PowerShell setup
│   ├── README.md            # Usage documentation
│   └── INSTALLATION.md      # This file
├── ttyd.exe                 # Downloaded binary (gitignored)
└── .gitignore              # Updated to track .setup/ but ignore ttyd.exe
```

## Installation Steps

### 1. System Profile Setup

The setup scripts are sourced from your shell profiles, keeping the actual configuration in the repository.

#### Bash/Git Bash/MSYS2

Your `~/.bashrc` now contains:

```bash
# Added by Claude Code - Source ttyd dev environment
if [ -f "$HOME/Documents/GitHub/ttyd/.setup/bash_env.sh" ]; then
    source "$HOME/Documents/GitHub/ttyd/.setup/bash_env.sh"
fi
```

#### PowerShell

Your `~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1` now contains:

```powershell
# Added by Claude Code - Source ttyd dev environment
$ttydEnvPath = "$env:USERPROFILE\Documents\GitHub\ttyd\.setup\powershell_env.ps1"
if (Test-Path $ttydEnvPath) {
    . $ttydEnvPath
}
```

### 2. Verify Installation

Open a **new shell session** and run:

```bash
# Check version
ttyd --version
# Should output: ttyd version 1.7.7-40e79c7

# Check which binary is being used
which ttyd  # Bash
Get-Command ttyd  # PowerShell
```

## What Gets Configured

1. **ttyd binary**: Added to PATH from `<repo_root>/ttyd.exe`
2. **WinGet**: Ensures `%LOCALAPPDATA%\Microsoft\WindowsApps` is in PATH
3. **Scoop**: Automatically detected and added if installed at `%USERPROFILE%\scoop\shims`

## Benefits of This Approach

✅ **Containerized**: All setup files live in the repository
✅ **Version controlled**: Setup scripts are tracked in git
✅ **Portable**: Easy to share with collaborators
✅ **Clean**: System profiles only contain a simple source statement
✅ **Maintainable**: Update setup by modifying files in `.setup/`
✅ **Branch-specific**: Different branches can have different setups

## Running ttyd

### Basic Usage

```bash
# Run PowerShell in browser
ttyd "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"

# Run cmd.exe (simpler path)
ttyd cmd.exe

# Custom port
ttyd -p 8080 cmd.exe

# Allow write access
ttyd -W cmd.exe
```

### Access in Browser

After starting ttyd, open: `http://localhost:7681`

## Git Tracking

The `.gitignore` is configured to:
- ✅ **Track** `.setup/` directory and all its contents
- ❌ **Ignore** `ttyd.exe` (downloaded binary)
- ❌ **Ignore** `ttyd_*.exe` (WinGet download artifacts)

## Troubleshooting

### ttyd not found after restarting shell

1. Verify the profile was loaded:
   ```bash
   # Bash
   echo $PATH | grep ttyd

   # PowerShell
   $env:Path -split ';' | Select-String ttyd
   ```

2. Manually source the setup:
   ```bash
   # Bash
   source ~/Documents/GitHub/ttyd/.setup/bash_env.sh

   # PowerShell
   . $env:USERPROFILE\Documents\GitHub\ttyd\.setup\powershell_env.ps1
   ```

### CreateProcessW error 123 when running ttyd

Use the full path to PowerShell:
```bash
ttyd "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
```

Or test with cmd.exe first:
```bash
ttyd cmd.exe
```

## Uninstallation

To remove ttyd from your PATH:

1. Remove the source lines from your shell profiles:
   - `~/.bashrc` (Bash)
   - `~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1` (PowerShell)

2. Restart your shell

The `.setup/` directory will remain in the repository for future use.

## Updating

To update ttyd:

1. Download new binary to `ttyd/ttyd.exe`
2. Restart your shell (setup scripts auto-detect the binary)

To update setup scripts:

1. Edit files in `.setup/`
2. Commit changes to your dev branch
3. Restart your shell to load updates
