#!/bin/bash

function homebrew_cask_install {
    brew cask install $1

    if  [ $? -ne 0 ]; then
        echo "💥 Cask $1 installation failed."
    fi
}

function homebrew_install {
    brew install $1

    if  [ $? -ne 0 ]; then
        echo "💥 Homebrew package $1 installation failed."
    fi
}

echo "❗❗❗ WARNING ❗❗❗"
echo "This script will install all kinds of software on your computer."
echo "If you don't want this, then you should quit now."
echo "You will also need sudo privileges to continue."
echo ""

read -n 1 -p "This script will install a fresh suite of software on your Mac. Continue? (y/n): " ans;

case $ans in
    y|Y)
        ;;
    *)
        exit
        ;;
esac

echo ""

# Check if Homebrew is installed, and if not, install it.
which brew &> /dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Homebrew should be installed now. If not, assume that the installation failed and bail out.
which brew &> /dev/null

if [ $? -ne 0 ]; then
    echo "💥 Homebrew installation failed - exiting."
    exit 1
fi

# Install desktop apps.
homebrew_cask_install alacritty
homebrew_cask_install jetbrains-toolbox
homebrew_cask_install firefox
homebrew_cask_install cyberduck
homebrew_cask_install spotify
homebrew_cask_install tunnelblick
homebrew_cask_install vmware-fusion

# Install command-line tools.
homebrew_install wget
homebrew_install pyenv

echo "✅ Done!"

read -n 1 -p "Would you like to install the config files? (y/n): " ans;

case $ans in
    y|Y)
        ;;
    *)
        exit
        ;;
esac

echo ""

bash install_dotfiles.sh