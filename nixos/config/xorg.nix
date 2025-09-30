{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.libsForQt5.qtstyleplugin-kvantum
  ];

  fonts.packages = [ pkgs.noto-fonts ];

  services = {
    libinput.touchpad.naturalScrolling = true;

    xserver = {
      enable = true;

      desktopManager.wallpaper.mode = "fill";
      windowManager.i3.enable = true;
    };
  };

  qt = {
    enable = true;

    platformTheme = "qt5ct";
    style = "kvantum";
  };

  programs.light.enable = true;
}
