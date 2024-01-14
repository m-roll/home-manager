{ config, pkgs, lib, ... }: {

  config = { home.packages = [ pkgs.gtkcord4 pkgs.steam pkgs.r2modman ]; };
}
