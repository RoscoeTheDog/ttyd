#!/bin/bash
# ttyd with PowerShell Campbell Dark theme
# Font: Cascadia Code, Size: 12, Line Height: 1.2, Letter Spacing: 0.6

./ttyd.exe -W -p 7681 -w "$USERPROFILE" \
  -t rendererType=canvas \
  -t fontSize=12 \
  -t 'fontFamily=Cascadia Code, Consolas, monospace' \
  -t lineHeight=1.2 \
  -t letterSpacing=0.6 \
  -t cursorStyle=bar \
  -t cursorBlink=false \
  -t 'theme={"background":"#0C0C0C","foreground":"#CCCCCC","cursor":"#FFFFFF","cursorAccent":"#000000","selectionBackground":"#FFFFFF","black":"#0C0C0C","red":"#C50F1F","green":"#13A10E","yellow":"#C19C00","blue":"#0037DA","magenta":"#881798","cyan":"#3A96DD","white":"#CCCCCC","brightBlack":"#767676","brightRed":"#E74856","brightGreen":"#16C60C","brightYellow":"#F9F1A5","brightBlue":"#3B78FF","brightMagenta":"#B4009E","brightCyan":"#61D6D6","brightWhite":"#F2F2F2"}' \
  cmd.exe
