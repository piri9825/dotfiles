# Dotfiles

Terminal setup with zsh, ghostty, and starship.

## Quick Start

```bash
# Clone the repository
git clone https://github.com/piri9825/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Run installation script (installs dependencies + creates symlinks)
chmod +x scripts/install.sh
./scripts/install.sh

# Restart your terminal or source the config
source ~/.zshrc
```

The install script detects your OS and handles dependencies automatically:

- **macOS** — installs everything via `brew bundle` using `scripts/Brewfile`
- **Linux** — installs packages via your native package manager (`apt`, `dnf`, or `pacman`), plus starship and nvm via their official install scripts

> **macOS prerequisite:** [Homebrew](https://brew.sh) must be installed before running the script.

> **Linux note:** Ghostty must be installed manually. See the [Ghostty install docs](https://ghostty.org/docs/install/binary) for your distro.

### Installing dependencies separately

If you want to install dependencies without running the full setup:

```bash
# macOS
brew bundle --file=scripts/Brewfile

# Linux
chmod +x scripts/packages.sh
./scripts/packages.sh
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
