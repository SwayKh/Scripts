#!/bin/bash

# FOR UBUNTU AND FEDORA USE THIS SCRIPT, FOR ARCH USE lfArchInstall.sh

# Check if the script is running as root
# if [[ $EUID -ne 0 ]]; then
#     echo "This script must be run as root. Please run it with sudo or as root user."
#     exit 1
# fi

# Set up LF file manager with one script, Installs all the packages and configs needed


# Download the latest release from GitHub
echo "Downloading Latest Release"
wget https://github.com/horriblename/lf/releases/latest/download/lf-linux-amd64.tar.gz > /dev/null 2>&1

# Extract to ~/bin
mkdir -p "$HOME"/bin
tar -xvzf lf-linux-amd64.tar.gz -C "$HOME"/bin/
chmod +x "$HOME"/bin/lf

# Add to PATH
export_line="export PATH=\"$HOME/bin:$PATH\""
echo "$export_line" >> ~/.bashrc
echo "Export PATH:~/bin command added to .bashrc"


rm lf-linux-amd64.tar.gz

read -n1 -r -p "Install my configs and dependencies(sumitkhatri712)? [y,N]" doit 

if [[ "$doit" == "y" || "$doit" == "Y" ]]; then
	echo "Downloading the configs"
	git clone https://github.com/SumitKhatri712/dotfiles
	mkdir -p "$HOME"/.config/lf
	cp -r dotfiles/.config/lf "$HOME"/.config/
	chmod +x "$HOME"/.config/lf/preview
  sudo apt install bat cat tar unzip
fi

# Installing dependencies

echo "Installing dependencies"


if command -v apt &>/dev/null; then
    sudo apt install -y libmagic-dev libssl-dev
elif command -v dnf &>/dev/null; then
    sudo dnf install -y openssl-devel file-devel
fi


echo "Setting Up Go-Mono nerd font"
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Go-Mono.zip > /dev/null 2>&1
mkdir -p Go-Mono
unzip Go-Mono.zip -d Go-Mono > /dev/null 2>&1
mv Go-Mono /usr/share/fonts/truetype/
fc-cache -f -v > /dev/null 2>&1

echo "Fetching and Compiling ctpv"
git clone https://github.com/NikitaIvanovV/ctpv
cd ctpv || exit
make > /dev/null 2>&1
make install >/dev/null 2>&1
cd ..
rm -rf ctpv

echo " "
echo "Please set your Terminal Font to a nerd-font before proceeding"
