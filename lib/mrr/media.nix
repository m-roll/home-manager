{ config, pkgs, lib, ... }: {
  config = {
    home.packages =
      [ pkgs.simplescreenrecorder pkgs.vlc pkgs.inkscape-with-extensions ];
    programs.obs-studio.enable = true;
  };
}
