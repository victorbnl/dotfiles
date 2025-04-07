{ pkgs, lib, inputs, ... }:

{
  imports =
    [
      inputs.nix-index-database.nixosModules.nix-index

      ./graphical.nix
      ./hardware-configuration.nix
      ./keyboard.nix
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

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.udev.packages = with pkgs; [
    android-udev-rules
  ];

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  programs = {
    nix-index-database.comma.enable = true;
    nix-ld.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  nix.extraOptions = ''
    extra-substituters = https://devenv.cachix.org
    extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
  '';

  system.stateVersion = "24.05";
}
