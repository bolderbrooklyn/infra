{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ../brew
  ];

  options.brooklyn.programs.sikarugir.enable = lib.mkEnableOption "sikarugir";

  config = lib.mkIf config.brooklyn.programs.sikarugir.enable {
    nix-homebrew = {
      taps = {
        "Sikarugir-App/homebrew-sikarugir" = inputs.homebrew-sikarugir;
      };

      trust.taps = [ "Sikarugir-App/sikarugir" ];
    };

    homebrew.casks = [ "sikarugir" ];
  };
}
