{ config, pkgs, ... }:

{
  home.username = "ict";
  home.homeDirectory = "/home/ict";
  
  imports = [
    ./common.nix
  ];

}