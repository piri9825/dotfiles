# Dotfiles

Lightweight, reproducible zsh configuration

## Quick Start

```bash
# Clone the repository
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles

# Run installation script
chmod +x scripts/install.sh
./scripts/install.sh

# Restart your terminal or source the config
source ~/.zshrc
```

## Customization

### Adding aliases
Edit `config/zsh/aliases.zsh` or add them to `~/.config/zsh/local.zsh`

### Machine-specific settings
Use `~/.config/zsh/local.zsh` for settings that shouldn't be in version control

### Adding plugins
Add to the plugin section in `config/zsh/zshrc`:

```bash
load_plugin "plugin-name" "https://github.com/user/repo.git"
```

## Uninstall

```bash
# Remove symlinks and restore backups
rm ~/.zshrc
rm -rf ~/.config/zsh
# Restore from backup files if needed
```