#!/bin/bash

# Check for administrative privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root or with administrative privileges."
    exit 1
fi

# Enable the WSL feature
echo "Enabling WSL feature..."
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

echo "Enabling Virtual Machine Platform..."
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Install the latest WSL kernel
echo "Installing the latest WSL kernel..."
wsl --update

# Set WSL version to 2
wsl --set-default-version 2

# Install a Linux distribution (Ubuntu in this case)
DISTRO_NAME="Ubuntu-20.04"
echo "Installing $DISTRO_NAME..."
if ! wsl --list --online | grep -q "$DISTRO_NAME"; then
    echo "$DISTRO_NAME is not available. Please check available distributions with 'wsl --list --online'."
    exit 1
fi
wsl --install -d $DISTRO_NAME

# Wait for WSL installation to complete
wsl.exe ~ -e exit || echo "WSL setup complete. Please launch your distro manually to complete initialization."

# Update Linux packages
echo "Updating Linux packages..."
wsl.exe ~ -e sudo apt-get update && wsl.exe ~ -e sudo apt-get upgrade -y

# Install Docker on WSL
echo "Installing Docker..."
wsl.exe ~ -e sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

wsl.exe ~ -e curl -fsSL https://download.docker.com/linux/ubuntu/gpg | wsl.exe ~ -e sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
    wsl.exe ~ -e sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

wsl.exe ~ -e sudo apt-get update
wsl.exe ~ -e sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Add the current user to the Docker group
wsl.exe ~ -e sudo groupadd docker || true
wsl.exe ~ -e sudo usermod -aG docker $USER

# Enable Docker service
wsl.exe ~ -e sudo service docker start

# Install other essentials
echo "Installing essentials..."
wsl.exe ~ -e sudo apt-get install -y wget subversion git

# Verify installation
echo "Verifying installation..."
docker --version
svn --version
git --version

# Prompt user to restart for WSL and Docker to work fully
echo "Setup complete. Please restart your computer for all changes to take effect."
