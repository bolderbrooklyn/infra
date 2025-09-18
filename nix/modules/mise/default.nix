{ config, ... }:
{
  config = {
    home-manager.users.${config.common.username} = {
      programs.mise = {
        enable = true;

        globalConfig.settings = {
          idiomatic_version_file_enable_tools = [ ];
        };
      };
    };
  };
}
