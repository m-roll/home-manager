{ pkgs, config, ... }:
{

  imports = [ ./modules/mrr.nix ];

  home.username = "mrr";
  home.homeDirectory = "/home/mrr";
  mrr.wallpaper_out = "wallpapers/wallpaper.jpg";
  mrr.wallpaper_in = static/wallpapers/a2121346445_10.jpg;

  mrr.kitty.theme-name = "ayu_mirage";
  mrr.kitty.font-name = "FiraCode Nerd Font";

  # Don't change this
  home.stateVersion = "23.05";

  # Don't keep stuff here -- use modules to sort these when there's time to do so.
  home.packages = [
    pkgs.htop
    pkgs.openssl
    pkgs.xclip
    pkgs.gdb
    pkgs.unzip
    pkgs.oscar
    pkgs.CuboCore.coreshot
    pkgs.remind

    # CD burning stuff
    pkgs.cdrtools
    pkgs.ffmpeg_7-headless
    pkgs.vlc

    #misc
    pkgs.file
    pkgs.coreutils
    pkgs.bluez
    pkgs.ungoogled-chromium
    pkgs.python312Packages.west
    pkgs.leiningen
    pkgs.prismlauncher
    pkgs.dig
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.file.${config.mrr.wallpaper_out}.source = config.mrr.wallpaper_in;
}
