#
# ~/.zprofile
#

if [[ -f ~/.zshrc ]]; then
  . ~/.zshrc
fi

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

export PATH="$HOME/.cargo/bin:$PATH"
