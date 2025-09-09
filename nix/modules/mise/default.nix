{ config, lib, ... }:
{
  options.programs.mise = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = {
    home-manager.users.${config.common.username} = {
      programs.mise.enable = true;
    };
  };
}
