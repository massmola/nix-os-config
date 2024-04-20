{
  nixpkgs,
  self,
  # inputs,
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
  hmModule = inputs.home-manager.nixosModules.home-manager;

  # home manager
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;

    extraSpecialArgs = {
      inherit user;
      inherit inputs;
      inherit self;
    };

    users.${user.username} = {
      imports = [../home];

      _module.args.theme = import ../theme;
    };
  };
in {
  # all my hosts are named after saturn moons btw

  # desktop
  marvin = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "marvin";}
        ./marvin
        core
        touchpad
        # hmModule
        # {inherit home-manager;}
      ];
    specialArgs = {
      inherit inputs;
      inherit user;
    };
  };

  # thinkpad
  # calypso = nixpkgs.lib.nixosSystem {
  #   system = "x86_64-linux";
  #   modules =
  #     [
  #       {networking.hostName = "calypso";}
  #       ./calypso
  #       wayland
  #       hmModule
  #       bootloader
  #       impermanence
  #       hw.lenovo-thinkpad-x1-7th-gen
  #       {inherit home-manager;}
  #     ];
  #   specialArgs = {inherit inputs;};
  # };
}
