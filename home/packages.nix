{pkgs, ...}: {
  nixpkgs.config.allowUnfree = false;
  home.packages = with pkgs; [
    wireshark
  ];
}