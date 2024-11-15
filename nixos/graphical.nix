{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    sddm-chili-theme
  ];

  fonts.packages = with pkgs; [
    nerdfonts
    ubuntu_font_family
  ];

  services = {
    displayManager.sddm = {
      enable = true;
      theme = "chili";
    };

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
}
