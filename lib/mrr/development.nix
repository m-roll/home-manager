{ pkgs, ... }: {
  home.packages = [ pkgs.git ];

  config = {
    programs.mrr-neovim = {
      enable = true;
      include_lsps = true;
    };
    programs.git = {
      enable = true;
      userEmail = "matt@rollender.com";
      userName = "Matt Rollender";
    };
    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "less";
    };
  };
}
