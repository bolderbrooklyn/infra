{ config, lib, ... }:
{
  options.brooklyn = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "brooklyn";
    };

    homeDirectory = lib.mkOption {
      type = lib.types.str;
      default = "/home/${config.brooklyn.username}";
    };
  };

  imports = [
    ./modules/catppuccin
    ./modules/fish
    ./modules/git
    ./modules/nvim
  ];

  config = {
    home = {
      inherit (config.brooklyn) username homeDirectory;

      stateVersion = "26.11";
      enableNixpkgsReleaseCheck = false;
    };

    programs.home-manager.enable = true;

    services.home-manager.autoExpire.enable = true;

    xdg = {
      enable = true;
      localBinInPath = true;
    };
  };
}
