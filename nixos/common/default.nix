{ pkgs, lib, modulesPath, inputs, secrets, ... }:

{
  imports = [
    ./disk.nix
    ./display-manager.nix
    ./gui.nix
    ./hardware.nix
    ./keyboard.nix
    ./nix.nix
    ./services.nix
    ./university.nix
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

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    useDHCP = true;

    wireless = {
      enable = true;
      inherit (secrets) networks;
    };
  };

  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      ovmf.enable = true;
    };
  };

  services.udev.packages = with pkgs; [
    android-udev-rules
  ];

  environment.systemPackages = with pkgs; [
    git
    home-manager
  ];

  system.stateVersion = "24.05";
}
