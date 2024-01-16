{ pkgs, lib, ... }:

let
  wallpaper_out = "wallpapers/wallpaper.jpg";
  wallpaper_in = wallpapers/pexels-liam-moore-11372619.jpg;
in {

  imports = [ ./lib/mrr.nix ];

  home.username = "mrr";
  home.homeDirectory = "/home/mrr";

  mrr.kitty.theme-name = "ayu_mirage";
  mrr.kitty.font-name = "FiraCode Nerd Font";

  # This is a hack: unstable NixOS and 23.05 home-manager are conflicting here
  manual.manpages.enable = false;

  # Don't change this
  home.stateVersion = "23.05";

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "steam" "steam-original" "discord" ];

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks."github.com".forwardAgent = true;
  };
  programs.keychain = {
    enable = true;
    enableZshIntegration = true;
    keys = [ "id_rsa" ];
  };
  services.dunst = {
    enable = true;
    settings = {
      spotify = {
        appname = "Spotify";
        urgency = "normal";
        script =
          "~/.scripts/spotify_log.sh"; # https://wittchen.io/posts/spotify-song-in-i3-status-bar/
      };
    };
  };
  programs.feh = { enable = true; };
  home.packages = [
    pkgs.htop
    pkgs.zsh
    pkgs.openssl
    pkgs.xclip
    pkgs.gpx-viewer
    pkgs.transmission
    pkgs.slack-term
  ] ++ import ./pkgs/langs.nix { inherit pkgs; };

  home.sessionVariables = { BROWSER = "brave"; };

  programs.starship = import ./starship.nix;
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "git-extras" "man" "sudo" ];
    };
    profileExtra = ''
      export ZSH_TMUX_AUTOSTART=true
    '';
    initExtra = ''
      feh --bg-fill ~/${wallpaper_out}
      [ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}
    '';
    history = { };
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.file.${wallpaper_out}.source = wallpaper_in;
}
