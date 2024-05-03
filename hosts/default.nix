{
  nixpkgs,
  inputs,
  user,
  ...
}: let
  # system inports
  core = ../system/core;
  touchpad = ../system/core/touchpad.nix;
  wayland = ../system/wayland;
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
