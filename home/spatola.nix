{ config, pkgs, ... }:

{
  home.username = "spatola";
  home.homeDirectory = "/home/spatola";
  
  imports = [
    ./common.nix
  ];

}