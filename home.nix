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
    fadeDelta = 10;
    fadeSteps = [
      0.25
      0.28
    ];
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
      blur-background-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
      ];
    };
  };

# This is a hack: unstable NixOS and 23.05 home-manager are conflicting here
  manual.manpages.enable = false;

# Don't change this
  home.stateVersion = "23.05";

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "discord"
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
    pkgs.firefox-unwrapped
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

    pkgs.inkscape-with-extensions
    pkgs.gpx-viewer

    pkgs.transmission
    
    pkgs.slack-term

    pkgs.discord
    pkgs.gtkcord4


      (import ./nerdfonts.nix { inherit pkgs; })
  ]
  ++ import ./pkgs/langs.nix { inherit pkgs; };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "less";
    BROWSER = "brave";
    TERMINAL = "kitty";
  };

  programs.obs-studio.enable = true;

  programs.mrr-neovim= {
    enable = true;
    include_lsps = true;
  };
  # TODO: tmux is manager by the zsh plugin, not
  # home-manager directly. This means escapeTime, and 
  # other settings, won't be honored.
  # Perhaps this can be fixed with an override.
  programs.tmux = {
    enable = true;
    escapeTime = 10;
    baseIndex = 1;
    plugins = [
      pkgs.tmuxPlugins.sensible
      pkgs.tmuxPlugins.vim-tmux-navigator
      pkgs.tmuxPlugins.catppuccin
    ];
    extraConfig = ''
      set -g @catppuccin_window_left_separator "█"
      set -g @catppuccin_window_right_separator "█ "
      set -g @catppuccin_window_number_position "right"
      set -g @catppuccin_window_middle_separator "  █"

      set -g @catppuccin_window_default_fill "number"

      set -g @catppuccin_window_current_fill "number"
      set -g @catppuccin_window_current_text "#{pane_current_path}"

      set -g @catppuccin_status_modules_right "application session date_time"
      set -g @catppuccin_status_left_separator  ""
      set -g @catppuccin_status_right_separator " "
      set -g @catppuccin_status_right_separator_inverse "yes"
      set -g @catppuccin_status_fill "all"
      set -g @catppuccin_status_connect_separator "no"
      '';
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

  xresources.properties = {
    "xft.dpi" = 96;
    "xft.antialias" = true;
    "xft.hinting" = true;
    "xft.autohint" = false;
    "xft.hintstyle" = "hintslight";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.file.${wallpaper_out}.source = wallpaper_in;
  home.file.".config/i3/config".text = (import ./static/i3/config.nix { dmenu_opts = "-fn \"FiraCode Nerd Font\" -nf \"#f0d48b\" -sb \"#f0d48b\" -sf \"#1b1e26\""; });
  home.file.".dmenurc".source = ./static/.dmenurc;
  home.file.".config/i3status/config".source = ./static/i3status/config;
}
