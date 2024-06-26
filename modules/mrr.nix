{ lib, ... }:
{
  imports = [
    ./mrr/gaming.nix
    ./mrr/newsboat.nix
    ./mrr/fonts.nix
    ./mrr/media.nix
    ./mrr/display.nix
    ./mrr/browsers.nix
    ./mrr/development.nix
    ./mrr/security.nix
    ./mrr/langs.nix
    ./mrr/networking.nix
    ./mrr/terminal.nix
    ./mrr/autorandr.nix
  ];

  options = {
    mrr = {
      wallpaper_out = lib.mkOption { type = lib.types.str; };
      wallpaper_in = lib.mkOption { type = lib.types.path; };
    };
  };

  config = {
    mrr = { };
  };
}
