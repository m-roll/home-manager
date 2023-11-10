{
  description = "MRR home manager flake";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvim-config.url = "github:m-roll/nvim-config";
  };

  outputs = { self, nixpkgs, home-manager, nvim-config, ...}: 
  let
    system = "x86_64-linux";
    overlays = [ nvim-config.overlays.${system}.default ];
    overlay = nixpkgs.lib.composeManyExtensions overlays;
    pkgs = nixpkgs.legacyPackages.${system}.extend overlay;
  in {
    homeConfigurations = {
      "mrr" = home-manager.lib.homeManagerConfiguration {
         inherit pkgs;
         modules = [ ./home.nix ];
       };
    };
  };
}
