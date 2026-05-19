{ config, pkgs, ... }:
{
  home-manager.users.${config.common.username} = {
    home.packages = [ pkgs.devenv ];

    programs.fish.interactiveShellInit = ''
      devenv hook fish | source
    '';
  };
}
