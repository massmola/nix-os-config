{
  description = "spatola's config";

  outputs = { self, nixpkgs, ... }@inputs: 
  let 
    # configure system
    system = {
        system = "x86_64-linux";
        profile = "laptop";
    };

    user = {
      username = "spatola";
      description = "Spatola";
      wm = "hyprland";
      wmType = "wayland";
    };

    # configure lib
    lib = inputs.nixpkgs-stable.lib;

    pkgs = import inputs.nixpkgs-stable {
      system = system.system;
      config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      };
    };

    # configure home-manager
    home-manager = inputs.home-manager-stable;
  in 
  {
    nixosConfigurations = {
      system = lib.nixosSystem {
        system = system.system;
        modules = [
          (./. + "/profiles" + ("/" + system.profile) + "/configuration.nix")
        ];

      specialArgs = {
        inherit system;
        inherit user;
        inherit inputs;
        };
      };
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";

    home-manager-unstable.url = "github:nix-community/home-manager/master";
    home-manager-unstable.inputs.nixpkgs.follows = "nixpkgs";

    home-manager-stable.url = "github:nix-community/home-manager/release-23.11";
    home-manager-stable.inputs.nixpkgs.follows = "nixpkgs-stable";
  };
}