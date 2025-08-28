{ ... }:
{
  home.shellAliases = {
    pbc = "pbcopy";
    pbp = "pbpaste";
  };

  imports = [
    ./brew.nix
  ];
}
