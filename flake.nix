{
  description = "Configuracion para Laptops";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
   plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =  { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations = {
     Laptop = nixpkgs.lib.nixosSystem {
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
