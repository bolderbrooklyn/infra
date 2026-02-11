{
  config,
  inputs,
  pkgs,
  ...
}:
let
  pkgs-orig = pkgs;
in
{
  home-manager.users.${config.common.username} =
    let
      pkgs = import inputs.nixpkgs-unstable {
        inherit (pkgs-orig.stdenv.hostPlatform) system;
        overlays = [ inputs.nix-moltbot.overlays.default ];
      };
    in
    {
      imports = [
        inputs.nix-moltbot.homeManagerModules.clawdbot
      ];

      _module.args.pkgs = pkgs;

      programs.clawdbot = {
        documents = ./documents;
        instances.default.enable = true;

        firstParty = {
          peekaboo.enable = false;
          summarize.enable = false;
        };
      };
    };
}
