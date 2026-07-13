{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.codex.enable = lib.mkEnableOption "codex";

  config = lib.mkIf config.brooklyn.programs.codex.enable {
    home-manager.users.${config.common.username} = {
      programs.codex = {
        enable = true;
        enableMcpIntegration = true;
        package = pkgs.llm-agents.codex;
      };
    };
  };
}
