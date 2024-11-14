{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./graphical.nix
      ./hardware-configuration.nix
      ./localisation.nix
      ./services.nix
      ./users.nix
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

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "vscode"
    ];

  services.udev.packages = with pkgs; [
    android-udev-rules
  ];

  environment.systemPackages = with pkgs; [
    aria2
    htop
    gcc
    gparted
    python3
    unzip
    vim
  ];

  system.stateVersion = "24.05";
}
