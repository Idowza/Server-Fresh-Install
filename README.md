# Server Fresh Install Script

A Bash script to automate the setup of a fresh Linux homelab server (Ubuntu/Debian based).

## Features

This script automates the following tasks:
- **System Updates**: Updates, upgrades, and cleans up the system.
- **Kernel Installation**: Optionally installs OEM kernels.
- **Repository Setup**: Adds repositories for Flatpak and Papirus.
- **Package Installation**: Installs essential tools and utilities including:
    - OpenSSH Server
    - Virt-Manager (KVM/QEMU)
    - WireGuard
    - Btop
    - Git, Wget, Curl
    - Nemo extensions
    - x11vnc
- **Flatpak Support**: Installs Flatpak and specific apps (Flatseal, qBittorrent).
- **Plex Media Server**: Installs the latest Plex Media Server and adds the current user to the `plex` group.

## Usage

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/Idowza/Server-Fresh-Install.git
    cd Server-Fresh-Install
    ```

2.  **Make the script executable:**
    ```bash
    chmod +x fresh.sh
    ```

3.  **Run the script:**
    ```bash
    ./fresh.sh
    ```
    *Note: The script will ask for `sudo` permissions during execution.*

## Configuration

- **Kernel Selection**: You will be prompted to enter a specific OEM kernel version (e.g., `linux-oem-22.04d`). You can press Enter to skip this step.
- **User Groups**: The script automatically adds the user running the script to the `plex` group for easier media management.

## Compatibility

This script is designed for Debian-based distributions (specifically tailored for Ubuntu LTS releases given the PPA and OEM kernel usage).
