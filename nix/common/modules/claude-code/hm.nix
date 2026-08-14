{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.claude-code.enable = lib.mkEnableOption "claude-code";

  config = lib.mkIf config.brooklyn.programs.claude-code.enable {
    programs.claude-code = {
      enable = true;
      package = pkgs.llm-agents.claude-code;

      enableMcpIntegration = true;
    };
  };
}
