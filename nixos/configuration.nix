{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./home-manager.nix
      ./wireless-networks.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.wireless.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
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

  services.displayManager.sddm.enable = true;

  services.xserver = {
    enable = true;

    windowManager.i3.enable = true;
    windowManager.fluxbox.enable = true;

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
      pcmanfm
      vim
    ];
  };

  fonts.packages = with pkgs; [
    nerdfonts
    ubuntu_font_family
  ];

  environment.systemPackages = with pkgs; [
  ];

  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;

  qt = {
    platformTheme = "qt5ct";
    style = "kvantum";
  };

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  system.stateVersion = "24.05";
}
