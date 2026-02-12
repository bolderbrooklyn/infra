let
  brooklyn = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSrqkXtluHRGoNSDuwpPj2pZXlNZFxPFqsmwxjP1X0P";
  # miraidon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGSAyD62UHGyyGtrnhdF4hMS2K4tOAutZSZY4AnfzLDp";
  tinkaton = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBQYI3hhHyHMtaVnJEZ986phkl1WX6Wu5vobHM61pkBL";
in
{
  "nix/nixos/hosts/tinkaton/secrets/romm.age" = {
    armor = true;
    publicKeys = [
      brooklyn
      tinkaton
    ];
  };

  "nix/nixos/hosts/tinkaton/secrets/gitea-actions-runner-forgejo.age" = {
    armor = true;
    publicKeys = [
      brooklyn
      tinkaton
    ];
  };

  "nix/nixos/hosts/tinkaton/secrets/gitea-actions-runner-codeberg.age" = {
    armor = true;
    publicKeys = [
      brooklyn
      tinkaton
    ];
  };

  "nix/nixos/hosts/tinkaton/secrets/password-brooklyn.age" = {
    armor = true;
    publicKeys = [
      brooklyn
      tinkaton
    ];
  };
}
