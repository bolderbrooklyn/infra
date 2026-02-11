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
    home.packages = with llmAgentsPkgs; [
      copilot-cli
    ];
  };
}
