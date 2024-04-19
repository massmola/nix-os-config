{
  nixpkgs,
  self,
  ...
}: let

in {
  # all my hosts are named after saturn moons btw

  # desktop
  marvin = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "marvin";}
        ./marvin
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };

  # thinkpad
  calypso = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "calypso";}
        ./calypso
        wayland
        hmModule
        bootloader
        impermanence
        hw.lenovo-thinkpad-x1-7th-gen
        {inherit home-manager;}
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };

  # x86 home server
  prometheus = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "prometheus";}
        bootloader
        ./prometheus
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };

  
  iapetus = nixpkgs.lib.nixosSystem {
    system = "aarch64";
    modules =
      [
        {networking.hostName = "iapetus";}
        hw.raspberry-pi-4
        server
        inputs.schizosearch.nixosModules.default
        ./iapetus
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };
}
