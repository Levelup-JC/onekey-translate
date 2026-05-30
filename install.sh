#!/bin/bash
set -e

echo ""
echo "  ╔══════════════════════════════════════╗"
echo "  ║     OneKey Translate Installer       ║"
echo "  ║  Save 40%+ LLM tokens with English   ║"
echo "  ╚══════════════════════════════════════╝"
echo ""

# ── 1. Install Hammerspoon ──
if [ -d "/Applications/Hammerspoon.app" ]; then
  echo "✓ Hammerspoon already installed"
else
  echo "→ Installing Hammerspoon..."
  if command -v brew &>/dev/null; then
    brew install --cask hammerspoon
  else
    echo "✗ Homebrew not found. Install it first: https://brew.sh"
    echo "  Or install Hammerspoon manually: https://www.hammerspoon.org"
    exit 1
  fi
  echo "✓ Hammerspoon installed"
fi

# ── 2. Deploy config ──
mkdir -p ~/.hammerspoon
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cp "$SCRIPT_DIR/init.lua" ~/.hammerspoon/init.lua
echo "✓ Config deployed to ~/.hammerspoon/init.lua"

# ── 3. Launch Hammerspoon ──
open -a Hammerspoon 2>/dev/null || true
echo "✓ Hammerspoon launched"

# ── 4. Instructions ──
echo ""
echo "  ┌──────────────────────────────────────┐"
echo "  │  NEXT STEP: Grant permissions        │"
echo "  │                                      │"
echo "  │  System Settings → Privacy &         │"
echo "  │  Security → Accessibility            │"
echo "  │  → toggle Hammerspoon ON             │"
echo "  └──────────────────────────────────────┘"
echo ""
echo "  Hotkeys:"
echo "    Cmd+E       → ZH → EN  (translate + replace)"
echo "    Cmd+Shift+E → EN → ZH  (translate + popup)"
echo "    Double-tap E → ZH → EN  (same as Cmd+E)"
echo ""
echo "  Voice input (optional):"
echo "    • Apple Dictation (built-in, press Fn twice)"
echo "    • Doubao Input: https://www.doubao.com/input/"
echo "    • iFlytek Input: https://srf.xunfei.cn/"
echo ""
echo "  Done! 🚀"
