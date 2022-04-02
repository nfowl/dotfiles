# Export Language Settings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

##### EXPORTS
export EDITOR="vim"
<<<<<<< Updated upstream

### lvim
export PATH="$PATH:/Users/nfowler/.local/bin"

### Optional PATH additions based on availability
=======
export FLUX_FORWARD_NAMESPACE="flux"
export WASMTIME_HOME="$HOME/.wasmtime"
export DENO_INSTALL="/home/nathan/.deno"
### PATH
export PATH=$PATH:/usr/local/go/bin
export PATH="$HOME/.cargo/bin:$PATH"
>>>>>>> Stashed changes
if command -v go >/dev/null 2>&1; then
  export PATH=$PATH:/usr/local/go/bin
  export PATH="$PATH:$(go env GOPATH)/bin"
fi
<<<<<<< Updated upstream

if command -v cargo >/dev/null 2>&1; then
  export PATH="$HOME/.cargo/bin:$PATH"
  export WASMTIME_HOME="$HOME/.wasmtime"
  export PATH="$WASMTIME_HOME/bin:$PATH"
fi

if [ -f $HOME/.zshenv_private ]; then
 source $HOME/.zshenv_private
fi
. "$HOME/.cargo/env"
=======
export PATH="$WASMTIME_HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
>>>>>>> Stashed changes
