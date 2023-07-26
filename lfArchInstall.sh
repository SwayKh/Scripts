#!/bin/bash

sudo pacman -S --needed lf

read -n1 -r -p "Install my configs and dependencies(sumitkhatri712)? [y,N]" doit 

if [[ "$doit" == "y" || "$doit" == "Y" ]]; then
	echo "Downloading the configs"
	git clone https://github.com/SumitKhatri712/dotfiles
	mkdir -p "$HOME"/.config/lf
	cp -r dotfiles/.config/lf "$HOME"/.config/
	chmod +x "$HOME"/.config/lf/preview
  sudo pacman -S --needed chafa bat cat glow mdcat tar unrar unzip
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
