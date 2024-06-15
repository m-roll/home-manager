{ pkgs, ... }:
{
  home.packages = [
    pkgs.ghc
    pkgs.guile
    pkgs.nickel
  ];
}
