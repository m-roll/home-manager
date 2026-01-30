{ pkgs, config, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "git-extras"
        "man"
        "sudo"
      ]; # TODO: only include git here if enabled
    };
    # TODO Only include if TMUX active
    profileExtra = ''
      export ZSH_TMUX_AUTOSTART=true
    '';
    initContent = ''
      [ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}
    '';
    history = { };
  };
}
