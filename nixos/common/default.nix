{ pkgs, lib, modulesPath, inputs, secrets, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")

      inputs.nix-index-database.nixosModules.nix-index

      ./disko.nix
      ./graphical.nix
      ./keyboard.nix
      ./network.nix
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

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
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

  programs = {
    nix-index-database.comma.enable = true;
    nix-ld.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  nix = {
    optimise.automatic = true;

    gc = {
      automatic = true;
      options = "--delete-older-than 5d";
    };

    settings.experimental-features = [ "nix-command" "flakes" ];

    extraOptions = ''
      extra-substituters = https://devenv.cachix.org
      extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
    '';
  };

  system.stateVersion = "24.05";
}
