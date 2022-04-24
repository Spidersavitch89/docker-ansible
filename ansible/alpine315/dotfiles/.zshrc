export LANG='en_US.UTF-8'
export LANGUAGE='en_US:en'
export LC_ALL='en_US.UTF-8'
export TERM=xterm

##### Zsh/Oh-my-Zsh Configuration
export ZSH="/root/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(ansible alias-finder colored-man-pages colorize git history-substring-search nmap tmux zsh-interactive-cd zsh-autosuggestions zsh-navigation-tools zsh-syntax-highlighting )


bindkey "\$terminfo[kcuu1]" history-substring-search-up
bindkey "\$terminfo[kcud1]" history-substring-search-down
source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
source $HOME/.functions
ssh() { /usr/bin/ssh "$@" | ct; }
telnet() { /etc/alternatives/telnet "$@" | ct; }

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
