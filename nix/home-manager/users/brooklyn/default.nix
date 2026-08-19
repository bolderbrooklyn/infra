{
  imports = [
    ../..
  ];

  brooklyn = {
    catppuccin.enable = true;

    programs = {
      btop.enable = true;
      fish.enable = true;
      git.enable = true;
      nvim.enable = true;
      pi-coding-agent.enable = true;
      starship.enable = true;
    };
  };
}
