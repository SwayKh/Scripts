#!/bin/bash

# Check distribution and perform package installation accordingly
if [[ -f /etc/debian_version || -f /etc/lsb-release ]]; then
    # Debian/Ubuntu
    package_manager="apt"
    packages=("libssl-dev" "libmagic-dev")

    # Check if the packages are installed
    if ! dpkg -s "${packages[@]}" >/dev/null 2>&1; then
        echo "Packages ${packages[*]} are not installed. Installing..."
        # Install the packages
        sudo "$package_manager" install -y "${packages[@]}"
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
        sudo "$package_manager" install -y "${packages[@]}"
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
        sudo "$package_manager" -S --noconfirm "${packages[@]}"
    else
        echo "Packages ${packages[*]} are already installed."
    fi

else
    echo "Unsupported distribution. Exiting..."
    exit 1
fi


echo "Installing dependencies"

# Check distribution and perform package installation accordingly
if [[ -f /etc/os-release ]]; then
    source /etc/os-release
    if [[ $ID == "debian" || $ID == "ubuntu" || $ID_LIKE == *"debian"* ]]; then
        # Debian/Ubuntu and Debian-based distributions
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
    elif [[ $ID == "fedora" || $ID_LIKE == *"fedora"* ]]; then
        # Fedora and Fedora-based distributions
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
    elif [[ $ID == "arch" || $ID_LIKE == *"archlinux"* ]]; then
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
else
    echo "Unable to determine distribution. Exiting..."
    exit 1
fi

