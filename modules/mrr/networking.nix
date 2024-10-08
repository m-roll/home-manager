{ pkgs, ... }:
{
  home.packages = [
    pkgs.wireguard-go
    pkgs.wireguard-tools
    pkgs.protonvpn-cli
    pkgs.transmission_4
    pkgs.openssl
  ];
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks."github.com".forwardAgent = true;
  };
}
