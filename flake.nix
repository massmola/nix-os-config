{
  description = "spatola's config";

  outputs = { self, nixpkgs, ... }@inputs: 
  let 
    user = {
      username = "spatola";
      description = "Spatola";
    };
  in 
  {
    nixosConfigurations = import ./hosts {inputs};
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}