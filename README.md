# Dotfiles

Terminal with zsh, ghostty, and starship.

## Install before
- zsh
- JetBrainsMono Nerd Font
- ghostty
- starship
- direnv
- eza

## Quick Start

```bash
# Clone the repository
git clone https://github.com/piri9825/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Run installation script
chmod +x scripts/install.sh
./scripts/install.sh

# Restart your terminal or source the config
source ~/.zshrc
```

## Customization
### Git user configuration
After installation, set your git identity in `~/.config/git/local.gitconfig`:

```ini
[user]
	name = Your Actual Name
	email = your.email@example.com
```

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
rm ~/.zshrc
rm -rf ~/.config/zsh
```
