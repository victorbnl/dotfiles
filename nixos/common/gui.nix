{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.libsForQt5.qtstyleplugin-kvantum
  ];

  qt = {
    enable = true;

    platformTheme = "qt5ct";
    style = "kvantum";
  };

  fonts.packages = [ pkgs.noto-fonts ];

  services = {
    xserver = {
      enable = true;

      desktopManager.wallpaper.mode = "fill";
      windowManager.i3.enable = true;
    };

    libinput.touchpad.naturalScrolling = true;
  };
}
