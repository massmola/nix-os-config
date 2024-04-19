{
  inputs,
  config,
  ...
}:
{
  imports = [
    ./packages.nix
  ]
  config.home.stateVersion = "22.05";
}