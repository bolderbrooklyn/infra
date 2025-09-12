{ config, ... }:
{
  home-manager.users.${config.common.username}.home.shellAliases = {
    ghce = "gh copilot explain";
    ghcs = "gh copilot suggest";
  };
}
