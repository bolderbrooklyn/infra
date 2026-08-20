{ config, ... }:
let
  guiEnable = config.brooklyn.gui.enable;
in
{
  imports = [
    ../..
  ];

  brooklyn = {
    catppuccin.enable = true;

    programs = {
      bat.enable = true;
      btop.enable = true;
      fd.enable = true;
      fish.enable = true;
      fzf.enable = true;
      ghostty.enable = guiEnable;
      git.enable = true;
      nvim.enable = true;
      pi-coding-agent.enable = true;
      ripgrep.enable = true;
      starship.enable = true;
      tmux.enable = true;
    };
  };

  programs.zoxide.enable = true;
}
