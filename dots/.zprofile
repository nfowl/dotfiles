if [[ -f ~/.zshrc ]]; then
  . ~/.zshrc
fi
if [[ -f ~/.zshenv ]]; then
  . ~/.zshenv
fi

if [ -f $HOME/.zshrc_extras ]; then
 source $HOME/.zprofile_extras
fi

eval "$(mise activate zsh --shims)"
