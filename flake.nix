{
  description = "A very basic flake";

  outputs = { self, nixpkgs, ... }@inputs: 
  let 
    # configure system
    system = {
      system = "x86_64-linux";
      profile = "laptop";
    };

    user = {
      wm = "myprland";
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
        system = system.system;
        modules = [
          (./. + "/profiles" + ("/" + system.profile) + "/configuration.nix")        
        ];
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

    hyprland.url = "github:hyprwm/Hyprland";
    plugin_name = {
        url = "github:maintener/plugin_name";
        inputs.hyprland.follows = "hyprland"; # IMPORTANT
    };
  
  };

}
