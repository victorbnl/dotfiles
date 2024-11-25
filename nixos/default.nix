{ pkgs, lib, ... }:

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
    timeout = 0;
    efi.canTouchEfiVariables = true;

    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
  };

  zramSwap.enable = true;

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
      "spotify"
      "steam"
      "steam-unwrapped"
      "vscode"
      "vscode-extension-ms-vscode-cpptools"
    ];

  services.udev.packages = with pkgs; [
    android-udev-rules
  ];

  environment.systemPackages = with pkgs; [
    aria2
    file
    gcc
    htop
    unzip
    vim
  ];

  system.stateVersion = "24.05";
}
