{ localpkgs, ... }:

{
  imports = [
    ./dunst.nix
    ./i3.nix
    ./polybar.nix
    ./rofi.nix
    ./theme.nix
  ];

  home.packages = with localpkgs; [
    rofi-power-menu
    rofi-vscode
  ];

  xresources.properties = {
    "Xft.dpi" = 134;
  };

  services = {
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
