{ config, lib, ... }:
{
  home-manager.users.${config.common.username}.home.shellAliases = lib.mkIf config.git.enable {
    ghce = "gh copilot explain";
    ghcs = "gh copilot suggest";
  };
}
