{ ... }: {
  imports = [
    ./mrr/gaming.nix
    ./mrr/fonts.nix
    ./mrr/tmux.nix
    ./mrr/media.nix
    ./mrr/dispay.nix
    ./mrr/browsers.nix
    ./mrr/development.nix
  ];

  config = { mrr = { }; };
}
