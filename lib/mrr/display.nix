{ config, pkgs, lib, ... }: {
  config = {
    xresources.properties = {
      "xft.dpi" = 96;
      "xft.antialias" = true;
      "xft.hinting" = true;
      "xft.autohint" = false;
      "xft.hintstyle" = "hintslight";
    };
    home.file.".config/i3/config".text = (import ../../static/i3/config.nix {
      dmenu_opts =
        ''-fn "FiraCode Nerd Font" -nf "#f0d48b" -sb "#f0d48b" -sf "#1b1e26"'';
    });
    home.file.".dmenurc".source = ../../static/.dmenurc;
    home.file.".config/i3status/config".source = ../../static/i3status/config;
    home.packages = [ pkgs.libva-utils ];
    services.picom = {
      enable = true;
      fade = true;
      fadeDelta = 10;
      fadeSteps = [ 0.25 0.28 ];
      opacityRules = [
        "95:class_g = 'URxvt' && focused"
        "60:class_g = 'URxvt' && !focused"
      ];
      settings = {
        blur = {
          method = "dual_kawase";
          strength = 3;
        };
        blur-background-fixed = true;
        blur-background-exclude =
          [ "window_type = 'dock'" "window_type = 'desktop'" ];
      };
    };
  };
}
