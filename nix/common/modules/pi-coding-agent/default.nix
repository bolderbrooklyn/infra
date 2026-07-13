{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.pi-coding-agent.enable = lib.mkEnableOption "pi-coding-agent";

  config = lib.mkIf config.brooklyn.programs.pi-coding-agent.enable {
    home-manager.users.${config.common.username} = {
      programs.pi-coding-agent = {
        enable = true;
        package = pkgs.llm-agents.pi;

        extraPackages = with pkgs; [
          nodejs
          bun
        ];
      };
    };
  };
}