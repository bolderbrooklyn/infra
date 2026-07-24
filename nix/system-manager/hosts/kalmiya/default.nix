{ inputs, ... }:
{
  imports = [
    ../..
    ./users/kalmiya
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  nix.settings.trusted-users = [ "debian" ];

  nixpkgs = {
      config.allowUnfree = true;
      overlays = [
        (final: prev: {
          inherit (prev.lixPackageSets.latest)
            lix
            ;
        })
        inputs.llm-agents.overlays.shared-nixpkgs
      ];
    };
}
