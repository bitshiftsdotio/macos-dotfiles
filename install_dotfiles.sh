#!/bin/bash

# Make .config directory in home folder if it does not exist
[[ -d ~/.config ]] || mkdir ~/.config

# Install alacritty configuration
if [[ -f ~/.config/alacritty.yml ]]; then
    echo "- Skipping alacritty installation as a config file already exists."
else
    echo "- Installing alacritty configuration..."
    ln -s "$(pwd)/alacritty.yml" ~/.config/
fi

