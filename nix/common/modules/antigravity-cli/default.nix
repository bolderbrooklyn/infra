{
  config,
  lib,
  pkgs,
  ...
}:
let
  settings = {
    enableTelemetry = false;
    permissions = {
      allow = [
        "command(cat)"
        "command(git status)"
        "command(git log)"
        "command(make build)"
        "command(git diff)"
        "command(antigravity)"
        "command(git commit)"
      ];
    };
    trustedWorkspaces = [
      "/home/brooklyn/Developer/Repositories/codeberg.org/bolderbrooklyn/infra"
      "/Users/brooklyn/Developer/Repositories/codeberg.org/bolderbrooklyn/infra"
    ];
  };
in
{
  options.brooklyn.programs.antigravity-cli = {
    enable = lib.mkEnableOption "antigravity-cli";
  };

  config = lib.mkIf config.brooklyn.programs.antigravity-cli.enable {
    home-manager.users.${config.common.username} =
      { config, lib, ... }:
      let
        settingsFile = pkgs.writeText "antigravity-settings.json" (builtins.toJSON settings);
      in
      {
        home.packages = with pkgs.llm-agents; [
          antigravity-cli
        ];

        home.activation.antigravitySettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          run mkdir -p ${config.home.homeDirectory}/.gemini/antigravity-cli
          run cp -f ${settingsFile} ${config.home.homeDirectory}/.gemini/antigravity-cli/settings.json
          run chmod u+w ${config.home.homeDirectory}/.gemini/antigravity-cli/settings.json
        '';
      };
  };
}
