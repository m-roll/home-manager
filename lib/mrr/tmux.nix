{ config, pkgs, lib, ... }:
let cfg = config.mrr.tmux;
in {
  options.mrr.tmux = {
    enable = lib.mkEnableOption "Tmux plugins and theming";
  };

  config = lib.mkIf cfg.enable {
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
  };
}
