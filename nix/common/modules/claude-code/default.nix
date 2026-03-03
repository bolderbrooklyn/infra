{
  config,
  inputs,
  pkgs,
  ...
}:
let
  llmAgentsPackages = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [ ../catppuccin ];

  home-manager.users.${config.common.username} = {
    programs.claude-code = {
      enable = true;
      package = llmAgentsPackages.claude-code;

      enableMcpIntegration = true;
    };
  };
}
