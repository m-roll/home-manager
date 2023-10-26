{ pkgs, kitty-theme-name, font-name }: 
let kitty-themes = pkgs.fetchFromGitHub {
    owner = "dexpota";
    repo = "kitty-themes";
    rev = "1.0.0";
    sha256 =  "sha256-ySpv84kZSfJQl5/rIECfYhZfcb4j2RPH3JaNpaELF8c=";
  };
in
{
  enable = true;
  font = {
    name = font-name;
    size = 10;
  };
  extraConfig = ''
    include ${kitty-themes}/themes/${kitty-theme-name}.conf
    background_opacity 0.8
  '';
}
