if [[ -f ~/.zshrc ]]; then
  . ~/.zshrc
fi
if [[ -f ~/.zshenv ]]; then
  . ~/.zshenv
fi

eval "$(mise activate zsh --shims)"
