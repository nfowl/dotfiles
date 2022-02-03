# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit

if [ -e /Users/nfowler/.nix-profile/etc/profile.d/nix.sh ]; then 
  . /Users/nfowler/.nix-profile/etc/profile.d/nix.sh; 
fi # added by Nix installer

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep
bindkey -v

# End of lines configured by zsh-newuser-install
if [ -f ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE} ]; then
  source ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
  [[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
  [[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char
  [[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
  [[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
  [[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
  [[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
  [[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}"  delete-char
  [[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-history
  [[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-history
  [[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" beginning-of-buffer-or-history
  [[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" end-of-buffer-or-history
fi

#External Autocompletes
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

# This failed to work on WSL
# if command -v flux >/dev/null 2>&1; then
#   source <(flux completion zsh)
# fi

# Aliases
alias ls="ls -G"
alias ll="ls -l"
alias lt="ls -ltr"
alias lla="ll -a"

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


## Prompt stuff
function set_win_title(){
	echo -ne "\033]0; $(hostname):/$(basename $PWD) \007"
    }

precmd_functions+=(set_win_title)
eval "$(starship init zsh)"
