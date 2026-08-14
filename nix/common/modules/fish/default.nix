{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs) fish;
  inherit (config.common) username;

  cfg = config.programs.fish;
in
{
  options.programs.fish = {
    defaultShell = lib.mkEnableOption "fish.defaultShell";
  };

  options.brooklyn.programs.fish.enable = lib.mkEnableOption "fish" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.fish.enable {
    programs.fish.enable = true;

    programs.fish.useBabelfish = true;

    environment.shells = [ fish ];

    users.users.${username}.shell = lib.mkIf cfg.defaultShell fish;

    home-manager.sharedModules = [ ./hm.nix ];
  };
}
