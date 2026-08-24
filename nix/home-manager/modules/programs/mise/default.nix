{
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.mise.enable = lib.mkEnableOption "mise";

  config = {
    programs.mise = {
      inherit (config.brooklyn.programs.mise) enable;

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
}
