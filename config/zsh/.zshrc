# ~/.config/zsh/zshrc - Main zsh configuration

# History configuration
export HISTFILE="$HOME/.config/zsh/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_VERIFY
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Basic zsh options
setopt CORRECT              # command correction
setopt COMPLETE_IN_WORD     # complete from both ends of word
setopt ALWAYS_TO_END        # move cursor to end after completion
setopt AUTO_MENU            # show completion menu on successive tab press
setopt AUTO_LIST            # automatically list choices on ambiguous completion
setopt AUTO_PARAM_SLASH     # add slash if parameter is directory

# Key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[3~' delete-char

# Completions
autoload -U compinit
compinit -d "$HOME/.config/zsh/.zcompdump"

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Plugin management
PLUGIN_DIR="$HOME/.config/zsh/plugins"

load_plugin() {
    local plugin_name="$1"
    local plugin_url="$2"
    local plugin_path="$PLUGIN_DIR/$plugin_name"
    
    # Clone plugin if it doesn't exist
    if [[ ! -d "$plugin_path" ]]; then
        echo "Installing $plugin_name..."
        git clone --depth 1 "$plugin_url" "$plugin_path"
    fi
    
    # Source the plugin
    local plugin_file
    for plugin_file in "$plugin_path/$plugin_name.plugin.zsh" "$plugin_path/$plugin_name.zsh" "$plugin_path"/*.plugin.zsh; do
        if [[ -f "$plugin_file" ]]; then
            source "$plugin_file"
            break
        fi
    done
}

# Load plugins
load_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting.git"
load_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions.git"
load_plugin "zsh-history-substring-search" "https://github.com/zsh-users/zsh-history-substring-search.git"

# Plugin configurations
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Load aliases
source "$HOME/.config/zsh/aliases.zsh"

# Load local configuration if it exists
[[ -f "$HOME/.config/zsh/local.zsh" ]] && source "$HOME/.config/zsh/local.zsh"

# Environment setup
. "$HOME/.local/bin/env"

# NVM setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Configuration for eza
export EZA_ICONS=true
export EZA_ICON_THEME="nerd-font"

# Shell integrations
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"