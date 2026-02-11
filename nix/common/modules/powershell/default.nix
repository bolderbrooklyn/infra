{
  config,
  lib,
  pkgs,
  ...
}:
let
  pwsh = pkgs.powershell;
in
{
  options.programs.powershell = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    extraConfig = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  config = lib.mkIf config.programs.powershell.enable {
    environment.systemPackages = [ pwsh ];
    environment.shells = [ pwsh ];

    home-manager.users.${config.common.username}.xdg.configFile."powershell/Microsoft.PowerShell_profile.ps1".text =
      ''
        [System.Environment]::SetEnvironmentVariable('PATH', $('{0}/.nix-profile/bin:/etc/profiles/per-user/{1}/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:' -f $HOME, $env:USER + $env:PATH), [System.EnvironmentVariableTarget]::Process)

        ${lib.concatStringsSep "\n" config.programs.powershell.extraConfig}
      '';
  };
}
