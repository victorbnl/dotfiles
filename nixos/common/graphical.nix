{ pkgs, ... }:

{
  imports = [
    ./sddm.nix
  ];

  environment.systemPackages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
  ];

  fonts.packages = [ pkgs.noto-fonts ];

  services = {
    xserver = {
      enable = true;

      desktopManager.wallpaper.mode = "fill";
      windowManager.i3.enable = true;
    };

    libinput.touchpad.naturalScrolling = true;
  };

  qt = {
    enable = true;

    platformTheme = "qt5ct";
    style = "kvantum";
  };
}
