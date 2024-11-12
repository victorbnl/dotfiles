{
  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  services = {
    power-profiles-daemon.enable = false;
    tlp.enable = true;

    udisks2.enable = true;
    gvfs.enable = true;

    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
