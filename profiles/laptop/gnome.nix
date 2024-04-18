{
  config,
  pkgs,
  ...
}: {
  environment = {
    sessionVariables = {
      NAUTILUS_EXTENSION_DIR = "${config.system.path}/lib/nautilus/extensions-4";
    };

    pathsToLink = [
      "/share/nautilus-python/extensions"
    ];

    systemPackages = with pkgs; [
      gnome-extension-manager
      nautilus-open-any-terminal
      # morewaita-icon-theme
      gnome.epiphany
      bibata-cursors
      rubik
      lexend
      gnome.nautilus-python
      twitter-color-emoji
      zsh
    ];

    gnome.excludePackages =
      (with pkgs; [
        gedit # text editor
        gnome-photos
        gnome-tour
        gnome-connections
        snapshot
      ])
      ++ (with pkgs.gnome; [
        cheese # webcam tool
        gnome-music
        geary # email reader
        evince # document viewer
        # gnome-characters
        totem # video player
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
        yelp # Help view
        gnome-contacts
        gnome-initial-setup
        gnome-shell-extensions
        gnome-maps
        # gnome-font-viewer
      ]);
  };
}