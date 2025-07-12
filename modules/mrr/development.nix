{ pkgs, ... }:
{
  config = {
    home.packages = [
      pkgs.git
      pkgs.cabal-install
    ];
    programs.git = {
      enable = true;
      userEmail = "matt@rollender.com";
      userName = "Matt Rollender";
    };
    home.sessionVariables = {
      EDITOR = "nvim";
      GIT_EDITOR = "nvim";
      VISUAL = "less";
    };
  };
}
