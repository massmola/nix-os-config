{user, ...}: {

  home.persistence."/persist/home/${user.username}" = {
    allowOther = true;
    directories =
      [
        "download"
        "music"
        "dev"
        "docs"
        "pics"
        "vids"
        "other"
      ]
  };
}
