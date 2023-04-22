#! /bin/bash

# Set up LF file manager with one script, Installs all the packages and configs needed

# Download the latest release from github
echo "Downloading Latest Release"

# Download the archive
wget https://github.com/horriblename/lf/releases/latest/download/lf-linux-amd64.tar.gz 
# Extract to /usr/bin
mkdir -p ~/bin
sudo tar -xvzf lf-linux-amd64.tar.gz -C ~/bin/
chmod +x ~/bin/lf
# Remove the archive
rm lf-linux-amd64.tar.gz


echo "Downloading the configs"

git clone https://github.com/SumitKhatri712/dotfiles
mkdir -p ~/.config/lf
cp -a dotfiles/lf ~/.config/lf


echo "Fetching and Compiling ctpv"
sudo apt install libssl-dev libmagic-dev
sudo apt install chafa
git clone https://github.com/NikitaIvanovV/ctpv
cd ctpv
make
sudo make install
cd ..
rm -rf ctpv


