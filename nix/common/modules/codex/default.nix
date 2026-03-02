{
  config,
  inputs,
  pkgs,
  ...
}:
let
  llmAgentsPkgs = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  home-manager.users.${config.common.username} = {
    programs.codex = {
      enable = true;
      enableMcpIntegration = true;
      package = llmAgentsPkgs.codex;
    };
  };
}
