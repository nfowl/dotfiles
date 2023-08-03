nix develop --command niv "update"
nix develop --command niv update nixpkgs-unstable -r $(nix flake metadata nixpkgs --json | jq -r '.revision')
nix develop --command niv update nixpkgs -r $(nix flake metadata nixpkgs --json | jq -r '.revision')
nix develop --command niv update home-manager -r $(nix flake metadata home-manager --json | jq -r '.revision')
