{
  config,
  lib,
  ...
}:
let
  user = "kalmiya";
  home = "/home/${user}";
in
{
  options.brooklyn.programs.kalmiya.enable = lib.mkEnableOption "kalmiya service user";

  config = lib.mkIf config.brooklyn.programs.kalmiya.enable {
    users.users.${user} = {
      inherit home;

      isNormalUser = true;
      description = "Kalmiya service user";
      group = "users";
      linger = true;

      openssh.authorizedKeys.keys = [ ];
    };

    home-manager.users.${user} = import ../../../users/kalmiya/home.nix;
  };
}