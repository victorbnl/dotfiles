{ pkgs, root, ... }:

{
  imports = [
    ./appearance.nix
    ./dunst.nix
    ./i3.nix
    ./polybar.nix
    ./rofi.nix
  ];

  home.backgroundImage = root + /assets/wallpapers/desktop.jpg;

  xresources.properties = {
    "Xft.dpi" = 134;
  };

  services = {
    batsignal = {
      enable = true;

      extraArgs = [
        "-I" "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/32x32/symbolic/status/battery-caution-symbolic.svg"
      ];
    };

    picom = {
      enable = true;

      backend = "glx";
      vSync = true;
    };

    redshift = {
      enable = true;

      dawnTime = "08:00";
      duskTime = "20:00";
    };
  };
}
