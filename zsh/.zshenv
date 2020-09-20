# Export Language Settings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

##### EXPORTS
export EDITOR="vim"
export FLUX_FORWARD_NAMESPACE="flux"
export WASMTIME_HOME="$HOME/.wasmtime"

### PATH
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$WASMTIME_HOME/bin:$PATH"