{
  description = "spatola's config";

  outputs = { self, nixpkgs, ... }@inputs: 
  let 

    inherit (self) inputs;
    inherit (inputs) nixpkgs home-manager;
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

    homeDir = self + /homes;
    hm = home-manager.nixosModules.home-manager;
    homes = [
      homeDir
      hm
    ];

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
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impurity.url = "github:outfoxxed/impurity.nix";
    thorium.url = "github:end-4/nix-thorium";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      # inputs.nixpkgs.follows = "hyprland";
    };

    ags.url = "github:Aylur/ags";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    gross = {
      url = "github:fufexan/gross";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    matugen = {
      url = "github:/InioX/Matugen";
      # ref = "refs/tags/matugen-v0.10.0"
    };
    more-waita = {
      url = "github:somepaulo/MoreWaita";
      flake = false;
    };
    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}