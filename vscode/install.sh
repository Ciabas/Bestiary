#!/bin/bash

# VS Code configuration installer

# Ask Y/n
function ask() {
    read -p "$1 (Y/n): " resp
    if [ -z "$resp" ]; then
        response_lc="n" # empty is No
    else
        response_lc=$(echo "$resp" | tr '[:upper:]' '[:lower:]') # case insensitive
    fi

    [ "$response_lc" = "y" ]
}

echo "Installing VS Code configuration..."

# Create VS Code User directory if it doesn't exist
mkdir -p ~/Library/Application\ Support/Code/User

# Symlink settings and keybindings
if ask "Symlink settings.json?"; then
    ln -sf "$(realpath "settings.json")" ~/Library/Application\ Support/Code/User/settings.json
    echo "✓ settings.json symlinked"
fi

if ask "Symlink keybindings.json?"; then
    ln -sf "$(realpath "keybindings.json")" ~/Library/Application\ Support/Code/User/keybindings.json
    echo "✓ keybindings.json symlinked"
fi

# Install extensions
if ask "Install extensions from extensions.list?"; then
    if [ -f "extensions.list" ]; then
        count=0
        while IFS= read -r extension; do
            if [ -n "$extension" ]; then
                echo "Installing: $extension"
                code --install-extension "$extension" 2>/dev/null
                ((count++))
            fi
        done < "extensions.list"
        echo "✓ Installed $count extensions"
    else
        echo "! extensions.list not found"
    fi
fi

echo "Done!"
