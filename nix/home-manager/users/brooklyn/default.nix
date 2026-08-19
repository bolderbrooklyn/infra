{
  imports = [
    ../..
  ];

  brooklyn = {
    catppuccin.enable = true;

    programs = {
      btop.enable = true;
      fd.enable = true;
      fish.enable = true;
      fzf.enable = true;
      git.enable = true;
      nvim.enable = true;
      pi-coding-agent.enable = true;
      ripgrep.enable = true;
      starship.enable = true;
    };
  };

  programs.zoxide.enable = true;
}
