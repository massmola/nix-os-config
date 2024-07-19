{pkgs, lib, ...}: {

  services = {
    # collects messages from the kernel, early boot stages, and system processes, as well as any messages sent to syslog
    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';

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
    tor-browser   # web browser
    unzip         # extract files from .zip archives
    home-manager  # manage user configuration
    du-dust       # disk usage
    bat           # cat clone with wings
    htop          # interactive process viewer

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
    gnumake42       # make
    aria2           # download manager

    # style
    swww                          # for wallpapers         
                      
  ];

  # compress half of the ram to use as swap
  zramSwap = {
    enable = lib.mkDefault false;
    algorithm = "zstd";
  };

  programs = {
    # enable steam
    steam = {
      enable = true;
      gamescopeSession.enable = true; # enable gamescope for steam
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };

    ssh.startAgent = true;
    # ssh.addKeysToAgent = "yes";

    # enable gamemode
    gamemode.enable = true;


    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
  
    # enables java
    java = {
      enable = true;
      package = pkgs.jre;
    };
  };
}
