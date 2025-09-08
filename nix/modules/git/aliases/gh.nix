{ config, lib, ... }:
{
  home-manager.users.${config.common.username}.home.shellAliases =
    lib.mkIf config.programs.git.enable
      {
        ghce = "gh copilot explain";
        ghcs = "gh copilot suggest";
      };
}
