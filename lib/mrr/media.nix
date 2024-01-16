{ pkgs, ... }: {
  home.packages =
    [ pkgs.simplescreenrecorder pkgs.vlc pkgs.inkscape-with-extensions ];
  programs.obs-studio.enable = true;
  programs.feh.enable = true;
}
