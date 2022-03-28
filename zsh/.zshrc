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
elif [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
# Else handle mac
  export WORKON_HOME=~/.venvs
  source /usr/local/bin/virtualenvwrapper.sh
fi

if command -v go >/dev/null 2>&1; then
  export PATH=$PATH:/usr/local/go/bin
  export PATH="$PATH:$(go env GOPATH)/bin"
fi

if command -v cargo >/dev/null 2>&1; then
  export PATH="$HOME/.cargo/bin:$PATH"
  export WASMTIME_HOME="$HOME/.wasmtime"
  export PATH="$WASMTIME_HOME/bin:$PATH"
fi

###Functions

if [ -f $HOME/.zshrc_private ]; then
 source $HOME/.zshrc_private
fi

# fbr - checkout git branch
# fbr() {
#   local branches branch
#   branches=$(git --no-pager branch -vv) &&
#   branch=$(echo "$branches" | fzf +m) &&
#   git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
# }

# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# # fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
# fbr() {
#   local branches branch
#   branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
#   branch=$(echo "$branches" |
#            fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
#   git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
# }

# fco - checkout git branch/tag
fco() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
        --ansi) || return
  git checkout $(awk '{print $2}' <<<"$target" )
}


# fco_preview - checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
fco_preview() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
        --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return
  git checkout $(awk '{print $2}' <<<"$target" )
}

export FZF_DEFAULT_COMMAND='fd --type file --hidden'

## Prompt stuff
# function set_win_title(){
# 	echo -ne "\033]0; $(hostname):/$(basename $PWD) \007"
#     }

# precmd_functions+=(set_win_title)
# eval "$(starship init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
