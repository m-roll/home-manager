{ pkgs, ... }:
{
  home.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.droid-sans-mono
  ];

  fonts.fontconfig.enable = true;
}
