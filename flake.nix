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
  };

  outputs = { self, nixpkgs, home-manager, my-nvim, ...}: 
  let
    system = "x86_64-linux";
    overlays = [];
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
