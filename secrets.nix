let
  tinkaton = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBQYI3hhHyHMtaVnJEZ986phkl1WX6Wu5vobHM61pkBL";
  brooklyn = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSrqkXtluHRGoNSDuwpPj2pZXlNZFxPFqsmwxjP1X0P";
in
{
  "nix/nixos/hosts/tinkaton/secrets/romm.age".publicKeys = [
    tinkaton
    brooklyn
  ];

  "nix/nixos/hosts/tinkaton/secrets/gitea-actions-runner-forgejo.age".publicKeys = [
    tinkaton
    brooklyn
  ];

  "nix/nixos/hosts/tinkaton/secrets/gitea-actions-runner-codeberg.age".publicKeys = [
    tinkaton
    brooklyn
  ];
}
