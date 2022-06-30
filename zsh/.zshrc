# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit

#Init zoxide
eval "$(zoxide init zsh)"

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
alias ls="exa --color auto"
alias ll="ls -l"
alias lt="ls -ltr"
alias lla="ll -a"

if command -v bat >/dev/null 2>&1; then
  alias cat="bat"
fi

source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

###Python Virtual Enviroment stuff
if [ -f $HOME/.local/bin/virtualenvwrapper.sh ]; then
  # Handle ubuntu WSL location
  export WORKON_HOME=~/.venvs
  export VIRTUALENVWRAPPER_PYTHON="/bin/python3"
  source $HOME/.local/bin/virtualenvwrapper.sh
elif [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  # Else handle mac
  export WORKON_HOME=~/.venvs
  source /usr/local/bin/virtualenvwrapper.sh
fi

###Functions

if [ -f $HOME/.zshrc_private ]; then
 source $HOME/.zshrc_private
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export FZF_DEFAULT_COMMAND='fd --type file --hidden'

# Prompt stuff
# function set_win_title(){
# 	echo -ne "\033]0; $(hostname):/$(basename $PWD) \007"
#     }

# precmd_functions+=(set_win_title)
# eval "$(starship init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

