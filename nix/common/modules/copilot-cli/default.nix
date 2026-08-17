{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.copilot-cli.enable = lib.mkEnableOption "copilot-cli";

  config = lib.mkIf config.brooklyn.programs.copilot-cli.enable {
    home-manager.users.${config.common.username} = {
      home.packages = with pkgs.llm-agents; [
        copilot-cli
      ];
    };
  };
}
