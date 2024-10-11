{ config, pkgs, ... }:

{
  home.username = "ict";
  home.homeDirectory = "/home/ict";

  
  imports = [
    ./home-common.nix
  ];

}