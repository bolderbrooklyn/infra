{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.zsh.enable = lib.mkEnableOption "zsh" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.zsh.enable {
    programs.zsh.enable = true;

    environment.shells = [ pkgs.zsh ];

    home-manager.sharedModules = [ ./hm.nix ];
  };
}
