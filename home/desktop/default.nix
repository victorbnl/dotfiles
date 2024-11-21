{
  imports = [
    ./dunst.nix
    ./i3.nix
    ./polybar.nix
    ./rofi.nix
    ./theme.nix
  ];

  xresources.properties = {
    "Xft.dpi" = 134;
  };

  services.picom = {
    enable = true;

    backend = "glx";
    vSync = true;
  };
}
