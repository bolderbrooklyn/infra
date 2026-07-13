{
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.mise.enable = lib.mkEnableOption "mise" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.mise.enable {
    home-manager.users.${config.common.username} = {
      programs.mise = {
        enable = true;

        globalConfig.settings = {
          node.compile = false;
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
