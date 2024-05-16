{ pkgs, ... }:
{
  home.packages = [
    pkgs.simplescreenrecorder
    pkgs.inkscape-with-extensions
  ];
  programs.mpv = {
    enable = true;
    config = {
      sub-auto = "fuzzy";
    };
  };
  programs.obs-studio.enable = true;
  programs.feh.enable = true;
}
