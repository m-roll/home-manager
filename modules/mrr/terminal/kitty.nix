{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mrr.kitty;
in
{
  options.mrr.kitty = {
    themes-package = lib.mkOption { type = lib.types.package; };
    theme-name = lib.mkOption { type = lib.types.str; };
    font-name = lib.mkOption { type = lib.types.str; };
  };
  config = {
    programs.kitty = {
      enable = true;
      font = {
        package = pkgs.nerd-fonts.sauce-code-pro;
        name = "SauceCodePro Nerd Font";
        size = 10;
      };
      extraConfig = ''
        include ${cfg.themes-package}/themes/${cfg.theme-name}.conf
        background_opacity 0.8
      '';
    };
    home.sessionVariables.TERMINAL = "kitty";
  };
}
