{ config, pkgs, ... }:
{
  imports = [
    ./brew.nix
    ../..
    ../../modules/sikarugir
    ../../../common/modules/opencode
  ];

  system.stateVersion = 6;

  networking.computerName = "Xerneas";

  brooklyn.programs = {
    crush.enable = true;
  };

  home-manager.users.${config.common.username} = {
    xdg.configFile."opencode/oh-my-openagent.jsonc" = {
      source = ./config/opencode/oh-my-openagent.jsonc;
      force = true;
    };
  };
}
