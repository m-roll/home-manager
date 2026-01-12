{ pkgs, ... }:
{
  config = {
    home.packages = [
      pkgs.git
      pkgs.cabal-install
    ];
    programs.git = {
      enable = true;
      settings.user.email = "matt@rollender.com";
      settings.user.name = "Matt Rollender";
    };
    home.sessionVariables = {
      EDITOR = "nvim";
      GIT_EDITOR = "nvim";
      VISUAL = "less";
    };
  };
}
