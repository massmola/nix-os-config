{pkgs, ...} : {
    environment.systemPackages = with pkgs; [
        # style
        swww    # for wallpapers   
    ];
}