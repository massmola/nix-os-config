{...}: {
  imports = [
    ./docker.nix
    ./bluetooth.nix
    ./local.nix
    ./users.nix
    ./system.nix
    ./bootloader.nix
    ./security.nix
    ./fonts.nix
  ];
}