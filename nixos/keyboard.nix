{ inputs, ... }:

{
  console.keyMap = "fr";

  services = {
    xserver.xkb = {
      layout = "fr";
      variant = "";
    };

    kanata = {
      enable = false;

      keyboards.internal = {
        devices = [
          "/dev/input/event0"
        ];

        extraDefCfg = ''
          process-unmapped-keys yes
          windows-altgr cancel-lctl-press
        '';

        config = with inputs; ''
          (defvar
            tap_timeout 200
            hold_timeout 200
            long_hold_timeout 300
          )

          (include ${arsenik}/defsrc/pc_wide_anglemod.kbd)

          (include ${arsenik}/deflayer/base_lt_hrm.kbd)
          (include ${arsenik}/deflayer/symbols_noop.kbd)
          (include ${arsenik}/deflayer/navigation.kbd)

          (include ${arsenik}/defalias/ergol_pc.kbd)

          (defalias run ins)
        '';
      };
    };
  };
}
