# ~/.config/zsh/aliases.zsh - Shell aliases

# System aliases
alias la='ls -A'
alias grep='grep --color=auto'
alias fgrep='grep -F --color=auto'
alias egrep='grep -E --color=auto'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

# Utilities
alias h='history'
alias path='echo -e ${PATH//:/\\n}'
alias reload='source ~/.zshrc'