{ pkgs, ... }: {
  home.packages =
    [ (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; }) ];

  fonts.fontconfig.enable = true;
}
