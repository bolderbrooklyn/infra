{ config, ... }:
{
  home-manager.users.${config.common.username} =
    { config, ... }:
    {
      home.sessionSearchVariables = {
        PATH = [ "${config.home.homeDirectory}/Library/Application Support/Coursier/bin" ];
      };

      programs.mise.globalConfig.settings = {
        idiomatic_version_file_enable_tools = [ "terraform" ];
      };
    };
}
