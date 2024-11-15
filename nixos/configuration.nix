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

    useDHCP = false;
    dhcpcd.enable = false;

    networkmanager = {
      enable = true;

      dns = "none";
      wifi.powersave = true;
    };

    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "p7zip"
      "steam"
      "steam-unwrapped"
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
    p7zip-rar
    python3
    unzip
    vim
  ];

  system.stateVersion = "24.05";
}
