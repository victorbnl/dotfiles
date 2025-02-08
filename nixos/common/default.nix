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

  virtualisation.virtualbox.host.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.udev.packages = with pkgs; [
    android-udev-rules
  ];

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  programs.nix-index-database.comma.enable = true;
  programs.nix-ld.enable = true;

  system.stateVersion = "24.05";
}
