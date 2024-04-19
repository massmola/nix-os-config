{nixpkgs, self, user, ...}:
{
  virtualisation.docker.enable = true;
  users.users.${user.username}.extraGroups = [ "docker" ];
}