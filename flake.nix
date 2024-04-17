{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";

    home-manager-unstable.url = "github:nix-community/home-manager/master";
    home-manager-unstable.inputs.nixpkgs.follows = "nixpkgs";

    home-manager-stable.url = "github:nix-community/home-manager/release-23.11";
    home-manager-stable.inputs.nixpkgs.follows = "nixpkgs-stable";
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let 
    # configure system
    systemSettings = {
      system = "x86_64-linux";
      profile = "laptop";
    };

    # configure lib
    lib = inputs.nixpkgs-stable.lib;

    # configure home-manager
    home-manager = inputs.home-manager-stable;
  in 
  {
    homeConfigurations = {};
    nixosConfigurations = {
      system = lib.nixosSystem {
        system = systemSettings.system;
        modules = [
          ./profiles/laptop/configuration.nix
        ];
      };
    };
  };
}
