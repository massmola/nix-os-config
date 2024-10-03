{ config, pkgs, ... }:

{
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}