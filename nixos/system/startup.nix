{ pkgs, root, ... }:

{
  boot.loader = {
    timeout = 0;
    efi.canTouchEfiVariables = true;

    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtquickcontrols

    (sddm-chili-theme.override {
      themeConfig = {
        background = root + /assets/wallpapers/display-manager.jpg;
      };
    })
  ];

  services.displayManager.sddm = {
    enable = true;

    theme = "chili";

    settings = {
      Theme = {
        FacesDir = "${root + /assets/account-icons}";
      };
    };
  };
}
