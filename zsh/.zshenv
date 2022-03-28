# Export Language Settings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

##### EXPORTS
export EDITOR="vim"

### lvim
export PATH="$PATH:/Users/nfowler/.local/bin"

### Optional PATH additions based on availability
if command -v go >/dev/null 2>&1; then
  export PATH=$PATH:/usr/local/go/bin
  export PATH="$PATH:$(go env GOPATH)/bin"
fi

if command -v cargo >/dev/null 2>&1; then
  export PATH="$HOME/.cargo/bin:$PATH"
  export WASMTIME_HOME="$HOME/.wasmtime"
  export PATH="$WASMTIME_HOME/bin:$PATH"
fi

if [ -f $HOME/.zshenv_private ]; then
 source $HOME/.zshenv_private
fi
. "$HOME/.cargo/env"
