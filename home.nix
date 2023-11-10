{ config, pkgs, lib, specialArgs, ... }:

let
  # Themes for kitty soured from https://github.com/dexpota/kitty-themes/tree/master/themes
  kitty-theme-name = "ayu_mirage";
  font-name = "FiraCode Nerd Font";
  wallpaper_out = "wallpapers/wallpaper.jpg";
  wallpaper_in = wallpapers/pexels-liam-moore-11372619.jpg;
  inherit (specialArgs) my-nvim-config;
in {
  home.username = "mrr";
  home.homeDirectory = "/home/mrr";

  services.picom = {
    enable = true;
    fade = true;
    opacityRules = [
      "90:class_g = 'URxvt' && focused"
        "60:class_g = 'URxvt' && !focused"
    ];
  };

# This is a hack: unstable NixOS and 23.05 home-manager are conflicting here
  manual.manpages.enable = false;

# Don't change this
  home.stateVersion = "23.05";

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
    "steam"
      "steam-original"
      ];
  services.dunst = {
    enable = true;
    settings = {
      spotify = {
        appname = "Spotify";
        urgency = "normal";
        script = "~/.scripts/spotify_log.sh";  # https://wittchen.io/posts/spotify-song-in-i3-status-bar/
      };
    };
  };
  programs.feh = {
    enable = true;
  };
  home.packages = [
    pkgs.brave
      pkgs.htop
      pkgs.zsh
      pkgs.git

      pkgs.openssl
      pkgs.xclip

# video recording + playback
      pkgs.simplescreenrecorder
      pkgs.vlc

# gaming
      pkgs.steam

      (import ./nerdfonts.nix { inherit pkgs; })
  ] ++ import ./pkgs/lsp.nix { inherit pkgs; }
  ++ import ./pkgs/langs.nix { inherit pkgs; };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "less";
    BROWSER = "brave";
    TERMINAL = "kitty";
  };

  programs.obs-studio.enable = true;

  programs.neovim = {
    enable = true;
  } // my-nvim-config;
  # TODO: tmux is manager by the zsh plugin, not
  # home-manager directly. This means escapeTime, and 
  # other settings, won't be honored.
  # Perhaps this can be fixed with an override.
  programs.tmux = {
    enable = true;
    escapeTime = 10;
  };
  programs.git = {
    enable = true;
    userEmail = "matt@rollender.com";
    userName = "Matt Rollender";
  };
  fonts.fontconfig.enable = true;
  programs.kitty = import ./kitty.nix { inherit pkgs; inherit kitty-theme-name; inherit font-name; };  
  programs.starship = import ./starship.nix;
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "git-extras" "man" "sudo" "tmux" ];
    };
    initExtra = ''
      feh --bg-fill ~/${wallpaper_out}
    '';
    history = { };
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.file.${wallpaper_out}.source = wallpaper_in;
  home.file.".config/i3/config".source = ./i3/config;
  home.file.".config/i3status/config".source = ./i3status/config;
}
