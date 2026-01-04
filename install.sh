#!/bin/bash

set -euo pipefail

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check sudo privileges
check_sudo() {
    if ! sudo -n true 2>/dev/null; then
        log_info "sudo privileges required. Please enter your password."
        sudo -v
    fi
}

# Detect distribution
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
    elif [ -f /etc/debian_version ]; then
        DISTRO="debian"
    elif [ -f /etc/redhat-release ]; then
        DISTRO="rhel"
    elif [ -f /etc/arch-release ]; then
        DISTRO="arch"
    else
        log_error "Unsupported distribution."
        exit 1
    fi
    
    log_info "Detected distribution: $DISTRO"
}

# Detect package manager
detect_package_manager() {
    case $DISTRO in
        ubuntu|debian)
            PKG_MANAGER="apt"
            UPDATE_CMD="sudo apt-get update"
            INSTALL_CMD="sudo apt-get install -y"
            ;;
        fedora|rhel|centos)
            PKG_MANAGER="dnf"
            UPDATE_CMD="sudo dnf check-update || true"
            INSTALL_CMD="sudo dnf install -y"
            ;;
        arch|manjaro)
            PKG_MANAGER="pacman"
            UPDATE_CMD="sudo pacman -Sy"
            INSTALL_CMD="sudo pacman -S --noconfirm"
            ;;
        *)
            log_error "Unsupported distribution: $DISTRO"
            exit 1
            ;;
    esac
    
    log_info "Package manager: $PKG_MANAGER"
}

# Detect display server
detect_display_server() {
    if [ -n "${WAYLAND_DISPLAY:-}" ] || [ "${XDG_SESSION_TYPE:-}" = "wayland" ]; then
        DISPLAY_SERVER="wayland"
        CLIPBOARD_PKG="wl-clipboard"
    elif [ -n "${DISPLAY:-}" ]; then
        DISPLAY_SERVER="x11"
        CLIPBOARD_PKG="xclip"
    else
        log_warn "Could not detect display server. Assuming X11."
        DISPLAY_SERVER="x11"
        CLIPBOARD_PKG="xclip"
    fi
    
    log_info "Detected display server: $DISPLAY_SERVER"
    log_info "Clipboard tool to install: $CLIPBOARD_PKG"
}

# Install package
install_package() {
    local package=$1
    log_info "Installing: $package"
    
    if $INSTALL_CMD "$package"; then
        log_info "Successfully installed $package."
    else
        log_error "Failed to install $package."
        return 1
    fi
}

# Check if package is installed
is_installed() {
    local package=$1
    case $PKG_MANAGER in
        apt)
            dpkg -l | grep -q "^ii  $package " && return 0 || return 1
            ;;
        dnf)
            rpm -q "$package" >/dev/null 2>&1 && return 0 || return 1
            ;;
        pacman)
            pacman -Qi "$package" >/dev/null 2>&1 && return 0 || return 1
            ;;
    esac
}

# Main function
main() {
    log_info "Installing dependencies for dotfiles..."
    
    # Check sudo privileges
    check_sudo
    
    # Detect distribution
    detect_distro
    
    # Detect package manager
    detect_package_manager
    
    # Update package list
    log_info "Updating package list..."
    $UPDATE_CMD
    
    # Install tmux
    if is_installed "tmux"; then
        log_info "tmux is already installed."
    else
        install_package "tmux"
    fi
    
    # Detect display server
    detect_display_server
    
    # Install clipboard tool
    if is_installed "$CLIPBOARD_PKG"; then
        log_info "$CLIPBOARD_PKG is already installed."
    else
        install_package "$CLIPBOARD_PKG"
    fi
    
    log_info "All installations completed!"
    log_info ""
    log_info "Next steps:"
    log_info "1. Copy .gitconfig: cp $(pwd)/.gitconfig ~/.gitconfig"
    log_info "2. Link or copy .tmux.conf: ln -s $(pwd)/.tmux.conf ~/.tmux.conf"
    log_info "3. Set git user configuration:"
    log_info "   git config --global user.name \"Your Name\""
    log_info "   git config --global user.email \"your.email@example.com\""
}

# Run script
main "$@"

