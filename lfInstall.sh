#! /bin/bash

# Set up LF file manager with one script, Installs all the packages and configs needed

# Download the latest release from github
echo "Downloading Latest Release"

# Download the archive
wget https://github.com/horriblename/lf/releases/latest/download/lf-linux-amd64.tar.gz > /dev/null 2>&1


# Extract to ~/bin
mkdir -p "$HOME"/bin
tar -xvzf lf-linux-amd64.tar.gz -C "$HOME"/bin/
chmod +x "$HOME"/bin/lf

export_line="export PATH=\"$HOME/bin:$PATH\""
echo "$export_line" >> ~/.bashrc 
echo "Export $PATH:$HOME/bin command added to .bashrc"

# Remove the archive
rm lf-linux-amd64.tar.gz


echo "Downloading the configs"

git clone https://github.com/SumitKhatri712/dotfiles
mkdir -p "$HOME"/.config/lf
cp -r dotfiles/.config/lf "$HOME"/.config/
chmod +x "$HOME"/.config/lf/preview


echo "Installing dependencies"

# Check distribution and perform package installation accordingly
if [[ -f /etc/debian_version || -f /etc/lsb-release ]]; then
    # Debian/Ubuntu
    package_manager="apt"
    packages=("libssl-dev" "libmagic-dev")

    # Check if the packages are installed
    if ! dpkg -s "${packages[@]}" >/dev/null 2>&1; then
        echo "Packages ${packages[*]} are not installed. Installing..."
        # Install the packages
        "$package_manager" install -y "${packages[@]}"
    else
        echo "Packages ${packages[*]} are already installed."
    fi

elif [[ -f /etc/fedora-release ]]; then
    # Fedora
    package_manager="dnf"
    packages=("openssl-devel" "file-devel")

    # Check if the packages are installed
    if ! rpm -q "${packages[@]}" >/dev/null 2>&1; then
        echo "Packages ${packages[*]} are not installed. Installing..."
        # Install the packages
        "$package_manager" install -y "${packages[@]}"
    else
        echo "Packages ${packages[*]} are already installed."
    fi

elif [[ -f /etc/arch-release ]]; then
    # Arch-based distributions
    package_manager="pacman"
    packages=("openssl" "file")

    # Check if the packages are installed
    if ! "$package_manager" -Qs "${packages[@]}" >/dev/null 2>&1; then
        echo "Packages ${packages[*]} are not installed. Installing..."
        # Install the packages
        "$package_manager" -S --noconfirm "${packages[@]}"
    else
        echo "Packages ${packages[*]} are already installed."
    fi

else
    echo "Unsupported distribution. Exiting..."
    exit 1
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


