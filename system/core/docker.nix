{nixpkgs, self, user, ...}:
{

  # Enable Docker virtualization
  virtualisation = {
    # docker
    docker.enable = true;

    # waydroid
    waydroid.enable = true;
    lxd.enable = true;
  }

  # Add the "docker" group to the user's extra groups
  users.users.${user.username}.extraGroups = [ "docker" ];
  
}