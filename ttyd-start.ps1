# ttyd Start Script for Windows
#
# Starts ttyd web terminal server with PowerShell Campbell Dark theme
# See .claude/context/ttyd-theme-configuration.md for details
#
# Usage: .\ttyd-start.ps1
# Access: http://localhost:7681

Write-Host "Starting ttyd web terminal..."
Write-Host "Port: 7681"
Write-Host "URL: http://localhost:7681"
Write-Host "Font: Cascadia Code, size 12, 1.2 line height, 0.6 letter spacing"
Write-Host "Theme: PowerShell Campbell Dark"
Write-Host "Renderer: canvas (optimized for VM)"
Write-Host "Press Ctrl+C to stop"
Write-Host ""

# Note: PowerShell has issues with JSON escaping for theme configuration
# Using bash script wrapper for reliable theme application
# See: .claude/context/ttyd-theme-configuration.md for details
& "bash.exe" "-c" "./ttyd-custom.sh"
