{
  config,
  lib,
  llm-agents,
  nix-obsidian-extensions,
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
    ./modules/agent-instructions
    ./modules/catppuccin
    ./modules/font
    ./modules/programs
    ./modules/services
    ./profiles/gui
  ];

  config = {
    home = {
      inherit (config.brooklyn) username homeDirectory;

      stateVersion = lib.mkDefault "26.11";
      enableNixpkgsReleaseCheck = false;
    };

    nix.package = lib.mkDefault pkgs.lix;

    nixpkgs = {
      config.allowUnfree = lib.mkDefault true;

      overlays = [
        llm-agents.overlays.shared-nixpkgs
        nix-obsidian-extensions.overlays.default
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
