{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.openclaw = {
    enable = lib.mkEnableOption "openclaw";

    user = lib.mkOption {
      type = lib.types.str;
      default = config.common.username;
      description = "User account to enable openclaw for";
    };
  };

  config = lib.mkIf config.brooklyn.programs.openclaw.enable {
    nixpkgs.overlays = [
      inputs.nix-openclaw.overlays.default
    ];

    home-manager.users.${config.brooklyn.programs.openclaw.user} =
      { ... }:
      {
        home.stateVersion = "26.05";

        imports = [
          inputs.nix-openclaw.homeManagerModules.openclaw
        ];

        programs.openclaw = {
          enable = true;
          # package = lib.mkForce (pkgs.openclaw.override {
          #   openclaw-gateway = pkgs.openclaw-gateway.override {
          #     pnpmDepsHash = "sha256-Um+4ed0nxHnznwdHODYg5hMaV8ADHtr3TFe2VoJ32ew=";
          #   };
          # });
          documents = ./documents;
          bundledPlugins = {
            # All plugins must be explicitly disabled due to hardcoded revs in nix-openclaw
            # that have mutable path locks Lix rejects. goplaces has defaultEnable = true.
            goplaces.enable = lib.mkForce false;
            summarize.enable = lib.mkForce false;
            discrawl.enable = lib.mkForce false;
            wacrawl.enable = lib.mkForce false;
            peekaboo.enable = lib.mkForce false;
            poltergeist.enable = lib.mkForce false;
            sag.enable = lib.mkForce false;
            camsnap.enable = lib.mkForce false;
            gogcli.enable = lib.mkForce false;
            qmd.enable = lib.mkForce false;
            sonoscli.enable = lib.mkForce false;
            imsg.enable = lib.mkForce false;
          };
        };
      };
  };
}
