{ pkgs, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true; # TODO only if zsh enabled
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
}
