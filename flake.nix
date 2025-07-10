{
  description = "MRR home manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kitty-themes = {
      url = "github:dexpota/kitty-themes";
      flake = false;
    };
    rose-pine = {
      url = "github:rose-pine/neovim";
      flake = false;
    };

    nil = {
      url = "github:oxalica/nil";
    };
    conform = {
      url = "github:stevearc/conform.nvim";
      flake = false;
    };
    vim-nickel = {
      url = "github:nickel-lang/vim-nickel";
      flake = false;
    };
    nickel.url = "github:tweag/nickel/stable";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      kitty-themes,
      rose-pine,
      nil,
      conform,
      nickel,
      vim-nickel,
      ...
    }:
    let
      system = "x86_64-linux";
      steam-proton-ge-overlay = (
        _: prev: {
          steam = prev.steam.override {
            extraProfile = "export STEAM_EXTRA_COMPAT_TOOLS_PATHS='${prev.proton-ge-bin}'";
          };
        }
      );
      overlays = [ steam-proton-ge-overlay ];
      overlay = nixpkgs.lib.composeManyExtensions overlays;
      pkgs = nixpkgs.legacyPackages.${system}.extend overlay;
    in
    {
      homeConfigurations = {
        "mrr" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            (import ./modules/mrr/nvim_config/modules/home-manager.nix {
              inherit rose-pine conform vim-nickel;
              nickel-lang-lsp = nickel.packages.${system}.nickel-lang-lsp;
              nil = nil.packages.${system}.default;
              custom-plugin-src = ./modules/mrr/nvim_config/src;
            })
            { mrr.kitty.themes-package = kitty-themes; } # anonymous module for passing GH inputs into modules
          ];
        };
      };
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
