{ inputs, pkgs, ... }:
{
  nix.package = pkgs.lixPackageSets.stable.lix;

  nix.gc.automatic = true;
  nix.optimise.automatic = true;

  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
  ];

  environment.shells = with pkgs; [
    fish
    powershell
  ];

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  time.timeZone = "America/Los_Angeles";
}
