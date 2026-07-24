{ inputs, pkgs, ... }:
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
      inputs.llm-agents.overlays.shared-nixpkgs
    ];
  };

  environment.systemPackages = with pkgs; [
    system-manager
  ];
}
