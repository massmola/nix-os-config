{pkgs, lib, ...}: {

  services = {
    # for desktop environments
    dbus = {
      packages = with pkgs; [dconf gcr udisks2];
      enable = true;
    };

    udev.packages = with pkgs; [gnome.gnome-settings-daemon android-udev-rules];

    # collects messages from the kernel, early boot stages, and system processes, as well as any messages sent to syslog
    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';

    # manage disk drives and related devices
    udisks2.enable = true;

    # profile-sync-daemon
    psd = {
      enable = true;
      resyncTimer = "10m";
    };
  };

  systemd = {
    # Fedora enables these options by default. See the 10-oomd-* files here:
    # https://src.fedoraproject.org/rpms/systemd/tree/acb90c49c42276b06375a66c73673ac3510255
    oomd.enableRootSlice = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  # system-wide programs
  environment.systemPackages = with pkgs; [
    # utilities
    firefox       # web browser
    unzip         # extract files from .zip archives
    home-manager  # manage user configuration
    du-dust       # disk usage
    bat           # cat clone with wings

    # for development
    wget            # download files from the web
    curl            # transfer data with URLs
    netcat          # networking utility
    kitty           # terminal emulator
    vscode          # code editor
    git             # version control
    xclip           # command line interface to the X11 clipboard
    wl-clipboard    # Wayland clipboard manager
    wireguard-tools # VPN
    filezilla       # FTP client
    python3         

    # style
    (callPackage ./sugar-candy.nix{}).sddm-sugar-candy-theme # sddm theme
    libsForQt5.qt5.qtgraphicaleffects     # qt5 effects (necessary for theme)
    swww                          # for wallpapers
    xdg-desktop-portal-gtk        # for gtk file picker
    xdg-desktop-portal-hyprland   # for qt file picker
    xwayland                      # for x11 apps
    waybar                        # status bar
    meson                         # build system
    wofi                          # app launcher 
    dunst   

    # fixes hyprland
    wayland-protocols             
    wayland-utils                 
    wlroots                       

    # for games
    mangohud # display fps and other info
  ];

  # compress half of the ram to use as swap
  zramSwap = {
    enable = lib.mkDefault false;
    algorithm = "zstd";
  };

  programs = {
    # enable steam
    steam.enable = true;
    steam.gamescopeSession.enable = true; # enable gamescope for steam

    # enable gamemode
    gamemode.enable = true;
  
    java = {
      enable = true;
      package = pkgs.jre;
    };
  };
}
