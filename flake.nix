{
  description = "MRR home manager flake";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    my-nvim.url = "github:m-roll/nvim-config";
    my-nvim.inputs.nixpkgs.follows = "nixpkgs";
    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = { self, nixpkgs, home-manager, my-nvim, nix-gaming, ...}: 
  let
    system = "x86_64-linux";
    steam-proton-ge-overlay = 
      (_: prev: {
        steam = prev.steam.override {
            extraProfile = 
	      "export STEAM_EXTRA_COMPAT_TOOLS_PATHS='${nix-gaming.packages.${pkgs.system}.proton-ge}'";
        };
        }
      );
    overlays = [steam-proton-ge-overlay];
    overlay = nixpkgs.lib.composeManyExtensions overlays;
    pkgs = nixpkgs.legacyPackages.${system}.extend overlay;
  in {
    homeConfigurations = {
      "mrr" = home-manager.lib.homeManagerConfiguration {
         inherit pkgs;
         modules = [ ./home.nix my-nvim.nixosModules."home-manager" ];
       };
    };
  };
}
