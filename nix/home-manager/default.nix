{
  config,
  lib,
  llm-agents,
  pkgs,
  ...
}:
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
    ./modules/font
    ./modules/programs
    ./profiles/gui
  ];

  config = {
    home = {
      inherit (config.brooklyn) username homeDirectory;

      stateVersion = "26.11";
      enableNixpkgsReleaseCheck = false;
    };

    nix.package = pkgs.lix;

    nixpkgs = {
      config.allowUnfree = true;

      overlays = [
        llm-agents.overlays.shared-nixpkgs
      ];
    };

    programs.home-manager.enable = true;

    services.home-manager.autoExpire.enable = true;

    xdg = {
      enable = true;
      localBinInPath = true;
    };
  };
}
