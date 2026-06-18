{
  config,
  pkgs,
  ...
}:
{
  home-manager.users.${config.common.username} = {
    programs.codex = {
      enable = true;
      enableMcpIntegration = true;
      package = pkgs.llm-agents.codex;
    };
  };
}
