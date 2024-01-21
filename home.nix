{ pkgs, lib, config, ... }: {

  imports = [ ./lib/mrr.nix ];

  home.username = "mrr";
  home.homeDirectory = "/home/mrr";
  mrr.wallpaper_out = "wallpapers/wallpaper.jpg";
  mrr.wallpaper_in = wallpapers/pexels-liam-moore-11372619.jpg;

  mrr.kitty.theme-name = "ayu_mirage";
  mrr.kitty.font-name = "FiraCode Nerd Font";

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
  home.packages = [
    pkgs.htop
    pkgs.zsh
    pkgs.openssl
    pkgs.xclip
    pkgs.gpx-viewer
    pkgs.transmission
    pkgs.slack-term
    pkgs.protonvpn-cli
  ] ++ import ./pkgs/langs.nix { inherit pkgs; };
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
      feh --bg-fill ~/${config.mrr.wallpaper_out}
      [ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}
    '';
    history = { };
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.file.${config.mrr.wallpaper_out}.source = config.mrr.wallpaper_in;
}
