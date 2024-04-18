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
    lib = inputs.nixpkgs.lib;

    pkgs = import inputs.nixpkgs {
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
    nixpkgs.url = "nixpkgs/nixos-23.11";
  };
}