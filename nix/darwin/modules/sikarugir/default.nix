{ inputs, ... }:
{
  imports = [
    ../brew
  ];

  nix-homebrew = {
    taps = {
      "Sikarugir-App/homebrew-sikarugir" = inputs.homebrew-sikarugir;
    };

    trust.taps = [ "Sikarugir-App/sikarugir" ];
  };

  homebrew.casks = [ "sikarugir" ];
}
