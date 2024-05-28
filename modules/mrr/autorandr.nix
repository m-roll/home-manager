{ config, pkgs, ... }:
{
  config = {
    programs.autorandr = {
      enable = true;
      profiles = {
        "dual" = {
          fingerprint = {
            "DP-2" = "00ffffffffffff0010ac43424c594c410c1f0104a53c22783ac525aa534f9d25105054a54b00714f8180a9c0d1c081c081cf01010101023a801871382d40582c450056502100001e000000ff00375437385238330a2020202020000000fc0044454c4c20503237323248450a000000fd00384c1e5311010a202020202020000b";
            "HDMI-0" = "00ffffffffffff0010ac44424c424c410c1f0103803c2278eac525aa534f9d25105054a54b00714f8180a9c0d1c081c081cf01010101023a801871382d40582c450056502100001e000000ff00325337385238330a2020202020000000fc0044454c4c20503237323248450a000000fd00384c1e5311000a202020202020019d020315b14a900504030201141f121365030c001000023a801871382d40582c450056502100001e011d8018711c1620582c250056502100009e011d007251d01e206e28550056502100001e8c0ad08a20e02d10103e960056502100001800000000000000000000000000000000000000000000000000000000000000000000a2";
          };
          config = {
            "HDMI-0" = {
              enable = true;
              primary = true;
              position = "0x0";
              mode = "1920x1080";
            };

            "DP-2" = {
              enable = true;
              primary = false;
              position = "1920x0";
              mode = "1920x1080";
              rotate = "left";
            };
          };
          hooks.postswitch = ''
            feh --bg-fill ~/${config.mrr.wallpaper_out}
          '';
        };
      };
    };
  };
}
