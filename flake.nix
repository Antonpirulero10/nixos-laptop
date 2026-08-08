{
  description = "Home Manager configuration of antonpirulero10";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =  { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations = {
      Antonpirulero10-PC = nixpkgs.lib.nixosSystem {
      	specialArgs = { inherit inputs; };
      	modules = [
      	  ./configuration.nix
      	  inputs.home-manager.nixosModules.default
      	  {
      	    home-manager = {
              extraSpecialArgs = { inherit inputs; };
              users = {
                antonpirulero10 = import ./home.nix;
              };
            };
      	  }
      	];
      };
    };
  };
}
