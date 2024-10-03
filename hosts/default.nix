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
        inputs.home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.spatola = import ./home-spatola.nix;
          home-manager.users.ict = import ./home-ict.nix;

          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }
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
      ];
    
    specialArgs = {
      inherit inputs;
      inherit user;
    };
  };


}
