set -g fish_key_bindings fish_vi_key_bindings

# ensure mise can be detected (on home pc)
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin

mise activate fish | source

if status is-interactive
    set -g fish_greeting
    starship init fish | source
    zoxide init fish | source
end
