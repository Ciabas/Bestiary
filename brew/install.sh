#!/bin/bash
# Install Homebrew

set -e

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "✓ Homebrew installed successfully"
echo ""
