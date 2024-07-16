{...}: {
  imports = [
    ./bluetooth.nix
    ./bootloader.nix
    ./fonts.nix
    ./local.nix
    ./users.nix
    ./security.nix
    ./services.nix
    ./system.nix
    ./virtualisation.nix
  ];
}