# ttyd Development Environment Setup for PowerShell
# Source this file from your PowerShell profile to add ttyd to PATH

$TTYD_DEV_ROOT = Split-Path -Parent $PSScriptRoot

# Add ttyd binary to PATH
if ($env:Path -notlike "*$TTYD_DEV_ROOT*") {
    $env:Path += ";$TTYD_DEV_ROOT"
}

# Add WinGet to PATH (if not already present)
$wingetPath = "$env:LOCALAPPDATA\Microsoft\WindowsApps"
if ($env:Path -notlike "*$wingetPath*") {
    $env:Path += ";$wingetPath"
}

# Add Scoop to PATH (if installed)
$scoopPath = "$env:USERPROFILE\scoop\shims"
if ((Test-Path $scoopPath) -and ($env:Path -notlike "*$scoopPath*")) {
    $env:Path += ";$scoopPath"
}

Write-Host "ttyd dev environment loaded: $TTYD_DEV_ROOT" -ForegroundColor Green
