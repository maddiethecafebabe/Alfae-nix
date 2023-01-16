nix flake lock --update-input alfae
fetchDepsScript=$(nix build .#default.passthru.fetch-deps --print-out-paths --no-link)
$fetchDepsScript ./deps.nix
