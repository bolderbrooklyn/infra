# Kalmiya Home-Manager

Standalone home-manager configuration for the `kalmiya` service user, independent of the NixOS system configuration.

## Build

```bash
cd nix/kalmiya-home
nix build .#homeConfigurations.kalmiya.activationPackage
```

## Apply (as kalmiya user)

```bash
sudo -u kalmiya ./result/activate
```

Or using `home-manager` directly (if installed on the target system):

```bash
cd nix/kalmiya-home
home-manager switch --flake .#kalmiya
```
