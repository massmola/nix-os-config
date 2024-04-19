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
    nixosConfigurations = import ./hosts inputs;
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}