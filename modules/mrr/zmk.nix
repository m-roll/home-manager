{ config, pkgs, ... }:
let
  zmk = pkgs.python3Packages.buildPythonApplication rec {
    pname = "zmk";
    version = "0.1.1";
    pyproject = true;

    src = pkgs.fetchPypi {
      inherit pname version;
      hash = "sha256-tV9edivZUsSY7sFnUjkpWoj/r195oayThSXOyJZuUyE=";
    };

    build-system = [
      pkgs.python312Packages.wheel
      pkgs.python312Packages.setuptools
      pkgs.python312Packages.setuptools-scm
    ];

    dependencies = with pkgs.python312Packages; [
      dacite
      mako
      rich
      ruamel-yaml
      shellingham
      typer
      west
    ];
  };
in
{
  config = {
    home.packages = [ zmk ];
  };
}
