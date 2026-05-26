{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  llmAgentsPkgs = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};

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
    security = {
      auth = {
        selectedType = "oauth-personal";
      };
    };
    experimental = {
      skills = true;
    };
  };
in
{
  options.brooklyn.programs.antigravity-cli = {
    enable = lib.mkEnableOption "antigravity-cli";
  };

  config = lib.mkIf config.brooklyn.programs.antigravity-cli.enable {
    home-manager.users.${config.common.username} = {
      home.packages = with llmAgentsPkgs; [
        antigravity
      ];

      home.file.".gemini/antigravity-cli/settings.json".text =
        builtins.toJSON settings;
    };
  };
}
