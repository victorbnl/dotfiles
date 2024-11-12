{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "Victor-PC";
    networkmanager.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  time.timeZone = "Europe/Paris";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };
  };

  services.displayManager.sddm = {
    enable = true;

    theme = "chili";
  };

  services.xserver = {
    enable = true;

    windowManager.i3.enable = true;

    xkb = {
      layout = "fr";
      variant = "afnor";
    };
  };

  console.keyMap = "fr";

  services.printing.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.victor = {
    isNormalUser = true;
    description = "Victor";
    extraGroups = [ "networkmanager" "wheel" ];

    packages = with pkgs; [
      ferdium
      gcc
      gimp
      pcmanfm
      python3
      vim
    ];
  };

  fonts.packages = with pkgs; [
    nerdfonts
    ubuntu_font_family
  ];

  environment.systemPackages = with pkgs; [
    sddm-chili-theme
  ];

  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;

  services.udisks2.enable = true;
  services.gvfs.enable = true;

  security.polkit.enable = true;

  qt = {
    platformTheme = "qt5ct";
    style = "kvantum";
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "vscode"
    ];

  system.stateVersion = "24.05";
}
