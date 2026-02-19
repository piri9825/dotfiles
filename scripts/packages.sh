#!/bin/bash
# Linux dependency installer
# Supports apt (Debian/Ubuntu), dnf (Fedora/RHEL), and pacman (Arch)

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Detect package manager
if command -v apt &>/dev/null; then
    PKG_MANAGER="apt"
    log_info "Detected package manager: apt"
    sudo apt update -qq
    INSTALL="sudo apt install -y"
elif command -v dnf &>/dev/null; then
    PKG_MANAGER="dnf"
    log_info "Detected package manager: dnf"
    INSTALL="sudo dnf install -y"
elif command -v pacman &>/dev/null; then
    PKG_MANAGER="pacman"
    log_info "Detected package manager: pacman"
    INSTALL="sudo pacman -S --noconfirm"
else
    log_error "No supported package manager found (apt, dnf, pacman)"
    exit 1
fi

# Install packages available in native repos
log_info "Installing base packages..."
case "$PKG_MANAGER" in
    apt)
        $INSTALL zsh direnv eza
        ;;
    dnf)
        $INSTALL zsh direnv eza
        ;;
    pacman)
        $INSTALL zsh direnv eza
        ;;
esac

# Starship — official install script is the most reliable cross-distro method
if ! command -v starship &>/dev/null; then
    log_info "Installing starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
else
    log_info "starship already installed, skipping"
fi

# nvm — not in package managers, installed via official script
if [[ ! -d "$HOME/.nvm" ]]; then
    log_info "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/HEAD/install.sh | bash
else
    log_info "nvm already installed, skipping"
fi

# JetBrainsMono Nerd Font
if ! fc-list | grep -qi "JetBrainsMono"; then
    log_info "Installing JetBrainsMono Nerd Font..."
    FONT_DIR="$HOME/.local/share/fonts/JetBrainsMono"
    mkdir -p "$FONT_DIR"
    LATEST=$(curl -sI https://github.com/ryanoasis/nerd-fonts/releases/latest | grep -i location | sed 's/.*\/v//' | tr -d '[:space:]')
    curl -Lo /tmp/JetBrainsMono.tar.xz \
        "https://github.com/ryanoasis/nerd-fonts/releases/download/v${LATEST}/JetBrainsMono.tar.xz"
    tar -xf /tmp/JetBrainsMono.tar.xz -C "$FONT_DIR"
    rm /tmp/JetBrainsMono.tar.xz
    fc-cache -f
    log_info "JetBrainsMono Nerd Font installed"
else
    log_info "JetBrainsMono Nerd Font already installed, skipping"
fi

# Ghostty — installation varies significantly by distro
log_warn "Ghostty must be installed manually on Linux."
log_warn "Visit https://ghostty.org/docs/install/binary for your distro's instructions."

log_info "Done! Run the main install.sh to set up symlinks."
