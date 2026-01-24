{
  config,
  inputs,
  pkgs,
  ...
}:
{
  home-manager.users.${config.common.username} = {
    home.packages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
      crush
    ];

    xdg.configFile.crush = {
      source = ./config/crush;
      recursive = true;
    };
  };
}
