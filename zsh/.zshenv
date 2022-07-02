# Export Language Settings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

##### EXPORTS
export EDITOR="vim"
export ZSH_CACHE_DIR="$HOME/.zsh/cache"
export FPATH="$FPATH:/$ZSH_CACHE_DIR/completions"

export BAT_THEME="Dracula"

export DENO_INSTALL="/home/nathan/.deno"
### PATH exports
export PATH="$HOME/.local/bin:$PATH"
#export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"

### PATH exports
export PATH="$HOME/.local/bin:$PATH"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"

### Optional PATH additions based on availability
if command -v go >/dev/null 2>&1; then
  export PATH=$PATH:/usr/local/go/bin
  export PATH="$PATH:$(go env GOPATH)/bin"
fi

if command -v cargo >/dev/null 2>&1; then
  export PATH="$HOME/.cargo/bin:$PATH"
 # export WASMTIME_HOME="$HOME/.wasmtime"
 # export PATH="$WASMTIME_HOME/bin:$PATH"
fi

if [ -f $HOME/.zshenv_private ]; then
 source $HOME/.zshenv_private
fi
# . "$HOME/.cargo/env"

