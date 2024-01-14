{ config, pkgs, lib, ... }:
let cfg = config.mrr.media;
in {
  options.mrr.media = {
    enable = lib.mkEnableOption
      "Media including video recording playback, image manipulation";
    includeDiscord = lib.mkOption { default = true; };

  };
  config = lib.mkIf cfg.enable {
    home.packages =
      [ pkgs.simplescreenrecorder pkgs.vlc pkgs.inkscape-with-extensions ];
    programs.obs-studio.enable = true;
  };
}
