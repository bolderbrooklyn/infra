{ config, pkgs, ... }:
let
  guiEnable = config.brooklyn.gui.enable;

  devices = {
    archaludon = "ZHWGSS6-5I64CZJ-BIJUW2V-5PWBVNN-OAJUCJ4-TZBZUR3-6NK3ZRE-7X6ZCAX";
    frosmoth = "FZ7RMRL-63TTPTJ-TST5N3L-OZYR3A5-MHCD3PF-O7P4LRE-DCVELUQ-7XIY6QN";
    kalmiya = "RRLC4XH-QGDELNX-PAC7FIL-QAXNZRP-5CARJ6F-OK7VLG3-B27BXHA-SHP6ZAJ";
    miraidon = "YSTLBUH-WNBOF32-L4HXMGH-D7SQTJ5-ZWFWX2B-L6O5DN3-N2TSNSD-7DESKAB";
    tinkaton = "AROYTWX-4VWVTAQ-S7WGFPF-TNNGPLI-H2NDQII-DEUAEIG-CBUNP7A-76QS2A3";
    xerneas = "6YQUA3X-4I57UQW-Z7XB3F7-ZZONOQK-3PPAQ3M-6BBREO6-GASPHXM-YEFSTQA";
  };
in
{
  imports = [
    ../..
  ];

  home = {
    packages = with pkgs; [
      httpie
      yq
    ];

    shellAliases = {
      l = "ls -alh";
    };
  };

  brooklyn = {
    catppuccin.enable = true;

    programs = {
      alacritty.enable = guiEnable;
      bat.enable = true;
      btop.enable = true;
      crush.enable = true;
      eza.enable = true;
      fd.enable = true;
      fish.enable = true;
      fzf.enable = true;
      ghostty.enable = guiEnable;
      git.enable = true;
      gnupg.enable = true;
      neovide.enable = guiEnable;
      nvim.enable = true;
      obsidian.enable = guiEnable;
      opencode.enable = true;
      pi-coding-agent.enable = true;
      ripgrep.enable = true;
      starship.enable = true;
      television.enable = true;
      tmux.enable = true;
    };

    services.syncthing = {
      inherit devices;

      enable = true;
    };
  };

  programs = {
    devenv.enable = true;
    yazi.enable = true;
    zoxide.enable = true;
  };
}
