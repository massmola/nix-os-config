{pkgs, ...} : {
    # for electron apps
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    environment.systemPackages = with pkgs; [
        
        firefox       # web browser
        tor-browser   # web browser
        vscode          # code editor
        warp-terminal  # terminal


        
        # style
        swww    # for wallpapers  
        vlc 
    ];
}