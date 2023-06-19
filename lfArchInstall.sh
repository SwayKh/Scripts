#!/bin/bash

# Check if the script is running as root
# if [[ $EUID -ne 0 ]]; then
    # echo "This script must be run as root. Please run it with sudo or as root user."
    # exit 1
# fi

# Set up LF file manager with one script, Installs all the packages and configs needed

# No need for this code on Arch, LF is available in the Repo

# # Download the latest release from GitHub
# echo "Downloading Latest Release"
# wget https://github.com/horriblename/lf/releases/latest/download/lf-linux-amd64.tar.gz
# 
# # Extract to ~/bin
# mkdir -p "$HOME"/bin
# tar -xvzf lf-linux-amd64.tar.gz -C "$HOME"/bin/
# chmod +x "$HOME"/bin/lf
# 
# # Add to PATH
# export_line="export PATH=\"$HOME/bin:$PATH\""
# echo "$export_line" >> ~/.bashrc
# echo "Export \"$PATH:$HOME/bin\" command added to .bashrc"
# 
# 
# rm lf-linux-amd64.tar.gz

sudo pacman -S --needed lf

read -n1 -r -p "Install my configs(sumitkhatri712)? [y,N]" doit 

if [[ "$doit" == "y" || "$doit" == "Y" ]]; then
	echo "Downloading the configs"
	git clone https://github.com/SumitKhatri712/dotfiles
	mkdir -p "$HOME"/.config/lf
	cp -r dotfiles/.config/lf "$HOME"/.config/
	chmod +x "$HOME"/.config/lf/preview
fi

# Installing dependencies
echo "Installing Dependencies"

package_manager="pacman"
packages=("openssl" "file")
# Check if the packages are installed
if ! $package_manager -Qs "${packages[@]}" >/dev/null 2>&1; then
    echo "Packages ${packages[*]} are not installed. Installing..."
    sudo $package_manager -S --needed --noconfirm "${packages[@]}"
else
    echo "Packages ${packages[*]} are already installed."
fi

echo "Setting Up Go-Mono nerd font"
sudo pacman -S --needed --noconfirm ttf-go-nerd

echo "Fetching and Compiling ctpv, Hope you have yay installed"
yay -S ctpv-git
