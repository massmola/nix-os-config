{
  inputs,
  config,
  ...
}:
{
  config.home.stateVersion = "22.11";
  imports = [
    inputs.nix-index-db.hmModules.nix-index
    inputs.hyprland.homeManagerModules.default

    # ./desktop
    ./packages.nix
    ./cli
  ];
}