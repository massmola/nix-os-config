{...}: {

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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # compress half of the ram to use as swap
  zramSwap = {
    enable = lib.mkDefault false;
    algorithm = "zstd";
  };

  programs = {
    # ensure that your programs are linked against the exact versions of libraries they were built with
    # nix-ld.enable = true;
  
    java = {
      enable = true;
      package = pkgs.jre;
    };
  };
}