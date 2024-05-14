{ pkgs, lib, config, ... }:
let cfg = config.mrr.licensing;
in {
  options.mrr.licensing = {
    allowed_unfree_pkg_names =
      lib.mkOption { type = lib.types.listOf lib.types.str; };
  };

  config = {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) cfg.allowed_unfree_pkg_names;
  };
}
