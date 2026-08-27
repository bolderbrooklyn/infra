{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.btop.enable = lib.mkEnableOption "btop";

  config = {
    programs.btop = {
      inherit (config.brooklyn.programs.btop) enable;

      settings.vim_keys = true;

      package = lib.mkIf config.targets.genericLinux.gpu.nvidia.enable (
        pkgs.btop.overrideAttrs (old: {
          nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.patchelf ];
          postFixup = (old.postFixup or "") + ''
            ${pkgs.patchelf}/bin/patchelf \
              --add-rpath "/run/opengl-driver/lib" \
              $out/bin/btop
          '';
        })
      );
    };
  };
}
