let
  brooklyn = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSrqkXtluHRGoNSDuwpPj2pZXlNZFxPFqsmwxjP1X0P";
  kalmiya = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBG8uvEHIqxEGc7IQIBaFG/GzGIXmGYC/YroSDKg6oNl";
in
{
  "secrets/op-service-account-token.age".publicKeys = [
    brooklyn
    kalmiya
  ];
}
