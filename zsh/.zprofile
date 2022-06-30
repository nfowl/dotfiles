#
# ~/.zprofile
#

if [[ -f ~/.zshrc ]]; then
  . ~/.zshrc
fi

if [[ -f ~/.zshenv ]]; then
  . ~/.zshenv
fi

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
