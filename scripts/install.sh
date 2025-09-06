#!/bin/bash
# Dotfiles installation script

set -e

DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in the dotfiles directory
if [[ ! -f "$DOTFILES_DIR/scripts/install.sh" ]]; then
    log_error "Please run this script from the dotfiles directory"
    exit 1
fi

log_info "Starting dotfiles installation..."

# Create symlinks
create_symlink() {
    local source="$1"
    local target="$2"

    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$target")"
    
    log_info "Creating symlink: $target -> $source"
    ln -sf "$source" "$target"
}

# Symlinks
create_symlink "$DOTFILES_DIR/config/zsh/zshrc" "$CONFIG_DIR/zsh/zshrc"
create_symlink "$DOTFILES_DIR/config/zsh/aliases.zsh" "$CONFIG_DIR/zsh/aliases.zsh"
create_symlink "$DOTFILES_DIR/config/git/gitconfig" "$CONFIG_DIR/git/gitconfig"
create_symlink "$DOTFILES_DIR/config/git/gitignore_global" "$CONFIG_DIR/git/gitignore_global"
create_symlink "$CONFIG_DIR/git/gitconfig" "$HOME/.gitconfig"
create_symlink "$DOTFILES_DIR/config/starship/starship.toml" "$CONFIG_DIR/starship.toml"
create_symlink "$DOTFILES_DIR/config/ghostty/config" "$CONFIG_DIR/ghostty/config"

# Link main zshrc to standard location
echo 'export ZDOTDIR="$HOME/.config/zsh"' > "$HOME/.zshrc"
echo 'source "$ZDOTDIR/zshrc"' >> "$HOME/.zshrc"

# Create local config file if it doesn't exist
if [[ ! -f "$CONFIG_DIR/zsh/local.zsh" ]]; then
    log_info "Creating local zsh configuration file..."
    cat > "$CONFIG_DIR/zsh/local.zsh" << 'EOF'
# ~/.config/zsh/local.zsh - Local machine-specific configuration
# Add any machine-specific settings here

# Example:
# export EDITOR="nvim"
# alias work="cd ~/work"
EOF
fi

# Create local git config if it doesn't exist
if [[ ! -f "$CONFIG_DIR/git/local.gitconfig" ]]; then
    log_info "Creating local git configuration file..."
    cat > "$CONFIG_DIR/git/local.gitconfig" << 'EOF'
# ~/.config/git/local.gitconfig - Local git configuration
# Machine-specific git settings

[user]
	name = Your Name
	email = your.email@example.com
EOF
fi

log_info "Installation complete!"
log_info "Please edit ~/.config/git/local.gitconfig with your actual name and email"
log_info "Then run 'source ~/.zshrc' or restart your terminal to apply changes."

# Optional: Install plugins immediately
read -p "Install zsh plugins now? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    log_info "Installing plugins..."
    zsh -c "source $CONFIG_DIR/zsh/zshrc"
    log_info "Plugins installed!"
fi