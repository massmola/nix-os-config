{
  inputs,
  config,
  ...
}:
{
  config.home.stateVersion = "22.11";
  imports = [
    ./packages.nix
    ./cli
    ./desktop
  ];
}