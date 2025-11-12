# ttyd Start Script for Windows (calls bash script)
#
# Starts ttyd with PowerShell Campbell Dark theme
# Font: Cascadia Code, Size 18, Line Height 1.5
#
# Usage: .\ttyd-start-fixed.ps1
# Access: http://localhost:7681

Write-Host "Starting ttyd web terminal..."
Write-Host "Port: 7681"
Write-Host "URL: http://localhost:7681"
Write-Host "Font: Cascadia Code, size 12, 1.2 line height, 0.6 letter spacing"
Write-Host "Theme: PowerShell Campbell Dark"
Write-Host "Renderer: canvas (optimized for VM)"
Write-Host "Press Ctrl+C to stop"
Write-Host ""

# Call the bash script which has correct JSON escaping
& "bash.exe" "-c" "./ttyd-custom.sh"
