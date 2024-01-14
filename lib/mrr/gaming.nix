{ config, pkgs, lib, ... }:
let cfg = config.mrr.gaming;
in {
  options.mrr.gaming = {
    enable = lib.mkEnableOption "Gaming related stuff";
    includeDiscord = lib.mkOption { default = true; };

  };
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.gtkcord4 pkgs.steam pkgs.r2modman ];
  };
}
