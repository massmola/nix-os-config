{pkgs, ...}: {
  nixpkgs.config.allowUnfree = false;
  home.packages = with pkgs; [
    # TODO: Add your packages here
    wireshark
    python3
    gh
    vscode
    firefox
    ngrok
    ghidra
    bastet
  ];
}