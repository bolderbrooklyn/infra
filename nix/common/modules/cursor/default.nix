{
  config,
  inputs,
  lib,
  pkgs,
  isDarwin,
  ...
}:
let
  cfg = config.programs.cursor;
  llmAgentsPkgs = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  options.programs.cursor = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    cli.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable (
    {
      home-manager.users.${config.common.username} = {
        home.packages = lib.mkIf cfg.cli.enable (
          with llmAgentsPkgs;
          [
            cursor-agent
          ]
        );
      };
    }
    // lib.optionalAttrs isDarwin {
      homebrew.casks = [ "cursor" ];
    }
  );
}
