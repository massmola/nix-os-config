{pkgs, ...}: {
  nixpkgs.config.allowUnfree = false;
  home.packages = with pkgs; [
    wireshark
    python3
    gh
    vscode
    firefox
    ngrok
    ghidra
    bastet
    dconf
    gimp
    libreoffice-fresh
    transmission-gtk # torrent client
  ];
}