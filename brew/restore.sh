#!/bin/bash
# Install packages from Brewfile

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$SCRIPT_DIR/Brewfile"

if [ ! -f "$BREWFILE" ]; then
  echo "❌ Error: Brewfile not found at $BREWFILE"
  exit 1
fi

if ! command -v brew &> /dev/null; then
  echo "❌ Error: Homebrew is not installed"
  echo "Run: ./install.sh"
  exit 1
fi

echo "Installing packages from Brewfile..."
brew bundle install --file="$BREWFILE"

echo "✓ All packages installed successfully"
