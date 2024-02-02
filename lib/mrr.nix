{ lib, ... }: {
  imports = [
    ./mrr/gaming.nix
    ./mrr/fonts.nix
    ./mrr/tmux.nix
    ./mrr/media.nix
    ./mrr/display.nix
    ./mrr/browsers.nix
    ./mrr/development.nix
    ./mrr/kitty.nix
    ./mrr/starship.nix
    ./mrr/security.nix
  ];

  options = {
    mrr = {
      wallpaper_out = lib.mkOption { type = lib.types.str; };
      wallpaper_in = lib.mkOption { type = lib.types.path; };
    };
  };

  config = { mrr = { }; };
}
