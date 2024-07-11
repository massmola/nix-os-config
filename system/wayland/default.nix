{pkgs, ...}: {
  imports = [
    ./fonts.nix
    ./services.nix
    ./pipewire.nix
  ];

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
}