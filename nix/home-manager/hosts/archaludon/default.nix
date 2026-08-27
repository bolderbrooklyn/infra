{ config, pkgs, ... }: {
  brooklyn.gui.enable = true;

  programs.btop.package = pkgs.btop.overrideAttrs (old: {
    nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.patchelf ];
    postFixup = (old.postFixup or "") + ''
      ${pkgs.patchelf}/bin/patchelf \
        --add-rpath "/run/opengl-driver/lib" \
        $out/bin/btop
    '';
  });

  programs.git.settings.gpg.ssh.program = "/opt/1Password/op-ssh-sign";

  services.syncthing.settings.folders = {
    "${config.brooklyn.homeDirectory}/Sync" = {
      id = "default";
      label = "Default";
      devices = [
        "frosmoth"
        "miraidon"
        "tinkaton"
        "xerneas"
      ];
    };

    "${config.xdg.userDirs.documents}/Obsidian" = {
      id = "obsidian";
      label = "Obsidian";
      devices = [
        "frosmoth"
        "kalmiya"
      ];
    };

    "/run/media/brooklyn/Storage/Emulation" = {
      id = "emulation";
      label = "Emulation";
      devices = [
        "frosmoth"
        "tinkaton"
      ];
    };
  };

  nixpkgs.config.nvidia.acceptLicense = true;

  targets.genericLinux = {
    enable = true;

    gpu.nvidia = {
      enable = true;
      sha256 = "sha256-suk1xmuDuwDAyFe8jg7g/VLekoa0DJzB7sKafOfrEW0=";
      version = "610.57.04";
    };
  };
}
