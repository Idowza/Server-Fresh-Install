#!/bin/bash 

# Show line numbers as green text 
export PS4=$'\e[1;32m+ ${LINENO}: \e[0m'

# Enable tracing mode (show the code being executed)) 
set -x

# Function to handle errors in the script 
handle_error() {
  echo -e "\033[0;31mAn error occurred in line $1. Continuing with the rest of the script.\033[0m"
}

# Set up error handling with the trap command
trap 'handle_error $LINENO' ERR

# Create a function for updating the system and removing unnecessary packages
update_system() {
  sudo apt update -y
  sudo apt upgrade -y
  sudo flatpak update -y
  sudo apt autoremove -y
  sudo apt autoclean -y
  sudo apt autopurge -y
  sudo apt install -f -y
}
#update the system
update_system

# search for OEM kernels with the following command
sudo apt search linux-oem-2

# Set User Variables
# kernvar is the variable for the OEM kernel
read -p $'\e[1;33mPlease enter which OEM kernel to install (e.g. linux-oem-22.04d):\e[0m ' kernvar

# Install repositories
# Flatpak is a software utility for software deployment, package management, and application virtualization
sudo add-apt-repository -y ppa:flatpak/stable
# Papirus Icon Theme
sudo add-apt-repository -y ppa:papirus/papirus

#update the system
update_system

# Function to install a package and check its status
install_package() {
  local package=$1
  sudo apt install -y "$package"
  if [ $? -ne 0 ]; then
    echo "An error occurred during the installation of $package."
    exit 1
  fi
}

# Function to install a Flatpak and check its status
install_flatpak() {
  local flatpak=$1
  sudo flatpak install -y "$flatpak"
  if [ $? -ne 0 ]; then
    echo "An error occurred during the installation of $flatpak."
    exit 1
  fi
}

# List of packages to install
packages=(
  "$kernvar"
  "nemo-image-converter"
  "nemo-media-columns"
  "openssh-server"
  "virt-manager"
  "resolvconf"
  "wireguard"
  "wireguard-tools"
  "btop"
  "git"
  "wget"
  "curl"
  "papirus-icon-theme"
  "x11vnc"
)

# Install Packages
for package in "${packages[@]}"; do
  install_package "$package"
done

echo "Packages installed successfully."

# Update the system
update_system

# List of Flatpaks to install
flatpaks=(
  "com.github.tchx84.Flatseal"
  "org.qbittorrent.qBittorrent"
)

# Install Flatpaks
for flatpak in "${flatpaks[@]}"; do
  install_flatpak "$flatpak"
done

echo "Flatpaks installed successfully."

#Plex Server
echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
sudo apt update -y
sudo apt install -y plexmediaserver

#Add Plex Group
sudo adduser steven plex

# Update the system
update_system

exit 0