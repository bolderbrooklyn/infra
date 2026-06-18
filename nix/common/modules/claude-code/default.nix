{
  config,
  pkgs,
  ...
}:
{
  imports = [ ../catppuccin ];

  home-manager.users.${config.common.username} = {
    programs.claude-code = {
      enable = true;
      package = pkgs.llm-agents.claude-code;

      enableMcpIntegration = true;
    };
  };
}
