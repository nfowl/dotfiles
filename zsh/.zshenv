# Export Language Settings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

##### EXPORTS
export EDITOR="vim"
export FLUX_FORWARD_NAMESPACE="flux"
export WASMTIME_HOME="$HOME/.wasmtime"

### PATH
export PATH=$PATH:/usr/local/go/bin
export PATH="$HOME/.cargo/bin:$PATH"
if command -v go >/dev/null 2>&1; then
  export PATH="$PATH:$(go env GOPATH)/bin"
fi
export PATH="$WASMTIME_HOME/bin:$PATH"
