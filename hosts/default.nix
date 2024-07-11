{ nixpkgs, inputs, user, ... }: 
let
  # modules to include in different systems
  core = ../system/core;                    # core features for every system
  touchpad = ../system/core/touchpad.nix;   # touchpad configuration
  wayland = ../system/wayland;              # wayland configuration

in {

  # laptop
  marvin = nixpkgs.lib.nixosSystem {
    
    system = "x86_64-linux";

    modules =
      [
        {networking.hostName = "marvin";}
        ./marvin
        core
        wayland
        touchpad
      ];
    
    specialArgs = {
      inherit inputs;
      inherit user;
    };
  };

  # workstation
  trillion = nixpkgs.lib.nixosSystem {
    
    system = "x86_64-linux";

    modules =
      [
        {networking.hostName = "trillion";}
        ./trillion
        core
        wayland
      ];
    
    specialArgs = {
      inherit inputs;
      inherit user;
    };
  };


}
