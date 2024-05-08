{pkgs, ...}: {

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
      ubuntu_font_family
      material-icons
      material-design-icons
      roboto
      work-sans
      comic-neue
      source-sans
      twemoji-color-font
      comfortaa
      inter
      lato
      lexend
      jost
      dejavu_fonts
      iosevka-bin
      jetbrains-mono
      nerdfonts
      meslo-lgs-nf
      liberation_ttf
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Ubuntu" ];
        sansSerif = [ "Ubuntu" ];
        monospace = [ "FiraCode" ];
    };
  };
  };
  
}