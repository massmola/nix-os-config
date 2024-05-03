{nixpkgs, self, user, ...}:
{

  # Enable Docker virtualization
  virtualisation.docker.enable = true;

  # Add the "docker" group to the user's extra groups
  users.users.${user.username}.extraGroups = [ "docker" ];
  
}