{
  user,
 ...
}:
{
  homeConfiguration.${user.username} = home-manager.lib.homeManagerConfiguration {

  };
}