{
  imports = [
    ../..
  ];

  brooklyn = {
    catppuccin.enable = true;

    programs = {
      fish.enable = true;
      git.enable = true;
      nvim.enable = true;
      pi-coding-agent.enable = true;
    };
  };
}
