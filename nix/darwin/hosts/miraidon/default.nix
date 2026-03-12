{ config, pkgs, ... }:
{
  imports = [
    ./brew.nix
    ../..
    ../../modules/colima
    ../../../common/profiles/gui
    ../../../common/modules/1password
    ../../../common/modules/alacritty
    ../../../common/modules/buku
    ../../../common/modules/copilot-cli
    ../../../common/modules/crush
    ../../../common/modules/gcloud-cli
    ../../../common/modules/gemini-cli
    ../../../common/modules/kubectl
    ../../../common/modules/opencode
    ../../../common/modules/openssh
    ../../../common/modules/xonsh
  ];

  system.stateVersion = 6;

  networking = {
    computerName = "Miraidon";
    hostName = "miraidon";
  };

  programs = {
    powershell.enable = true;
  };

  brooklyn.programs.calibre.enable = true;

  home-manager.users.${config.common.username} = {
    home.packages = with pkgs; [
      cmake
      chromedriver
      ffmpeg
    ];

    programs = {
      nushell.enable = true;

      opencode.settings.plugin = [ "opencode-wakatime@latest" ];

      zed-editor.userSettings.agent.default_model = {
        model = "claude-sonnet-4.5";
        provider = "copilot_chat";
      };
    };

    xdg.configFile."nvim/lua/plugins/wakatime.lua" = {
      source = ./config/nvim/lua/plugins/wakatime.lua;
      force = true;
    };

    xdg.configFile."opencode/oh-my-opencode.json" = {
      source = ./config/opencode/oh-my-opencode.json;
    };
  };
}
