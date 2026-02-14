{ config, ... }:
{
  config = {
    home-manager.users.${config.common.username} = {
      programs.mise = {
        enable = true;

        globalConfig.settings = {
          ruby.compile = false;
          idiomatic_version_file_enable_tools = [
            "node"
            "ruby"
          ];
        };
      };
    };
  };
}
