{
  config,
  inputs,
  user,
  ...
}:
{
  home.username = user.username;

  imports = [
    # ./desktop
    # ./packages.nix
    # ./cli
  ];

  config.home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}