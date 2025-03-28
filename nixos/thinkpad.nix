{ pkgs, ... }:

{
  imports = [ ./common ];

  networking.hostName = "Victor-ThinkPad";

  services.upower.enable = true;
  services.tp-auto-kbbl.enable = true;

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
}
