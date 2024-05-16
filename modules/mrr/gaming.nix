{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ ./licensing.nix ];

  config = {
    home.packages = [
      pkgs.gtkcord4
      pkgs.steam
      pkgs.r2modman
    ];

    mrr.licensing.allowed_unfree_pkg_names = [
      "steam"
      "steam-original"
      "discord"
    ]; # using gtkcord should allow me to remove discord from this
  };
}
