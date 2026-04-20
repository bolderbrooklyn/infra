{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  llmAgentsPkgs = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  options.brooklyn.programs.gemini-cli = {
    enable = lib.mkEnableOption "gemini-cli";
  };

  config = lib.mkIf config.brooklyn.programs.gemini-cli.enable {
    home-manager.users.${config.common.username} = {
      programs.gemini-cli = {
        enable = true;
        package = llmAgentsPkgs.gemini-cli;

        settings = {
          general = {
            enableAutoUpdate = false;
            enablePromptCompletion = true;
            preferredEditor = "nvim";
            previewFeatures = true;
            vimMode = true;
          };
          ide = {
            enabled = true;
            hasSeenNudge = false;
          };
          security.auth.selectedType = "oauth-personal";
          experimental = {
            skills = true;
          };
        };
      };
    };
  };
}
