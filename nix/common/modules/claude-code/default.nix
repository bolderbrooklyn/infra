{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ../catppuccin ];

  options.brooklyn.programs.claude-code.enable = lib.mkEnableOption "claude-code";

  config = lib.mkIf config.brooklyn.programs.claude-code.enable {
    home-manager.users.${config.common.username} = {
      programs.claude-code = {
        enable = true;
        package = pkgs.llm-agents.claude-code;

        enableMcpIntegration = true;
      };
    };
  };
}