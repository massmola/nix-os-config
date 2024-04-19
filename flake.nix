{
  description = "spatola's config";

  outputs = { self, nixpkgs, ... }@inputs:  
  {
    nixosConfigurations = import ./hosts inputs;
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}