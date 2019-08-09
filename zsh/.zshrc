# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/nfowler/.zshrc'

autoload -Uz compinit
compinit
kitty + complete setup zsh | source /dev/stdin
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

### Aliases
alias ls="ls --color=always"
alias ll="ls -l"
alias lt="ls -ltr"
alias lla="ll -a"
