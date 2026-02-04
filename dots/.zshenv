# Environment variables

# Only source this once
if [[ -z "$__HM_ZSH_SESS_VARS_SOURCED" ]]; then
  export __HM_ZSH_SESS_VARS_SOURCED=1
fi

# ZSH="/nix/store/a60xh4vk07bif4fknqlkjqpix1ccg0i4-oh-my-zsh-2024-10-01/share/oh-my-zsh";
ZSH_CACHE_DIR="/home/nfowler/.cache/oh-my-zsh";

# Export Language Settings
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export COLORTERM=truecolor
# export ZELLIJ_AUTO_ATTACH=true
export PATH=$HOME/.local/bin:$PATH
export NODE_OPTIONS="--max-old-space-size=16192"

##### EXPORTS
export ZSH_CACHE_DIR="$HOME/.zsh/cache"
export FPATH="$FPATH:/$ZSH_CACHE_DIR/completions"
export FZF_DEFAULT_COMMAND='fd --type file --hidden'

### Optional PATH additions based on availability
# if command -v go >/dev/null 2>&1; then
#   export PATH=$PATH:/usr/local/go/bin
#   export PATH="$PATH:$(go env GOPATH)/bin"
# fi

# if [ -f $HOME/.cargo/env ]; then
#   . $HOME/.cargo/env
# fi

if [ -f $HOME/.zshenv_extras ]; then
 source $HOME/.zshenv_extras
fi

. "$HOME/.cargo/env"
