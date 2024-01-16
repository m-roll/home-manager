{ pkgs, ... }: {
  home.packages = [ pkgs.brave pkgs.firefox-unwrapped ];
  home.sessionVariables.BROWSER = "brave";
}
