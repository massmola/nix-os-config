{pkgs, lib, ...}: {

  services = {
    # collects messages from the kernel, early boot stages, and system processes, as well as any messages sent to syslog
    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';

    # Configuration for the OpenSSH server.
    openssh = {
      enable = true;  # Enable the OpenSSH server.
      ports = [ 22 ];  # Specify the ports to listen on.
      settings = {
        PasswordAuthentication = true;  # Allow password authentication.
        AllowUsers = null;  # Allow all users by default. Can be set to a list of specific users.
        UseDns = true;  # Use DNS to resolve client hostnames.
        X11Forwarding = false;  # Disable X11 forwarding.
        PermitRootLogin = "prohibit-password";  # Specify the root login behavior.Options: "yes", "without-password", "prohibit-password","forced-commands-only", "no"
      };
    };

    # manage disk drives and related devices
    udisks2.enable = true;
  };

  # Enables the root slice for the Out-of-Memory Daemon (oomd).
  systemd = {
    oomd.enableRootSlice = true;
  };

  # This configuration sets the garbage collector options for Nix.
  # - `automatic` enables automatic garbage collection.
  # - `dates` specifies the frequency of garbage collection, set to "daily".
  # - `options` sets additional options for garbage collection, in this case "--delete-older-than 7d" which deletes files older than 7 days.
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
    dunst                         # notification daemon

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

    ssh.startAgent = true;
    ssh.addKeysToAgent = "yes";

    # enable gamemode
    gamemode.enable = true;
  
    # enables java
    java = {
      enable = true;
      package = pkgs.jre;
    };
  };
}
