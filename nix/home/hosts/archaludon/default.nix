{
  agenix,
  ...
}:
{
  imports = [
    agenix.homeManagerModules.default
    ../../../common
  ];

  home = {
    username = "brooklyn";
    homeDirectory = "/home/brooklyn";
    stateVersion = "26.05";
  };
}
