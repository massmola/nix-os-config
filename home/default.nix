{
  nixpkgs,
  user,
  home-manager,
 ...
}:
{
  homeConfiguration.${user.username} = home-manager.lib.homeManagerConfiguration {
    modules = [ ./home.nix ]; 
  };
}