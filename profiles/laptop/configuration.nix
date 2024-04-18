# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, user, system, ... }:

{
    imports =
        [   
            ../../system/hardware-configuration.nix
            inputs.home-manager-stable.nixosModules.home-manager
            # ./home.nix
        ];

    home-manager = {
        extraSpecialArgs = {inherit inputs;};
        users = {
            spatola = import ./home.nix;
        };
    };

    # hardware
    hardware.bluetooth.enable = true;
    hardware.opengl = {
        enable = true;
        driSupport32Bit = true;
    };

    # nix flake
    nix.settings.experimental-features = [ "nix-command" "flakes" ];


    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "marvin"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Europe/Rome";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_GB.UTF-8";
        LC_IDENTIFICATION = "en_GB.UTF-8";
        LC_MEASUREMENT = "en_GB.UTF-8";
        LC_MONETARY = "en_GB.UTF-8";
        LC_NAME = "en_GB.UTF-8";
        LC_NUMERIC = "en_GB.UTF-8";
        LC_PAPER = "en_GB.UTF-8";
        LC_TELEPHONE = "en_GB.UTF-8";
        LC_TIME = "en_GB.UTF-8";
    };

    # Enable the GNOME Desktop Environment.
    # services.xserver.displayManager.gdm.enable = true;
    # services.xserver.desktopManager.gnome.enable = true;

    # Configure keymap in X11
    services.xserver = {
        layout = "us";
        xkbVariant = "";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;
    services.avahi.enable = true;

    # Enable touchpad support (enabled default in most desktopManager).
    services.xserver.libinput.enable = true;

    # enable programms

    #  Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${user.username} = {
        isNormalUser = true;
        description = user.description;
        extraGroups = [ "networkmanager" "wheel" "docker" "input" ];
        home-manager.enable = true;
        packages = with pkgs; [
            pkgs.firefox
            pkgs.direnv
        ];
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        vim
        wget
        zsh
        git
        cryptsetup
        home-manager
        wpa_supplicant
        vscode
        # Wayland
        wayland waydroid
            (sddm-chili-theme.override {
            themeConfig = {
                # ScreenWidth = 1920;
                # ScreenHeight = 1080;
                blur = true;
            };})
        # CPU printing
        cups-filters
        # docker
        docker
        docker-compose
        lazydocker
        # for hyprland
        waybar # bar
        dunst # notification deamon
        swww # screensharing
        kitty # terminal
        rofi-wayland    # launcher
        # games
        bastet
    ];

    # Pipewire
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };

    # dbus
    services.dbus = {
        enable = true;
        packages = [ pkgs.dconf ];
    };

    programs.dconf = {
        enable = true;
    };

    # Fonts
    fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "Inconsolata" ]; })
        powerline
        inconsolata
        inconsolata-nerdfont
        iosevka
        font-awesome
        ubuntu_font_family
        terminus_font
    ];

    # Configure xwayland
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    services.xserver = {
        enable = true;
        xkb = {
            layout = "us";
            variant = "";
            options = "caps:escape";
        };
        displayManager.sddm = {
            enable = true;
            wayland.enable = true;
            enableHidpi = true;
            # theme = "chili";
        };
    };

    # HYPRLAND
      # Security
    security = {
        pam.services.swaylock = {
        text = ''
            auth include login
        '';
        };
    #    pam.services.gtklock = {};
        pam.services.login.enableGnomeKeyring = true;
    };

    services.gnome.gnome-keyring.enable = true;

    programs = {
        hyprland = {
            enable = true;
            xwayland = {
                enable = true;
            };
            portalPackage = pkgs.xdg-desktop-portal-hyprland;
        };
    };

    # Docker
    virtualisation.docker = {
        enable = true;
        enableOnBoot = true;
        storageDriver = "btrfs";
        autoPrune.enable = true;
        rootless = {
            enable = true;
            setSocketVariable = true;
        };
        
    };

    system.stateVersion = "23.11"; # Did you read the comment?
}

