{ pkgs, ... }:
{
  home.packages = [
    pkgs.wireguard-go
    pkgs.wireguard-tools
    pkgs.proton-vpn-cli
    pkgs.transmission_4
    pkgs.openssl
  ];
  programs.ssh = {
    enable = true;
    matchBlocks."github.com".forwardAgent = true;
    enableDefaultConfig = false;
  };
}
