{ pkgs, ... }:

{
  imports = [
    ./disk.nix
    ./nix.nix
    ./peripherals.nix
    ./resources.nix
    ./startup.nix
    ./wireless.nix
  ];

  hardware.enableRedistributableFirmware = true;

  services.fwupd.enable = true;

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
