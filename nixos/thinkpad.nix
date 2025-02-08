{
  imports = [ ./common ];

  networking.hostName = "Victor-ThinkPad";

  systemd.services.disable-leds = {
    wantedBy = [ "multi-user.target" ];
    script = ''
      echo 0 > "/sys/class/leds/platform::mute/brightness"
      echo 0 > "/sys/class/leds/platform::micmute/brightness"
      while true
      do
        echo 0 > "/sys/class/leds/tpacpi::power/brightness"
        sleep 1
      done
    '';
  };
}
