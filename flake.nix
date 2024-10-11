{
  description = "spatola's config";

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    
    user = {
      username = "spatola";
      description = "Spatola";
    };

  in {
    
    nixosConfigurations = import ./conf {inherit inputs nixpkgs user;};
  
  };

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    
  };
}
