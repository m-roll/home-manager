{ config, pkgs, lib, ... }:

let
  myNvimConfigPlugin = pkgs.vimUtils.buildVimPlugin {
    name = "mrr-config";
    src = ./neovim;
  };
  kitty-theme-name = "ayu_mirage";
  kitty-themes = pkgs.fetchFromGitHub {
    owner = "dexpota";
    repo = "kitty-themes";
    rev = "1.0.0";
    sha256 =  "sha256-ySpv84kZSfJQl5/rIECfYhZfcb4j2RPH3JaNpaELF8c=";
  };
  rose-pine = pkgs.vimUtils.buildVimPlugin {
    name = "rose-pine";
    src = pkgs.fetchFromGitHub {
      owner = "rose-pine";
      repo = "neovim";
      rev = "v1.2.0";
      sha256 = "sha256-j5eUYEwFjWoIkncsh2mtpnKC72CD9VUa0bEohxBymsc=";
    };
  };
  nerd-fonts = ( pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; });

in {
  home.username = "mrr";
  home.homeDirectory = "/home/mrr";

  # This is a hack: unstable NixOS and 23.05 home-manager are conflicting here
  manual.manpages.enable = false;

  # Don't change this
  home.stateVersion = "23.05";
  
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
    ];

  home.packages = [
    pkgs.brave
    pkgs.htop
    pkgs.zsh
    pkgs.git
    nerd-fonts

    # LSPs
    pkgs.luajitPackages.lua-lsp
    pkgs.haskellPackages.haskell-language-server

    pkgs.openssl
    pkgs.xclip
    pkgs.nodePackages.prettier
    pkgs.nixfmt
    pkgs.luaformatter

    # video recording + playback
    pkgs.simplescreenrecorder
    pkgs.vlc

    # langs
    pkgs.ghc
    pkgs.guile

    # gaming
    pkgs.steam
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "less";
    BROWSER = "brave";
    TERMINAL = "kitty";
  };

  programs.obs-studio.enable = true;

  programs.neovim = {
    enable = true;
    # TODO: Can I get away with not requiring here?
    extraLuaConfig = ''
      require("mrr")
    '';
    # todo use inherits expr here.
    plugins = [
      myNvimConfigPlugin
      pkgs.vimPlugins.telescope-nvim
      # pkgs.vimPlugins.ale -- ALE with the other stuff here doesn't make sense.
      pkgs.vimPlugins.nvim-lspconfig
      pkgs.vimPlugins.nvim-cmp
      rose-pine
      pkgs.vimPlugins.vim-prettier
      pkgs.vimPlugins.trouble-nvim
      pkgs.vimPlugins.nvim-web-devicons
      (pkgs.vimPlugins.nvim-treesitter.withPlugins
        (plugins: pkgs.tree-sitter.allGrammars))
    ];

  };
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
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = 10;
    };
    extraConfig = ''
      include ${kitty-themes}/themes/${kitty-theme-name}.conf
      background_opacity 0.8
    '';
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      nix_shell = {
        disabled = false;
        impure_msg = "";
        symbol = "";
        format = "[$symbol$state]($style) ";
      };
      shlvl = {
        disabled = false;
        symbol = "λ ";
      };
      haskell.symbol = " ";
    };
  };
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "git-extras" "man" "sudo" "tmux" ];
    };
    history = { };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
