{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.antigravity-cli = {
    enable = lib.mkEnableOption "antigravity-cli";
  };

  config = lib.mkIf config.brooklyn.programs.antigravity-cli.enable {
    programs.antigravity-cli = {
      enable = true;
      package = pkgs.llm-agents.antigravity-cli;

      permissions.allow = [
        "command(antigravity)"
        "command(cat)"
        "command(git commit)"
        "command(git diff)"
        "command(git log)"
        "command(git status)"
        "command(make build)"
      ];

      settings = {
        enableTelemetry = false;
        trustedWorkspaces = [
          "${config.home.homeDirectory}/Developer/Repositories/codeberg.org/bolderbrooklyn/infra"
        ];
      };
    };
  };
}
