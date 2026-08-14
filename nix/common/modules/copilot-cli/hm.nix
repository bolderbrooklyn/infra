{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.copilot-cli.enable = lib.mkEnableOption "copilot-cli";

  config = lib.mkIf config.brooklyn.programs.copilot-cli.enable {
    home.packages = with pkgs.llm-agents; [
      copilot-cli
    ];
  };
}
