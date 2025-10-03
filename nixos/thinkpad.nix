{ names, pkgs, ... }:

{
  imports = [
    ./system
    ./config
  ];

  disko.devices.disk.main.device = "/dev/nvme0n1";

  services = {
    upower.enable = true;
    tp-auto-kbbl.enable = true;

    fprintd.enable = true;
  };

  systemd = {
    tmpfiles.rules = [
      "w /sys/class/leds/platform::mute/brightness - - - - 0"
      "w /sys/class/leds/platform::micmute/brightness - - - - 0"
    ];

    services.disable-power-led = {
      wantedBy = [ "multi-user.target" ];

      script = ''
        nice -n 19 /bin/sh ${pkgs.writeText "disable-power-led.sh" ''
          while true
            do
              echo 0 > /sys/class/leds/tpacpi::power/brightness
              sleep 5
            done
        ''}
      '';
    };
  };

  boot = {
    initrd.availableKernelModules = [ "nvme" ];
    kernelModules = [ "kvm-amd" ];
  };
}
