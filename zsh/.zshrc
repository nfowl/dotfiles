# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit

if command -v kitty >/dev/null 2>&1; then
  kitty + complete setup zsh | source /dev/stdin
fi
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

#External Autocompletes
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

alias ls="ls --color=always"
alias ll="ls -l"
alias lt="ls -ltr"
alias lla="ll -a"

### Pacman Aliases
alias pacup="pacman -Syu"
alias pacin="pacman -S"

source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

###Python Virtual Enviroment stuff
if [ ! -z "$WSLENV" ]; then
# Handle ubuntu WSL location
  if [ -f $HOME/.local/bin/virtualenvwrapper.sh ]; then 
    export WORKON_HOME=~/.venvs
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
    export VIRTUALENVWRAPPER_VIRTUALENV=$HOME/.local/bin/virtualenv
    source $HOME/.local/bin/virtualenvwrapper.sh
  fi
elif [ -f /usr/bin/virtualenvwrapper.sh ]; then
# Else handle arch
  export WORKON_HOME=~/.venvs
  source /usr/bin/virtualenvwrapper.sh
fi

###Functions

export WASMTIME_HOME="$HOME/.wasmtime"

export PATH="$WASMTIME_HOME/bin:$PATH"

function set_win_title(){
	echo -ne "\033]0; $(hostname):/$(basename $PWD) \007"
    }

precmd_functions+=(set_win_title)
eval "$(starship init zsh)"
