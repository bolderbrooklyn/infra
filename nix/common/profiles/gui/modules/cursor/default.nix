{
  config,
  inputs,
  lib,
  pkgs,
  isDarwin,
  ...
}:
let
  cfg = config.brooklyn.programs.cursor;
  llmAgentsPkgs = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in
with lib;
{
  options.brooklyn.programs.cursor = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };

    cli.enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable (
    {
      home-manager.users.${config.common.username} = {
        home.packages = mkIf cfg.cli.enable (
          with llmAgentsPkgs;
          [
            cursor-agent
          ]
        );
      };
    }
    // optionalAttrs isDarwin {
      homebrew.casks = [ "cursor" ];
    }
  );
}
