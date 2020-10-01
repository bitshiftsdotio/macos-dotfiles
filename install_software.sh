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

casks=(
    alacritty               # Alacritty - a GPU-accelerated terminal emulator for macOS
    jetbrains-toolbox       # JetBrains Toolbox - used to install JetBrains apps and keep them up to date
    firefox                 # Firefox - free open source web browser
    cyberduck               # Cyberduck - file transfer client for macOS
    spotify                 # Spotify - for my banging tunes
    tunnelblick             # Tunnelblick - nice OpenVPN client for macOS
    vmware-fusion           # VMware Fusion - virtual machine hypervisor
    postman                 # Postman - used for API testing
)

packages=(
    wget                    # wget - download files from the command line
    pyenv                   # pyenv - Python environment manager
    tmux                    # tmux - Terminal muxer
    ninja                   # ninja - lightweight build system
    cmake                   # cmake - multiplatform Makefile generator 
)

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
homebrew_cask_install ${casks[@]}

# Install command-line tools.
homebrew_install ${packages[@]}

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
