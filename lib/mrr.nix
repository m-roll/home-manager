{ ... }: {
  imports = [
    ./mrr/gaming.nix
    ./mrr/fonts.nix
    ./mrr/tmux.nix
    ./mrr/media.nix
    ./mrr/display.nix
    ./mrr/browsers.nix
    ./mrr/development.nix
    ./mrr/kitty.nix
  ];

  options = { mrr = { }; };

  config = { mrr = { }; };
}
