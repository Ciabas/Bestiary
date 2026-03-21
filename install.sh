#!/bin/bash

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

# Check what shell is being used
SH="${HOME}/.bashrc"
ZSHRC="${HOME}/.zshrc"
if [ -f "$ZSHRC" ]; then
	SH="$ZSHRC"
fi

echo >> $SH
echo '# -------------- dotfiles install ---------------' >> $SH

# Ask which files should be sourced
echo "Do you want $SH to source: "
for file in shell/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        if ask "${filename}?"; then
            echo "source $(realpath "$file")" >> "$SH"
        fi
    fi
done

echo '# -------------- dotfiles install ---------------' >> $SH

# Vim conf
if ask ".vimrc?"; then
    ln -s "$(realpath ".vimrc")" ~/.vimrc
fi

# Git configuration
if ask "Git configuration files?"; then
    ln -s "$(realpath "git/config")" ~/.gitconfig
    ln -s "$(realpath "git/gitignore_global")" ~/.gitignore_global
    ln -s "$(realpath "git/gitmessage")" ~/.gitmessage
    ln -s "$(realpath "git/gitattributes")" ~/.gitattributes
fi
