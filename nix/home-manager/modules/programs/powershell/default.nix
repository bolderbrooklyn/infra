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
  options.brooklyn.programs.powershell = {
    enable = lib.mkEnableOption "powershell";

    extraConfig = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  config = lib.mkIf config.brooklyn.programs.powershell.enable {
    home.packages = [ pwsh ];

    xdg.configFile."powershell/Microsoft.PowerShell_profile.ps1".text = ''
      [System.Environment]::SetEnvironmentVariable('PATH', $('{0}/.nix-profile/bin:/etc/profiles/per-user/{1}/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:' -f $HOME, $env:USER + $env:PATH), [System.EnvironmentVariableTarget]::Process)

      ${lib.concatStringsSep "\n" config.brooklyn.programs.powershell.extraConfig}
    '';
  };
}
