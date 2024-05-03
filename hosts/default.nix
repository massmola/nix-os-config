{
  nixpkgs,
  self,
  inputs,
  # user,
  ...
}: let
  inherit (self) inputs;
  # user info
  user = {
    username = "spatola";
    description = "Spatola";
  };
  
  # system inports
  core = ../system/core;
  touchpad = ../system/core/touchpad.nix;
  wayland = ../system/wayland;
  # hmModule = inputs.home-manager.nixosModules.home-manager;

  # home manager
  # home-manager = {
  #   useUserPackages = true;
  #   useGlobalPkgs = true;

  #   extraSpecialArgs = {
  #     inherit user;
  #     inherit inputs;
  #     inherit self;
  #   };

  #   users.${user.username} = {
  #     imports = [../home];

  #     _module.args.theme = import ../theme;
  #   };
  # };
in {

  # laptop
  marvin = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "marvin";}
        ./marvin
        core
        touchpad
        wayland
        # hmModule
      ];
    specialArgs = {
      inherit inputs;
      inherit user;
    };
  };
}
