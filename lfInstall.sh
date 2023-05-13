#! /bin/bash

# Set up LF file manager with one script, Installs all the packages and configs needed

# Download the latest release from github
echo "Downloading Latest Release"

# Download the archive
wget https://github.com/horriblename/lf/releases/latest/download/lf-linux-amd64.tar.gz 

# Extract to ~/bin
mkdir -p $HOME/bin
sudo tar -xvzf lf-linux-amd64.tar.gz -C $HOME/bin/
sudo chmod +x $HOME/bin/lf

# Remove the archive
rm lf-linux-amd64.tar.gz


echo "Downloading the configs"

git clone https://github.com/SumitKhatri712/dotfiles
mkdir -p $HOME/.config/lf
cp -r dotfiles/.config/lf $HOME/.config/


echo "Installing dependencies"
if [ -f /etc/debian_version ]; then
    # Debian/Ubuntu
    sudo apt-get update
    sudo apt-get install -y libssl-dev libmagic-dev chafa
elif [ -f /etc/redhat-release ]; then
    # CentOS/RHEL/Fedora
    sudo yum install -y openssl-devel file-devel chafa
elif [ -f /etc/arch-release ]; then
    # Arch Linux
    sudo pacman -S openssl libmagic chafa
else
    echo "Unsupported distribution. Please install libssl-dev, libmagic-dev, and chafa manually."
fi

echo "Setting Up Go-Mono nerd font"
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Go-Mono.zip
mkdir -p Go-Mono
unzip Go-Mono.zip -d Go-Mono
sudo mv Go-Mono /usr/share/fonts/truetype/
fc-cache -f -v

echo "Fetching and Compiling ctpv"
git clone https://github.com/NikitaIvanovV/ctpv
cd ctpv
make
sudo make install
cd ..
rm -rf ctpv


