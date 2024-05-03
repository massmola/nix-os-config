{ nixpkgs, inputs, user, ... }: 
let

  core = ../system/core;
  touchpad = ../system/core/touchpad.nix;
  wayland = ../system/wayland;

in {

  # os config for marvin (my laptop)
  marvin = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "marvin";}
        ./marvin
        core
        touchpad
        wayland
      ];
    specialArgs = {
      inherit inputs;
      inherit user;
    };
  };
}
