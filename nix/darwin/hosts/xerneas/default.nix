let
  omoOverrides = builtins.fromJSON (builtins.readFile ./config/opencode/oh-my-openagent.jsonc);
in
{
  imports = [
    ./brew.nix
    ../..
    ../../modules/sikarugir
    ../../../common/modules/opencode
  ];

  system.stateVersion = 6;

  networking.computerName = "Xerneas";

  brooklyn.programs = {
    crush.enable = true;
    opencode.enable = true;
    opencode.ohMyOpenAgentOverrides = omoOverrides;
    pi-coding-agent.enable = true;
    sikarugir.enable = true;
  };
}
