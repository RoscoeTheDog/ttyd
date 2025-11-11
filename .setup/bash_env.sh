#!/bin/bash
# ttyd Development Environment Setup for Bash/MSYS2
# Source this file from ~/.bashrc to add ttyd to PATH

TTYD_DEV_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Add ttyd binary to PATH
export PATH="$PATH:$TTYD_DEV_ROOT"

# Add WinGet to PATH (if not already present)
if [[ ":$PATH:" != *":/c/Users/Admin/AppData/Local/Microsoft/WindowsApps:"* ]]; then
    export PATH="$PATH:/c/Users/Admin/AppData/Local/Microsoft/WindowsApps"
fi

# Add Scoop to PATH (if installed)
if [ -d "$HOME/scoop/shims" ] && [[ ":$PATH:" != *":$HOME/scoop/shims:"* ]]; then
    export PATH="$PATH:$HOME/scoop/shims"
fi

echo "ttyd dev environment loaded: $TTYD_DEV_ROOT"
