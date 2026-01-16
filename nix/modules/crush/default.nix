{
  config,
  inputs,
  pkgs,
  ...
}:
{
  home-manager.users.${config.common.username} = {
    home.packages = with inputs.llm-agents.packages.${pkgs.system}; [
      crush
    ];

    xdg.configFile.crush = {
      source = ./config/crush;
      recursive = true;
    };
  };
}
