{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.gcloud-cli.enable = lib.mkEnableOption "gcloud-cli";

  config.home-manager.sharedModules = [ ./hm.nix ];
}
