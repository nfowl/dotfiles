# Export Language Settings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

##### EXPORTS
export EDITOR="vim"
export ZSH_CACHE_DIR="$HOME/.zsh/cache"
export FPATH="$FPATH:/$ZSH_CACHE_DIR/completions"

export BAT_THEME="Dracula"

### PATH exports
export PATH="$HOME/.local/bin:$PATH"
#export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"

### Optional PATH additions based on availability
if command -v go >/dev/null 2>&1; then
  export PATH=$PATH:/usr/local/go/bin
  export PATH="$PATH:$(go env GOPATH)/bin"
fi

export PATH="$HOME/.cargo/bin:$PATH"
if command -v cargo >/dev/null 2>&1; then
 # export WASMTIME_HOME="$HOME/.wasmtime"
 # export PATH="$WASMTIME_HOME/bin:$PATH"
fi

if [ -f /opt/gradle/latest/bin/gradle ]; then
  export GRADLE_HOME=/opt/gradle/latest
  export PATH=${GRADLE_HOME}/bin:${PATH}
fi


if [ -f $HOME/.zshenv_private ]; then
 source $HOME/.zshenv_private
fi
# . "$HOME/.cargo/env"

if [ -e /home/nathan/.nix-profile/etc/profile.d/nix.sh ]; then . /home/nathan/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer